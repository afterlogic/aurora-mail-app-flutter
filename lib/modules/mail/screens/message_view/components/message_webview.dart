//@dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/calendar_select_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/screens/message_view/dialog/import_vcf.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_key_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/extensions/bloc_provider_extensions.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'attachments_dialog.dart';

class _Attendee {
  const _Attendee({this.email, this.displayName});
  final String email;
  final String displayName;

  factory _Attendee.fromJson(Map<String, dynamic> json) {
    return _Attendee(
        email: json["Email"] as String,
        displayName: json["DisplayName"] as String);
  }
}

// class _ExtendedForEvent{
//   // Attendee: null
//   // [{DisplayName: "vasil@afterlogic.com", Email: "vasil@afterlogic.com"}]
//   final List<_Attendee> attendeeList;
//   CalendarId: ""
//   Description: "111"
//   File: "ef3618d2c03cfd5c132d55de84e9c871.ics"
//   Location: "222"
//   Organizer: {DisplayName: "", Email: "test@afterlogic.com"}
//   Sequence: 1
//   Summary: "test"
//   Type: "REQUEST"
//   Uid: "0d39c75b-d6dd-42d3-ab32-595c08857b46"
//   When: "Tue, Aug 20, 2024"
// }

class ExpandedEventWebViewActions {
  static const DROPDOWN_CLICKED =
      "ExpandedEventWebViewActions.DROPDOWN_CLICKED";
  static const ACCEPT = "ExpandedEventWebViewActions.ACCEPT";
  static const DECLINE = "ExpandedEventWebViewActions.DECLINE";
  static const TENTATIVE = "ExpandedEventWebViewActions.TENTATIVE";
  static const CHANNEL = "EXPANDED_EVENT_WEB_VIEW_JS_CHANNEL";
}

class MessageWebViewActions {
  static const ACTION = "action:";
  static const SET_STARRED = "MessageWebViewActions.STARRED";
  static const SET_NOT_STARRED = "MessageWebViewActions.NOT_STARRED";
  static const SHOW_ATTACHMENTS = "MessageWebViewActions.SHOW_ATTACHMENTS";
  static const SHOW_INFO = "MessageWebViewActions.SHOW_INFO";
  static const DOWNLOAD_ATTACHMENT =
      "MessageWebViewActions.DOWNLOAD_ATTACHMENT";
  static const WEB_VIEW_JS_CHANNEL = "WEB_VIEW_JS_CHANNEL";
}

class MessageWebView extends StatefulWidget {
  final Message message;
  final List<MailAttachment> attachments;
  final String decrypted;
  final PgpSettingsBloc bloc;
  final ContactsBloc contactsBloc;
  final MessageViewBloc messageViewBloc;

  const MessageWebView(
    this.message,
    this.attachments,
    this.decrypted,
    this.bloc,
    this.contactsBloc,
    this.messageViewBloc, {
    Key key,
  }) : super(key: key);

  @override
  MessageWebViewState createState() => MessageWebViewState();
}

class MessageWebViewState extends BState<MessageWebView> {
  WebViewController _controller;
  String _htmlData;
  bool _pageLoaded = false;
  bool showImages = false;
  bool _isStarred;
  ThemeData theme;
  MailBloc _mailBloc;
  CalendarsBloc _calendarsBloc;
  List<ViewCalendar> _calendars;
  ViewCalendar _selectedCalendar;
  String _currentUserMail;
  Map<String, dynamic> _eventFromExpandedMail;

  @override
  void initState() {
    super.initState();
    _calendarsBloc = BlocProviderExtensions.tryOf<CalendarsBloc>(context);
    _calendars = _calendarsBloc != null
        ? _calendarsBloc.state.availableCalendars(_currentUserMail)
        : null;
    _selectedCalendar = (_calendars?.isEmpty ?? true) ? null : _calendars[0];
    onLoad();
    // On Android, hybrid composition (SurfaceAndroidWebView) is now the default (webview_flutter 3.0.0)
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _eventFromExpandedMail = MailUtils.getExtendFromMessageByObjectTypeName(
        ['Object/Aurora\\Modules\\Calendar\\Classes\\Ics'], widget.message);
    _currentUserMail =
        BlocProvider.of<AuthBloc>(context).currentUser?.emailFromLogin ?? '';
    _isStarred = widget.message.flagsInJson.contains("\\flagged");
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {
              if (mounted) setState(() => _pageLoaded = true);
            },
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: _onWebViewNavigateRequestIos),
      );
    _controller.addJavaScriptChannel(ExpandedEventWebViewActions.CHANNEL,
        onMessageReceived: (message) {
      if(_selectedCalendar == null) return;
      if (message.message.startsWith(ExpandedEventWebViewActions.ACCEPT)) {
        print(message.message);
        BlocProvider.of<MessageViewBloc>(context).add(ChangeEventInviteStatus(
            status: 'ACCEPT',
            calendarId: _selectedCalendar.id,
            fileName: _eventFromExpandedMail['File'] as String));
      } else if (message.message
          .startsWith(ExpandedEventWebViewActions.DECLINE)) {
        BlocProvider.of<MessageViewBloc>(context).add(ChangeEventInviteStatus(
            status: 'DECLINE',
            calendarId: _selectedCalendar.id,
            fileName: _eventFromExpandedMail['File'] as String));
      } else if (message.message
          .startsWith(ExpandedEventWebViewActions.TENTATIVE)) {
        BlocProvider.of<MessageViewBloc>(context).add(ChangeEventInviteStatus(
            status: 'TENTATIVE',
            calendarId: _selectedCalendar.id,
            fileName: _eventFromExpandedMail['File'] as String));
      } else if (message.message
          .startsWith(ExpandedEventWebViewActions.DROPDOWN_CLICKED)) {
        _invokeSelectCalendarDialog();
      }
    });
    _controller.addJavaScriptChannel("WEB_VIEW_JS_CHANNEL",
        onMessageReceived: (message) {
      if (message.message
          .startsWith(MessageWebViewActions.DOWNLOAD_ATTACHMENT)) {
        final downloadUrl = message.message
            .substring(MessageWebViewActions.DOWNLOAD_ATTACHMENT.length);
        _startDownload(downloadUrl);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showImages = !widget.message.hasExternals || widget.message.safety;
    theme = Theme.of(context);
    _mailBloc = BlocProvider.of(context);
    _controller.setBackgroundColor(theme.scaffoldBackgroundColor);
    _getHtmlWithImages();
  }

  @override
  void didUpdateWidget(MessageWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.decrypted != widget.decrypted ||
        oldWidget.message != widget.message) {
      _controller.setBackgroundColor(theme.scaffoldBackgroundColor);
      _getHtmlWithImages();
      setState(() {});
    }
  }

  void _invokeSelectCalendarDialog() {
    CalendarSelectDialog.show(context,
            initialValue: _selectedCalendar, options: _calendars)
        .then((value) {
      if (value != null) {
        _selectedCalendar = value;
        _controller.runJavaScript("setSelectedCalendar('${value.name}')");
      }
      ;
    });
  }

  void _getHtmlWithImages() async {
    String htmlData;
    if (widget.decrypted != null) {
      htmlData = widget.decrypted;
      _htmlData = htmlData;
      _controller?.loadRequest(Uri.parse(_getHtmlUri(htmlData)));
      if (mounted) setState(() {});
      return;
    } else {
      htmlData = widget.message.htmlBody;
    }

    if (showImages) {
      htmlData = htmlData
          .replaceAll("data-x-src=", "src=")
          .replaceAll("src=\"http:", "src=\"https:");

      final document = html.parse(htmlData);

      void getAllChildren(nodes) {
        nodes.forEach((c) {
          c.nodes.forEach((node) {
            if (node.attributes.containsKey("data-x-style-url") as bool) {
              var backgroundImageUrl =
                  node.attributes["data-x-style-url"] as String;
              backgroundImageUrl =
                  backgroundImageUrl.replaceAll("http://", "https://");
              node.attributes.remove("data-x-style-url");

              String style = node.attributes["style"] as String;
              style = style.endsWith(";") ? style : style + "; ";
              style += backgroundImageUrl;
              node.attributes["style"] = style;
            }
          });

          getAllChildren(c.nodes);
        });
      }

      getAllChildren(document.nodes.toList());
      htmlData = document.outerHtml;
    }

    final user = BlocProvider.of<AuthBloc>(context).currentUser;

    for (final attachment in widget.attachments) {
      htmlData = htmlData.replaceFirst(
        "data-x-src-cid=\"${attachment.cid}\"",
        "src=\"${user.hostname}${attachment.viewUrl.replaceFirst("mail-attachment/", "mail-attachments-cookieless/")}&AuthToken=${user.token}\"",
      );
    }

    if (_htmlData != null) {
      _controller?.loadRequest(Uri.parse(_getHtmlUri(htmlData)));
    }
    if (mounted) setState(() => _htmlData = htmlData);
  }

  String _formatTo(Message message) {
    final items = Mail.getToForDisplay(
      context,
      message.toInJson,
      BlocProvider.of<AuthBloc>(context).currentAccount.email,
    );

    if (items.isEmpty) {
      return S.of(context).messages_no_receivers;
    } else {
      return items.join(", ");
    }
  }

  String _getHtmlUri(String html) {
    final state = BlocProvider.of<SettingsBloc>(context).state;

    final date = DateFormatting.getDetailedMessageDate(
      timestamp: widget.message.timeStampInUTC,
      locale: Localizations.localeOf(context).languageCode,
      yesterdayWord: S.of(context).label_message_yesterday,
      is24: (state as SettingsLoaded).is24 ?? true,
    );

    final message = widget.message.copyWith(
      folder: _mailBloc.selectedFolder.displayName(context),
    );

    final wrappedHtml = MailUtils.wrapInHtml(
      context,
      message: message,
      to: _formatTo(message),
      date: date,
      body: html,
      extendedEvent: _eventFromExpandedMail,
      initCalendar: _selectedCalendar,
      attachments: widget.attachments.toList(),
      showLightEmail: false,
      isStarred: _isStarred,
    );
    return Uri.dataFromString(wrappedHtml,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  void _startDownload(String downloadUrl) async {
    final attachment = widget.attachments
        .firstWhere((a) => !a.isInline && a.downloadUrl == downloadUrl);
    if (attachment.fileName.endsWith(".asc")) {
      final keys = await widget.bloc.sortKey(attachment.location);
      await showDialog(
        context: context,
        builder: (_) =>
            ImportKeyDialog(keys.userKeys, keys.contactKeys, widget.bloc),
      );
    } else if (attachment.fileName.endsWith(".vcf")) {
      final msg =
          S.of(context).messages_attachment_downloading(attachment.fileName);
      Fluttertoast.showToast(
        msg: msg,
        timeInSecForIosWeb: 2,
        backgroundColor:
            Platform.isIOS ? theme.disabledColor.withOpacity(0.5) : null,
      );

      BlocProvider.of<MessageViewBloc>(context).downloadAttachment(
        attachment,
        (path) async {
          String content =
              Platform.isIOS ? path : await File(path).readAsString();
          final result = await dialog(
            context: context,
            builder: (_) =>
                ImportVcfDialog(bloc: widget.contactsBloc, content: content),
          );
          if (result is ErrorToShow) {
            showErrorSnack(
              isError: true,
              context: context,
              scaffoldState: Scaffold.of(context),
              msg: result,
            );
          } else {
            showSnack(
              isError: false,
              context: context,
              scaffoldState: Scaffold.of(context),
              message: S.of(context).label_contacts_were_imported_successfully,
            );
          }
        },
        Rect.fromCenter(
          center: MediaQuery.of(context).size.bottomCenter(Offset.zero),
          width: 0,
          height: 0,
        ),
      );
    } else {
      BlocProvider.of<MessageViewBloc>(context).add(
        DownloadAttachment(
          attachment,
          Rect.fromCenter(
            center: MediaQuery.of(context).size.bottomCenter(Offset.zero),
            width: 0,
            height: 0,
          ),
        ),
      );
      final msg =
          S.of(context).messages_attachment_downloading(attachment.fileName);
      Fluttertoast.showToast(
        msg: msg,
        timeInSecForIosWeb: 2,
        backgroundColor:
            Platform.isIOS ? theme.disabledColor.withOpacity(0.5) : null,
      );
    }
  }

  setStarred(bool isStarred) {
    _isStarred = isStarred;
    _mailBloc.add(SetStarred([widget.message], isStarred));
  }

  FutureOr<NavigationDecision> _onWebViewNavigateRequestIos(
      NavigationRequest request) async {
    if (request.url.startsWith(MessageWebViewActions.ACTION)) {
      final action = request.url.substring(MessageWebViewActions.ACTION.length);
      if (action == MessageWebViewActions.SET_STARRED) {
        setStarred(true);
      } else if (action == MessageWebViewActions.SET_NOT_STARRED) {
        setStarred(false);
      }
      print(action);
      return NavigationDecision.prevent;
    } else if (request.url.endsWith(MessageWebViewActions.SHOW_INFO)) {
      // TODO: implement showing message info
      return NavigationDecision.prevent;
    } else if (request.url.endsWith(MessageWebViewActions.SHOW_ATTACHMENTS)) {
      final messageViewBloc = BlocProvider.of<MessageViewBloc>(context);
      AttachmentsDialog.show(context, widget.attachments, messageViewBloc);
      return NavigationDecision.prevent;
    } else if (request.url != _getHtmlUri(_htmlData)) {
      launch(request.url);
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }

  Future onLoad() async {
    if (widget.message.hasExternals == true) {
      showImages =
          await widget.messageViewBloc.checkInWhiteList(widget.message);
      _getHtmlWithImages();
      if (mounted) setState(() {});
    } else {
      _getHtmlWithImages();
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.message.hasExternals && !showImages)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6.0),
            color: Color(0xFFffffc5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  S.of(context).messages_images_security_alert,
                  style: TextStyle(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => showImages = true);
                    _getHtmlWithImages();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      S.of(context).messages_show_images,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => showImages = true);
                    widget.messageViewBloc.add(AddInWhiteList(widget.message));
                    _getHtmlWithImages();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      S.of(context).messages_always_show_images,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        Flexible(
          child: Stack(
            children: [
              WebViewWidget(
                key: Key(widget.message.uid.toString()),
                controller: _controller,
                gestureRecognizers: {
                  Factory<LongPressGestureRecognizer>(
                      () => LongPressGestureRecognizer()..onLongPress = () {}),
                },
              ),
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: AnimatedOpacity(
                    opacity: _pageLoaded && _htmlData != null ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 100),
                    child: Container(color: theme.scaffoldBackgroundColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  dynamic firstOrNull(dynamic list) {
    if (list != null && list is List) {
      if (list.isNotEmpty) {
        return list.first;
      }
    }
    return null;
  }

  var routeCount = 0;
}
