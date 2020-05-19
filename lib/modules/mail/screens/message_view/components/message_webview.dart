import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/database/mail/mail_table.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/contacts_bloc.dart';
import 'package:aurora_mail/modules/contacts/contacts_domain/models/contact_model.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/message_view_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/settings/blocs/pgp_settings/pgp_settings_bloc.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/import_key_dialog.dart';
import 'package:aurora_mail/shared_ui/confirmation_dialog.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/date_formatting.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:vcf/vcf.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'attachments_dialog.dart';

class MessageWebViewActions {
  static const ACTION = "action:";
  static const SET_STARED = "MessageWebViewActions.STARED";
  static const SET_NOT_STARED = "MessageWebViewActions.NOT_STARED";
  static const SHOW_ATTACHMENTS = "MessageWebViewActions.SHOW_ATTACHMENTS";
  static const SHOW_INFO = "MessageWebViewActions.SHOW_INFO";
  static const DOWNLOAD_ATTACHMENT =
      "MessageWebViewActions.DOWNLOAD_ATTACHMENT";
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
  _MessageWebViewState createState() => _MessageWebViewState();
}

class _MessageWebViewState extends BState<MessageWebView> {
  WebViewController _controller;
  String _htmlData;
  bool _pageLoaded = false;
  bool _showImages = false;
  bool _isStared;
  ThemeData theme;
  MailBloc _mailBloc;

  @override
  void initState() {
    super.initState();
    onLoad();
    _isStared = widget.message.flagsInJson.contains("\\flagged");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _showImages = !widget.message.hasExternals || widget.message.safety;
    theme = Theme.of(context);
    _mailBloc = BlocProvider.of(context);
    _getHtmlWithImages();
  }

  @override
  void didUpdateWidget(MessageWebView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.decrypted != widget.decrypted ||
        oldWidget.message != widget.message) {
      _getHtmlWithImages();
      setState(() {});
    }
  }

  void _getHtmlWithImages() async {
    String htmlData;
    if (widget.decrypted != null) {
      htmlData = widget.decrypted;
      _htmlData = htmlData;
      _controller?.loadUrl(_getHtmlUri(htmlData));
      setState(() {});
      return;
    } else {
      htmlData = widget.message.htmlBody;
    }

    if (_showImages) {
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
      _controller?.loadUrl(_getHtmlUri(htmlData));
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
      return i18n(context, "messages_no_receivers");
    } else {
      return items.join(", ");
    }
  }

  String _getHtmlUri(String html) {
    final state = BlocProvider.of<SettingsBloc>(context).state;

    final date = DateFormatting.getDetailedMessageDate(
      timestamp: widget.message.timeStampInUTC,
      locale: Localizations.localeOf(context).languageCode,
      yesterdayWord: i18n(context, "label_message_yesterday"),
      is24: (state as SettingsLoaded).is24 ?? true,
    );

    final wrappedHtml = MailUtils.wrapInHtml(
      context,
      message: widget.message,
      to: _formatTo(widget.message),
      date: date,
      body: html,
      attachments: widget.attachments.toList(),
      showLightEmail: false,
      isStared:_isStared,
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
            ImportKeyDialog(keys.contactKeys, keys.contactKeys, widget.bloc),
      );
    } else if (attachment.fileName.endsWith(".vcf")) {
      final msg = i18n(context, "messages_attachment_downloading",
          {"fileName": attachment.fileName});
      Fluttertoast.showToast(
        msg: msg,
        timeInSecForIos: 2,
        backgroundColor:
            Platform.isIOS ? theme.disabledColor.withOpacity(0.5) : null,
      );
      BlocProvider.of<MessageViewBloc>(context).downloadAttachment(
        attachment,
        (path) async {
          try {
            String content =
                Platform.isIOS ? path : await File(path).readAsString();
            final vcf = Vcf.fromString(content);
            await importContactFromVcf(context, vcf, widget.contactsBloc);
          } catch (e) {}
        },
      );
    } else {
      BlocProvider.of<MessageViewBloc>(context)
          .add(DownloadAttachment(attachment));
      final msg = i18n(context, "messages_attachment_downloading",
          {"fileName": attachment.fileName});
      Fluttertoast.showToast(
        msg: msg,
        timeInSecForIos: 2,
        backgroundColor:
            Platform.isIOS ? theme.disabledColor.withOpacity(0.5) : null,
      );
    }
  }

  setStared(bool isStared) {
    _isStared = isStared;
    _mailBloc.add(SetStarred([widget.message], isStared));
    _getHtmlWithImages();
  }

  FutureOr<NavigationDecision> _onWebViewNavigateRequestIos(
      NavigationRequest request) async {
    if (request.url.startsWith(MessageWebViewActions.ACTION)) {
      final action = request.url.substring(MessageWebViewActions.ACTION.length);
      if (action == MessageWebViewActions.SET_STARED) {
        setStared(true);
      } else if (action == MessageWebViewActions.SET_NOT_STARED) {
        setStared(false);
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
    } else if (request.url
        .endsWith(MessageWebViewActions.DOWNLOAD_ATTACHMENT)) {
      final parts =
          request.url.split(MessageWebViewActions.DOWNLOAD_ATTACHMENT);
      final downloadUrl = parts[parts.length - 2];
      _startDownload(downloadUrl);
      return NavigationDecision.prevent;
    } else if (request.url != _getHtmlUri(_htmlData)) {
      launch(request.url);
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }

  Future onLoad() async {
    if (widget.message.hasExternals) {
      _showImages =
          await widget.messageViewBloc.checkInWhiteList(widget.message);
      _getHtmlWithImages();
      setState(() {});
    } else {
      _getHtmlWithImages();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.message.hasExternals && !_showImages)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6.0),
            color: Color(0xFFffffc5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  i18n(context, "messages_images_security_alert"),
                  style: TextStyle(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => _showImages = true);
                    _getHtmlWithImages();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      i18n(context, "messages_show_images"),
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => _showImages = true);
                    widget.messageViewBloc.add(AddInWhiteList(widget.message));
                    _getHtmlWithImages();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      i18n(context, "messages_always_show_images"),
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
              WebView(
                key: Key(widget.message.uid.toString()),
                initialUrl: _getHtmlUri(_htmlData),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController c) => _controller = c,
                navigationDelegate: _onWebViewNavigateRequestIos,
                onPageFinished: (_) async => setState(() => _pageLoaded = true),
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

  Future importContactFromVcf(
    BuildContext context,
    Vcf vcf,
    ContactsBloc bloc,
  ) async {
    final contact = Contact(
      entityId: null,
      viewEmail: firstOrNull(vcf.email) as String,
      frequency: 0,
      davContactsVCardUid: null,
      eTag: "",
      pgpPublicKey: null,
      davContactsUid: null,
      useFriendlyName: true,
      idUser: bloc.user.serverId,
      groupUUIDs: <String>[],
      userLocalId: bloc.user.localId,
      idTenant: null,
      fullName: vcf.formattedName,
      dateModified: DateTime.now().toIso8601String(),
      uuidPlusStorage: null,
      uuid: null,
      storage: StorageNames.personal,
    ).copyWith(
      entityId: null,
      parentUuid: null,
      title: "",
      firstName: vcf.firstName,
      lastName: vcf.lastName,
      nickName: vcf.nickname,
      skype: (vcf.socialUrls == null ? null : vcf.socialUrls["skype"]) ?? "",
      facebook:
          (vcf.socialUrls == null ? null : vcf.socialUrls["facebook"]) ?? "",
      personalEmail: firstOrNull(vcf.email) as String,
      personalAddress: vcf.homeAddress?.format(),
      personalCity: vcf.homeAddress?.city,
      personalState: vcf.homeAddress?.stateProvince,
      personalZip: vcf.homeAddress?.postalCode,
      personalCountry: vcf.homeAddress?.countryRegion,
      personalWeb: vcf.url ?? "",
      personalFax: (firstOrNull(vcf.homeFax) as String) ?? "",
      personalPhone: (firstOrNull(vcf.homePhone) as String) ?? "",
      personalMobile: "",
      businessEmail: firstOrNull(vcf.workEmail) as String,
      businessCompany: "",
      businessAddress: vcf.workAddress?.format(),
      businessCity: vcf.workAddress?.city,
      businessState: vcf.workAddress?.stateProvince,
      businessZip: vcf.workAddress?.postalCode,
      businessCountry: vcf.workAddress?.countryRegion,
      businessJobTitle: "",
      businessDepartment: "",
      businessOffice: "",
      businessPhone: (firstOrNull(vcf.workPhone) as String) ?? "",
      businessFax: (firstOrNull(vcf.workFax) as String) ?? "",
      businessWeb: "",
      otherEmail: firstOrNull(vcf.otherEmail) as String,
      notes: vcf.note,
      birthDay: (vcf.birthday?.millisecondsSinceEpoch) ?? 0,
      birthMonth: (vcf.birthday?.month) ?? 0,
      birthYear: (vcf.birthday?.year) ?? 0,
      auto: null,
    );
    final result = await ConfirmationDialog.show(
      context,
      null,
      i18n(context, "hint_vcf_import", {
        "name": contact.fullName ?? contact.nickName ?? contact.viewEmail ?? ""
      }),
      i18n(context, "btn_vcf_import"),
    );
    if (result == true) {
      bloc.add(CreateContact(contact));
    }
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
