import 'dart:async';
import 'dart:io';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/inject/app_inject.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/dialog_wrap.dart';
import 'package:aurora_mail/modules/layout_config/layout_config.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/messages_list_bloc/messages_list_event.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/automatically_encrypt_label.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/compose_bottom_bar.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/discard_compose_changes_dialog.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/identity_selector.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/web_view_wrap.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/compose/dialog/encrypt_dialog.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/bloc/self_destructing_bloc.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/bloc/self_destructing_state.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/encrypt_setting.dart';
import 'package:aurora_mail/modules/mail/screens/compose/self_destructing/view_password.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/screens/pgp_settings/dialogs/key_request_dialog.dart';
import 'package:aurora_mail/res/str/s.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/error_to_show.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:aurora_ui_kit/components/am_fab.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/app_theme.dart';

import 'components/compose_app_bar.dart';
import 'components/compose_attachment_item.dart';
import 'components/compose_emails.dart';
import 'components/compose_subject.dart';
import 'components/compose_web_view.dart';

class ComposeAndroid extends StatefulWidget {
  final ComposeAction composeAction;
  final User user;
  final Account account;

  ComposeAndroid(
    this.user,
    this.account, {
    Key key,
    this.composeAction,
  }) : super(key: key);

  @override
  _ComposeAndroidState createState() => _ComposeAndroidState();
}

class _ComposeAndroidState extends BState<ComposeAndroid>
    with NotSavedChangesMixin {
  Aliases alias;
  AccountIdentity identity;
  ComposeBloc _bloc;

  final toNode = FocusNode();
  final ccNode = FocusNode();
  final bccNode = FocusNode();
  final subjectNode = FocusNode();
  final bodyNode = FocusNode();
  bool automaticallyEncrypt = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Timer _timer;
  EncryptType _encryptType = EncryptType.None;
  String decryptTitle;
  String decryptBody;
  bool _showBCC = false;

  // if compose was opened from screen which does not have MessagesListRoute in stack, just pop
  bool _returnToMessagesList = true;
  int _currentDraftUid;
  Message _message;

  final _toEmails = new Set<String>();
  final _ccEmails = new Set<String>();
  final _bccEmails = new Set<String>();
  final _attachments = new List();
  List _savedAttachments;
  final _toKey = new GlobalKey<ComposeEmailsState>();
  final _ccKey = new GlobalKey<ComposeEmailsState>();
  final _bccKey = new GlobalKey<ComposeEmailsState>();
  final _toTextCtrl = new TextEditingController();
  final _ccTextCtrl = new TextEditingController();
  final _bccTextCtrl = new TextEditingController();
  final _subjectTextCtrl = new TextEditingController();
  final _bodyTextCtrl = ComposeWebViewController();
  final _fromCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = ComposeBloc(
      user: widget.user,
      account: widget.account,
    );
    _initSaveToDraftsTimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      await setIdentityOrSender(
          AliasOrIdentity(null, authBloc.currentIdentity));
      _prepareMessage();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) _timer.cancel();
    _bloc.close();

    ccNode.dispose();
    toNode.dispose();
    bccNode.dispose();
    bodyNode.dispose();
  }

  void _prepareMessage() async {
    final action = widget.composeAction;
    print('_prepareMessage, action is ${action.runtimeType}');

    if (action is OpenFromDrafts) await _initFromDrafts(action);
    if (action is Forward) await _initForward(action);
    if (action is Reply) await _initReply(action);
    if (action is ReplyToAll) await _initReplyAll(action);
    if (action is EmailToContacts) await _initFromContacts(action);
    if (action is SendContacts) await _initContactsAsAttachments(action);
    if (action is Resend) await _initResend(action);
    if (action is InitWithAttachment) await _initWithAttachment(action);
    if (action is ForwardAsAttachment) await _forwardAsAttachment(action);
  }

  void _initWithAttachment(InitWithAttachment action) {
    initBody(action.message.join("\n\n"));
    _bloc.add(UploadAttachments(action.files));
  }

  void _forwardAsAttachment(ForwardAsAttachment action) {
    _bloc.add(UploadEmlAttachments(action.message));
  }

  void _initFromDrafts(OpenFromDrafts action) async {
    _currentDraftUid = action.draftUid;
    _message = action.message;

    final str = action.message.attachmentsInJson;
    final attachments = MailAttachment.fromJsonString(str);
    _bloc.add(GetComposeAttachments(attachments));
    if (_toEmails.isEmpty) {
      setState(() {
        _toEmails.addAll(MailUtils.getEmails(_message.toInJson));
      });
    }
    if (_ccEmails.isEmpty) {
      setState(() {
        _ccEmails.addAll(MailUtils.getEmails(_message.ccInJson));
      });
    }
    if (_bccEmails.isEmpty) {
      setState(() {
        _bccEmails.addAll(MailUtils.getEmails(_message.bccInJson));
      });
    }
    _subjectTextCtrl.text = _message.subject;
    initBodyFromMessage(_message.htmlBody, _message);
  }

  void _initForward(Forward action) async {
    _message = action.message;
    _bodyTextCtrl.showImage = action.showImage;
    _bloc.add(GetMessageAttachments(_message));
    _subjectTextCtrl.text = MailUtils.getForwardSubject(_message);
    initBodyFromMessage(MailUtils.getForwardBody(context, _message), _message);
  }

  void _initReply(Reply action) async {
    _message = action.message;
    _bodyTextCtrl.showImage = action.showImage;
    await _initSender(_message);
    if (_toEmails.isEmpty) {
      setState(() {
        _toEmails.addAll(MailUtils.getEmails(_message.fromInJson));
      });
    }
    _subjectTextCtrl.text = MailUtils.getReplySubject(_message);
    initBodyFromMessage(MailUtils.getReplyBody(context, _message), _message);
  }

  void _initResend(Resend action) async {
    _message = action.message;
    _bodyTextCtrl.showImage = action.showImage;
    await _initSender(_message);
    if (_toEmails.isEmpty) {
      setState(() {
        _toEmails.addAll(MailUtils.getEmails(_message.toInJson));
      });
    }
    _subjectTextCtrl.text = MailUtils.htmlToPlain(_message.subject);
    initBodyFromMessage(_message.htmlBody, _message);
  }

  void _initReplyAll(ReplyToAll action) async {
    _message = action.message;
    _bodyTextCtrl.showImage = action.showImage;
    await _initSender(_message);
    if (_toEmails.isEmpty) {
      setState(() {
        _toEmails.addAll(MailUtils.getEmails(_message.fromInJson));
      });
    }
    if (_ccEmails.isEmpty) {
      setState(() {
        _ccEmails.addAll(MailUtils.getEmails(_message.toInJson, exceptEmails: [
          AliasOrIdentity(alias, identity).mail,
        ]));
        _ccEmails.addAll(MailUtils.getEmails(_message.ccInJson));
      });
    }
    _subjectTextCtrl.text = MailUtils.getReplySubject(_message);
    initBodyFromMessage(MailUtils.getReplyBody(context, _message), _message);
  }

  void _initFromContacts(EmailToContacts action) {
    _returnToMessagesList = false;
    if (_toEmails.isEmpty) {
      setState(() {
        _toEmails.addAll(action.emails);
      });
    }
  }

  void _initContactsAsAttachments(SendContacts action) {
    _returnToMessagesList = false;
    _bloc.add(GetContactsAsAttachments(action.contacts));
  }

  void _initSaveToDraftsTimer() async {
    _timer = Timer.periodic(
      SAVE_TO_DRAFTS_PERIOD,
      (Timer timer) => _saveToDrafts(),
    );
  }

  Future _initSender(Message message) async {
    if (message.toInJson?.isNotEmpty == true) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      final items = await authBloc.getAliasesAndIdentities();
      final identity = MailUtils.findIdentity(message.toInJson, items);
      setIdentityOrSender(
        identity ?? AliasOrIdentity(null, authBloc.currentIdentity),
      );
    }
  }

  void _onAppBarActionSelected(ComposeAppBarAction action) {
    switch (action) {
      case ComposeAppBarAction.saveToDrafts:
        _saveToDrafts();
        break;
      case ComposeAppBarAction.cancel:
        // Navigator.pop(context);
        // _saveToDrafts();
        _onGoBack();
        break;
      case ComposeAppBarAction.send:
        _sendMessage();
        break;
    }
  }

  void _setUploadProgress(TempAttachmentUpload tempAttachment) {
    setState(() => _attachments.add(tempAttachment));
  }

  void _onAttachmentUploaded(ComposeAttachment attachment) {
    final i = _attachments.indexWhere((a) => a.guid == attachment.guid);
    setState(() {
      _attachments.removeAt(i);
      _attachments.add(attachment);
    });
  }

  void _cancelAttachment(dynamic attachment) async {
    setState(() {
      _attachments.removeWhere((a) => a.guid == attachment.guid);
    });
  }

  void initBodyFromMessage(String text, Message message) async {
    final user = BlocProvider.of<AuthBloc>(context).currentUser;
    try {
      final body = await _bodyTextCtrl.getText() + "<br>" + text;
      _bodyTextCtrl.setMessage(
        body,
        message,
        user,
      );
    } catch (e) {
      print(e);
    }
  }

  void initBody(String text) async {
    _bodyTextCtrl.setText(await _bodyTextCtrl.getText() + "<br>" + text);
  }

  void _sendMessage() async {
    if (_toTextCtrl.text.isNotEmpty) {
      _toKey.currentState.validate();
    }
    if (_ccTextCtrl.text.isNotEmpty) {
      _ccKey.currentState.validate();
    }
    if (_bccTextCtrl.text.isNotEmpty) {
      _bccKey.currentState?.validate();
    }

    if (_toEmails.isEmpty && _ccEmails.isEmpty && _bccEmails.isEmpty)
      return _showSnack(S.error_compose_no_receivers);
    if (_attachments.where((a) => a is TempAttachmentUpload).isNotEmpty) {
      return showSnack(
          context: context,
          scaffoldState: _scaffoldKey.currentState,
          message: i18n(context, S.error_compose_wait_attachments),
          isError: false);
    }
    if (_encryptType == EncryptType.None) {
      if (automaticallyEncrypt) {
        final emails = [..._toEmails, ..._ccEmails, ..._bccEmails];
        final encryptEmails = <String>[];
        final encryptSignEmails = <String>[];
        final signEmails = <String>[];
        final defaultEmails = <String>[];
        for (var emailWithName in emails) {
          String email;
          final match = RegExp("<(.*)?>").firstMatch(emailWithName);
          if (match != null && match.groupCount > 0) {
            email = match.group(1);
          } else {
            email = emailWithName;
          }
          final contacts = await _bloc.getContacts(email);

          if (contacts.isNotEmpty) {
            final contact = contacts.firstWhere(
              (element) => element.storage == "personal",
              orElse: () => contacts.first,
            );
            if (contact?.pgpPublicKey != null) {
              if (contact.autoEncrypt && contact.autoSign) {
                encryptSignEmails.add(emailWithName);
              } else if (contact.autoEncrypt) {
                encryptEmails.add(emailWithName);
              } else if (contact.autoSign) {
                signEmails.add(emailWithName);
              } else {
                defaultEmails.add(emailWithName);
              }
              continue;
            }
          }
          defaultEmails.add(emailWithName);
        }
        final sender = AliasOrIdentity(alias, identity);
        String password;
        try {
          if (encryptSignEmails.isNotEmpty || signEmails.isNotEmpty) {
            final key = await AppInjector.instance
                .cryptoStorage()
                .getPgpKey(sender.mail, true, false);
            if (key == null) {
              _showSnack(
                  S.error_pgp_not_found_keys_for, {"users": sender.mail});
              return;
            }
            password = await KeyRequestDialog.request(context, key.key);
            if (password == null) {
              return;
            }
          }
          final bodyPlainText =
              MailUtils.htmlToPlain(await _bodyTextCtrl.getText());
          final messages = <SendMessage>[];
          if (encryptSignEmails.isNotEmpty) {
            final ccEmails = _ccEmails
                .where((element) => encryptSignEmails.contains(element));
            final bccEmails = _bccEmails
                .where((element) => encryptSignEmails.contains(element));
            final toEmails = _toEmails
                .where((element) => encryptSignEmails.contains(element));

            final contact = <String>{};
            contact.addAll(ccEmails);
            contact.addAll(bccEmails);
            contact.addAll(toEmails);

            final encryptedBody = await _bloc.encryptBody(
              EncryptBody(
                contact,
                bodyPlainText,
                true,
                true,
                password,
                sender.mail,
              ),
            );
            messages.add(
              SendMessage(
                to: toEmails.join(","),
                cc: ccEmails.join(","),
                bcc: bccEmails.join(","),
                isHtml: false,
                subject: _subjectTextCtrl.text,
                composeAttachments:
                    new List<ComposeAttachment>.from(_attachments),
                messageText: encryptedBody,
                draftUid: _currentDraftUid,
                identity: identity,
                alias: alias,
              ),
            );
          }
          if (signEmails.isNotEmpty) {
            final ccEmails =
                _ccEmails.where((element) => signEmails.contains(element));
            final bccEmails =
                _bccEmails.where((element) => signEmails.contains(element));
            final toEmails =
                _toEmails.where((element) => signEmails.contains(element));

            final contact = <String>{};
            contact.addAll(ccEmails);
            contact.addAll(bccEmails);
            contact.addAll(toEmails);

            final encryptedBody = await _bloc.encryptBody(
              EncryptBody(
                contact,
                bodyPlainText,
                false,
                true,
                password,
                sender.mail,
              ),
            );
            messages.add(
              SendMessage(
                to: toEmails.join(","),
                cc: ccEmails.join(","),
                bcc: bccEmails.join(","),
                isHtml: false,
                subject: _subjectTextCtrl.text,
                composeAttachments:
                    new List<ComposeAttachment>.from(_attachments),
                messageText: encryptedBody,
                draftUid: _currentDraftUid,
                identity: identity,
                alias: alias,
              ),
            );
          }
          if (encryptEmails.isNotEmpty) {
            final ccEmails =
                _ccEmails.where((element) => encryptEmails.contains(element));
            final bccEmails =
                _bccEmails.where((element) => encryptEmails.contains(element));
            final toEmails =
                _toEmails.where((element) => encryptEmails.contains(element));

            final contact = <String>{};
            contact.addAll(ccEmails);
            contact.addAll(bccEmails);
            contact.addAll(toEmails);

            final encryptedBody = await _bloc.encryptBody(
              EncryptBody(
                contact,
                bodyPlainText,
                true,
                false,
                null,
                sender.mail,
              ),
            );
            messages.add(
              SendMessage(
                to: toEmails.join(","),
                cc: ccEmails.join(","),
                bcc: bccEmails.join(","),
                isHtml: false,
                subject: _subjectTextCtrl.text,
                composeAttachments:
                    new List<ComposeAttachment>.from(_attachments),
                messageText: encryptedBody,
                draftUid: _currentDraftUid,
                identity: identity,
                alias: alias,
              ),
            );
          }
          if (defaultEmails.isNotEmpty) {
            final ccEmails =
                _ccEmails.where((element) => defaultEmails.contains(element));
            final bccEmails =
                _bccEmails.where((element) => defaultEmails.contains(element));
            final toEmails =
                _toEmails.where((element) => defaultEmails.contains(element));

            final contact = <String>{};
            contact.addAll(ccEmails);
            contact.addAll(bccEmails);
            contact.addAll(toEmails);

            final body = await _bodyTextCtrl.getText();
            messages.add(
              SendMessage(
                to: toEmails.join(","),
                cc: ccEmails.join(","),
                bcc: bccEmails.join(","),
                isHtml: true,
                subject: _subjectTextCtrl.text,
                composeAttachments:
                    new List<ComposeAttachment>.from(_attachments),
                messageText: body,
                draftUid: _currentDraftUid,
                identity: identity,
                alias: alias,
              ),
            );
          }
          return _bloc.add(SendMessages(messages));
        } catch (e, s) {
          print(e);
        }
      } else {
        _bloc.add(SendMessage(
          to: _toEmails.join(","),
          cc: _ccEmails.join(","),
          bcc: _bccEmails.join(","),
          isHtml: _encryptType == EncryptType.None,
          subject: _subjectTextCtrl.text,
          composeAttachments: new List<ComposeAttachment>.from(_attachments),
          messageText: await _bodyTextCtrl.getText(),
          draftUid: _currentDraftUid,
          identity: identity,
          alias: alias,
        ));
      }
    } else {
      return _bloc.add(SendMessage(
        to: _toEmails.join(","),
        cc: _ccEmails.join(","),
        bcc: _bccEmails.join(","),
        isHtml: false,
        subject: _subjectTextCtrl.text,
        composeAttachments: new List<ComposeAttachment>.from(_attachments),
        messageText: await _bodyTextCtrl.getText(),
        draftUid: _currentDraftUid,
        identity: identity,
        alias: alias,
      ));
    }
  }

  Future<bool> get _hasMessageChanged async {
    if (_message != null) {
      final result = _subjectTextCtrl.text != _message.subject ||
          (await _bodyTextCtrl.getText()) != _message.rawBody ||
          !listEquals<String>(
              MailUtils.getEmails(_message.toInJson), _toEmails.toList()) ||
          !listEquals<String>(
              MailUtils.getEmails(_message.ccInJson), _ccEmails.toList()) ||
          !listEquals<String>(
              MailUtils.getEmails(_message.bccInJson), _bccEmails.toList()) ||
          !listEquals(_savedAttachments, _attachments);
      if (result) {
        _savedAttachments = _attachments.toList();
      }
      return result;
    } else {
      return (await _bodyTextCtrl.getText()).isNotEmpty ||
          _subjectTextCtrl.text.isNotEmpty ||
          _toEmails.isNotEmpty ||
          _ccEmails.isNotEmpty ||
          _bccEmails.isNotEmpty ||
          _attachments.isNotEmpty;
    }
  }

  void _saveToDrafts() async {
    if (!await _hasMessageChanged) return;

    final attachmentsForSave =
        _attachments.where((a) => a is ComposeAttachment);

    return _bloc.add(SaveToDrafts(
      to: _toEmails.join(","),
      cc: _ccEmails.join(","),
      bcc: _bccEmails.join(","),
      isHtml: _encryptType == EncryptType.None,
      subject: _subjectTextCtrl.text,
      composeAttachments: new List<ComposeAttachment>.from(attachmentsForSave),
      messageText: (await _bodyTextCtrl.getText()),
      draftUid: _currentDraftUid,
      identity: identity,
      alias: alias,
    ));
  }

  void _showSending() {
    dialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(width: 16.0),
                  Text(i18n(context, S.messages_sending)),
                ],
              ),
            ));
  }

  // to provide mail bloc
  void _onMessageSent(BuildContext context) {
    BlocProvider.of<MailBloc>(context).add(CheckFoldersMessagesChanges());
    // to update frequency
    BlocProvider.of<ContactsBloc>(context).add(GetContacts());
    if (_returnToMessagesList) {
      Navigator.popUntil(context, ModalRoute.withName(MessagesListRoute.name));
    } else {
      // one closes message sending popup, the other closes compose
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  // to provide mail bloc
  void _onMessageSaved(BuildContext context, int draftUid) {
    _currentDraftUid = draftUid;
    BlocProvider.of<MailBloc>(context).add(CheckFoldersMessagesChanges());

    showSnack(
      context: context,
      scaffoldState: _scaffoldKey.currentState,
      message: i18n(context, S.messages_saved_in_drafts),
      isError: false,
    );
  }

  _encryptLock(EncryptComplete state) async {
    decryptBody = await _bodyTextCtrl.getText();
    _bodyTextCtrl.setIsHtml(false);
    _bodyTextCtrl.setText(state.text);
    _encryptType = state.type;

    setState(() {});
  }

  _decrypt() {
    _bodyTextCtrl.setIsHtml(true);
    if (decryptBody != null) {
      _bodyTextCtrl.setText(decryptBody);
      decryptBody = null;
    }
    if (decryptTitle != null) {
      _subjectTextCtrl.text = decryptTitle;
      decryptTitle = null;
    }
    _encryptType = EncryptType.None;
    _bloc.add(DecryptEvent());
    setState(() {});
  }

  void _encryptDialog() async {
    final result = await showDialog(
      context: context,
      builder: (_) => EncryptDialog(),
    );

    if (result is EncryptDialogResult) {
      if (!result.sign && !result.encrypt) {
        return;
      }
      final sender = AliasOrIdentity(alias, identity);
      final key = await AppInjector.instance
          .cryptoStorage()
          .getPgpKey(sender.mail, true, false);
      if (key == null) {
        _showSnack(S.error_pgp_not_found_keys_for, {"users": sender.mail});
        return;
      }
      final password = await KeyRequestDialog.request(context, key.key);
      if (password == null) {
        return;
      }
      final contact = <String>{};
      contact.addAll(_ccEmails);
      contact.addAll(_bccEmails);
      contact.addAll(_toEmails);

      _bloc.add(EncryptBody(
        contact,
        MailUtils.htmlToPlain(await _bodyTextCtrl.getText()),
        result.encrypt,
        result.sign,
        password,
        sender.mail,
      ));
    }
  }

  Future<void> _onGoBack() async {
    if (await _hasMessageChanged) {
      final result = await showDialog<DiscardComposeChangesOption>(
        context: context,
        builder: (_) => DiscardComposeChangesDialog(),
      );

      switch (result) {
        case DiscardComposeChangesOption.discard:
          print('_onGoBack, discard');
          // if (_currentDraftUid != null && _currentDraftUid != widget.draftUid) {
          //   BlocProvider.of<MessagesListBloc>(context).add(DeleteMessages(
          //     messages: [_currentDraftUid],
          //   ));
          // }
          Navigator.pop(context);
          break;
        case DiscardComposeChangesOption.save:
          print('_onGoBack, save');
          _saveToDrafts();
          Navigator.pop(context);
          break;
      }
    }
  }

  Future setIdentityOrSender(AliasOrIdentity aliasOrIdentity) async {
    await changeSignature(
      AliasOrIdentity(alias, identity)?.signature ?? "",
      aliasOrIdentity.signature ?? "",
    );
    this.alias = aliasOrIdentity.alias;
    this.identity = aliasOrIdentity.identity;
    _fromCtrl.text =
        IdentityView.solid(aliasOrIdentity.name, aliasOrIdentity.mail);
  }

  void changeSignature(String oldSignature, String newSignature) async {
    if (oldSignature.isEmpty && newSignature.isEmpty) {
      return;
    }
    var text = await _bodyTextCtrl.getText();
    if (text.isEmpty) {
      text = "<br><br>$newSignature";
      await _bodyTextCtrl.setText(text);
      return;
    }

    int startIndex;
    int endIndex;
    if (oldSignature.isEmpty) {
      startIndex = -1;
    } else {
      startIndex = text.indexOf(oldSignature);
    }
    if (startIndex == -1) {
      startIndex = text.length;
      endIndex = startIndex;
    } else {
      endIndex = startIndex + oldSignature.length;
    }
    var signature = newSignature;

    await _bodyTextCtrl
        .setText(text.replaceRange(startIndex, endIndex, signature));
  }

  void _showSnack(int code, [Map<String, String> arg]) {
    Navigator.popUntil(context, ModalRoute.withName(ComposeRoute.name));
    showSnack(
      context: context,
      scaffoldState: _scaffoldKey.currentState,
      message: i18n(context, code, arg),
    );
  }

  void _showError(ErrorToShow err, [Map<String, String> arg]) {
    Navigator.popUntil(context, ModalRoute.withName(ComposeRoute.name));
    showErrorSnack(
      context: context,
      scaffoldState: _scaffoldKey.currentState,
      msg: err,
      arg: arg,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lockUsers = [EncryptType.Encrypt, EncryptType.SelfDestructingEncrypt]
        .contains(_encryptType);
    final config = LayoutConfig.of(context);
    final isTablet = config.isTablet && config.columnCount >= 3;
    Widget _done(FocusNode node) {
      return FlatButton(
        child: Text(
          i18n(context, S.btn_done),
          style: theme.textTheme.body1.copyWith(color: Colors.black),
        ),
        onPressed: node.unfocus,
      );
    }

    Widget body = WebViewWrap(
      topWidget: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_encryptType == EncryptType.None)
              AutomaticallyEncryptLabel(
                value: automaticallyEncrypt,
                onChanged: (_) {
                  setState(() {
                    automaticallyEncrypt = !automaticallyEncrypt;
                  });
                },
                emails: [..._toEmails, ..._ccEmails, ..._bccEmails],
                bloc: _bloc,
              ),
            IdentitySelector(
              padding: EdgeInsets.all(16.0),
              enable: !lockUsers,
              label: i18n(context, S.messages_from),
              onIdentity: setIdentityOrSender,
              textCtrl: _fromCtrl,
            ),
            Divider(height: 0.0),
            ComposeEmails(
              key: _toKey,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              enable: !lockUsers,
              focusNode: toNode,
              label: i18n(context, S.messages_to),
              textCtrl: _toTextCtrl,
              emails: _toEmails,
              onNext: () {
                ccNode.requestFocus();
              },
              onChange: () {
                setState(() {});
              },
              bloc: _bloc,
            ),
            Divider(height: 0.0),
            ComposeEmails(
              key: _ccKey,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              enable: !lockUsers,
              focusNode: ccNode,
              label: i18n(context, S.messages_cc),
              textCtrl: _ccTextCtrl,
              emails: _ccEmails,
              onCCSelected: () => setState(() => _showBCC = true),
              onNext: () {
                if (_showBCC) {
                  bccNode.requestFocus();
                } else {
                  subjectNode.requestFocus();
                }
              },
              onChange: () {
                setState(() {});
              },
              bloc: _bloc,
            ),
            Divider(height: 0.0),
            if (_showBCC)
              ComposeEmails(
                key: _bccKey,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                enable: !lockUsers,
                focusNode: bccNode,
                label: i18n(context, S.messages_bcc),
                textCtrl: _bccTextCtrl,
                emails: _bccEmails,
                onNext: () {
                  subjectNode.requestFocus();
                },
                onChange: () {
                  setState(() {});
                },
                bloc: _bloc,
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  if (_showBCC) Divider(height: 0.0),
                  ComposeSubject(
                    focusNode: subjectNode,
                    textCtrl: _subjectTextCtrl,
                    onAttach: isTablet
                        ? null
                        : (FileType type) => _bloc.add(UploadAttachment(type)),
                    onNext: () {
                      bodyNode.requestFocus();
                    },
                  ),
                  if (!isTablet && _attachments.isNotEmpty)
                    Divider(height: 0.0),
                  if (!isTablet)
                    BlocBuilder<ComposeBloc, ComposeState>(
                      builder: (_, state) {
                        if (state is ConvertingAttachments) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else {
                          return Column(
                            children: _attachments
                                .map((a) =>
                                    ComposeAttachmentItem(a, _cancelAttachment))
                                .toList(),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
            Divider(height: 0.0),
          ],
        ),
      ),
      closeWebView: (fun) => DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          iconSize: 24,
          icon: RotatedBox(
              quarterTurns: 45,
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          onPressed: fun,
        ),
      ),
      webView: ComposeWebView(
        enable: ![
          EncryptType.SelfDestructingEncrypt,
          EncryptType.Encrypt,
          EncryptType.Sign
        ].contains(_encryptType),
        textCtrl: _bodyTextCtrl,
        init: () {},
      ),
    );
//    body = _keyboardActions(body);
    if (isTablet) {
      body = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: body,
          ),
          SizedBox(
            height: double.infinity,
            width: 1,
            child: Divider(),
          ),
          Flexible(
            flex: 1,
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration:
                  BoxDecoration(border: Border(left: BorderSide(width: 0.2))),
              child: Scaffold(
                floatingActionButton: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (Platform.isIOS) ...[
                      AMFloatingActionButton(
                        heroTag: "second",
                        child: IconTheme(
                          data: AppTheme.floatIconTheme,
                          child: Icon(Icons.perm_media),
                        ),
                        onPressed: () =>
                            _bloc.add(UploadAttachment(FileType.media)),
                      ),
                      SizedBox(height: 10),
                    ],
                    AMFloatingActionButton(
                      child: IconTheme(
                        data: AppTheme.floatIconTheme,
                        child: Icon(Icons.attachment),
                      ),
                      onPressed: () =>
                          _bloc.add(UploadAttachment(FileType.any)),
                    ),
                  ],
                ),
                body: BlocBuilder<ComposeBloc, ComposeState>(
                  builder: (_, state) {
                    if (state is ConvertingAttachments) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return ListView(
                        children: _attachments
                            .map((a) => ComposeAttachmentItem(
                                  a,
                                  _cancelAttachment,
                                  isLarge: true,
                                ))
                            .toList(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }

    final keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom > 100;
    body = Column(
      children: [
        Expanded(child: body),
        if (!keyboardIsOpened && BuildProperty.cryptoEnable)
          ComposeBottomBar(
            _encryptDialog,
            _decrypt,
            _createSelfDestructingEmail,
            _encryptType,
          )
      ],
    );

    return BlocProvider<ComposeBloc>.value(
      value: _bloc,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: ComposeAppBar(_onAppBarActionSelected),
        body: BlocListener<ComposeBloc, ComposeState>(
          listener: (context, state) {
            if (state is EncryptComplete) _encryptLock(state);

            if (state is MessageSending) _showSending();
            if (state is MessageSent) _onMessageSent(context);
            if (state is MessageSavedInDrafts)
              _onMessageSaved(context, state.draftUid);
            if (state is ComposeError) _showError(state.errorMsg, state.arg);
            if (state is UploadStarted)
              _setUploadProgress(state.tempAttachment);
            if (state is AttachmentUploaded)
              _onAttachmentUploaded(state.composeAttachment);
            if (state is ReceivedComposeAttachments)
              setState(() => _attachments.addAll(state.attachments));
          },
          child: body,
        ),
      ),
    );
  }

  _createSelfDestructingEmail() async {
    final subject = _subjectTextCtrl.text;
    final body = MailUtils.htmlToPlain(await _bodyTextCtrl.getText());

    if (_toEmails.isEmpty) {
      return showSnack(
        context: context,
        scaffoldState: _scaffoldKey.currentState,
        message: i18n(context, S.error_pgp_select_recipient),
      );
    }
    final bloc = SelfDestructingBloc(
      _bloc.user,
      _bloc.account,
      AliasOrIdentity(alias, identity),
      subject,
      body,
    );

    final result = await dialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: EncryptSetting(
          bloc,
          _toEmails.first,
        ),
      ),
    );
    if (result is Encrypted) {
      if (!result.isKeyBase && result.contact.key == null) {
        final viewPasswordResult = await dialog(
          context: context,
          builder: (context) => BlocProvider.value(
            value: bloc,
            child: ViewPassword(
              [result.contact],
              result.password,
            ),
          ),
        );
        if (viewPasswordResult != true) {
          return;
        }
      }
      decryptTitle = _subjectTextCtrl.text;
      decryptBody = await _bodyTextCtrl.getText();

      _subjectTextCtrl.text =
          i18n(context, S.template_self_destructing_message_title);
      _bodyTextCtrl.setText(result.body);
      _attachments.clear();
      _ccEmails.clear();
      _bccEmails.clear();
      _encryptType = result.contact.key != null
          ? EncryptType.SelfDestructingEncrypt
          : EncryptType.SelfDestructing;
      setState(() {});
    } else if (result is ErrorState) {
      _showError(result.message);
    }
  }
}
