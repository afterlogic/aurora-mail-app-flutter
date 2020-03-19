import 'dart:async';

import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/models/alias_or_identity.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/compose_bottom_bar.dart';
import 'package:aurora_mail/modules/mail/screens/compose/components/identity_selector.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/compose/dialog/encrypt_dialog.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/utils/base_state.dart';
import 'package:aurora_mail/utils/identity_util.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:aurora_mail/utils/show_dialog.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:crypto_worker/crypto_worker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_action.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'components/compose_app_bar.dart';
import 'components/compose_attachment_item.dart';
import 'components/compose_body.dart';
import 'components/compose_emails.dart';
import 'components/compose_subject.dart';

class ComposeAndroid extends StatefulWidget {
  final ComposeAction composeAction;

  const ComposeAndroid({Key key, this.composeAction}) : super(key: key);

  @override
  _ComposeAndroidState createState() => _ComposeAndroidState();
}

class _ComposeAndroidState extends BState<ComposeAndroid> {
  ComposeBloc _bloc;
  Aliases alias;
  AccountIdentity identity;
  final toNode = FocusNode();
  final ccNode = FocusNode();
  final bccNode = FocusNode();
  final bodyNode = FocusNode();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Timer _timer;
  EncryptType _lock = EncryptType.None;
  String decryptText;
  bool _showBCC = false;

  // if compose was opened from screen which does not have MessagesListRoute in stack, just pop
  bool _returnToMessagesList = true;
  int _currentDraftUid;
  Message _message;

  final _toEmails = new List<String>();
  final _ccEmails = new List<String>();
  final _bccEmails = new List<String>();
  final _attachments = new List();
  List _savedAttachments;
  final _toTextCtrl = new TextEditingController();
  final _ccTextCtrl = new TextEditingController();
  final _bccTextCtrl = new TextEditingController();
  final _subjectTextCtrl = new TextEditingController();
  final _bodyTextCtrl = new TextEditingController();
  final _fromCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSaveToDraftsTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authBloc = BlocProvider.of<AuthBloc>(context);

    _bloc = ComposeBloc(
      user: authBloc.currentUser,
      account: BlocProvider.of<AuthBloc>(context).currentAccount,
    );
    setIdentityOrSender(AliasOrIdentity(null, authBloc.currentIdentity));
    _prepareMessage();
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

    if (action is OpenFromDrafts) await _initFromDrafts(action);
    if (action is Forward) await _initForward(action);
    if (action is Reply) await _initReply(action);
    if (action is ReplyToAll) await _initReplyAll(action);
    if (action is EmailToContacts) await _initFromContacts(action);
    if (action is SendContacts) await _initContactsAsAttachments(action);
    if (action is Resend) await _initResend(action);
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
    _bodyTextCtrl.text = _message.rawBody;
  }

  void _initForward(Forward action) async {
    _message = action.message;

    _subjectTextCtrl.text = MailUtils.getForwardSubject(_message);
    _bodyTextCtrl.text = MailUtils.getForwardBody(context, _message);
  }

  void _initReply(Reply action) async {
    _message = action.message;
    await _initSender(_message);
    if (_toEmails.isEmpty) {
      setState(() {
        _toEmails.addAll(MailUtils.getEmails(_message.fromInJson));
      });
    }
    _subjectTextCtrl.text = MailUtils.getReplySubject(_message);
    _bodyTextCtrl.text = MailUtils.getReplyBody(context, _message);
  }

  void _initResend(Resend action) async {
    _message = action.message;
    await _initSender(_message);
    if (_toEmails.isEmpty) {
      setState(() {
        _toEmails.addAll(MailUtils.getEmails(_message.toInJson));
      });
    }
    _subjectTextCtrl.text = MailUtils.htmlToPlain(_message.subject);
    _bodyTextCtrl.text = MailUtils.htmlToPlain(
      _message.isHtml ? _message.htmlBody : _message.rawBody,
    );
  }

  void _initReplyAll(ReplyToAll action) async {
    _message = action.message;
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
    _bodyTextCtrl.text = MailUtils.getReplyBody(context, _message);
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
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final items = await authBloc.getAliasesAndIdentities();

    final identity = MailUtils.findIdentity(message.toInJson, items);
    setIdentityOrSender(
        identity ?? AliasOrIdentity(null, authBloc.currentIdentity));
  }

  void _onAppBarActionSelected(ComposeAppBarAction action) {
    switch (action) {
      case ComposeAppBarAction.saveToDrafts:
        _saveToDrafts();
        break;
      case ComposeAppBarAction.cancel:
        Navigator.pop(context);
        _saveToDrafts();
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
      _attachments.insert(i, attachment);
    });
  }

  void _cancelAttachment(dynamic attachment) {
    setState(() {
      _attachments.removeWhere((a) => a.guid == attachment.guid);
    });
  }

  void _sendMessage() {
    if (_toTextCtrl.text.isNotEmpty) {
      setState(() {
        _toEmails.add(_toTextCtrl.text);
        _toTextCtrl.clear();
      });
    }
    if (_ccTextCtrl.text.isNotEmpty) {
      setState(() {
        _ccEmails.add(_ccTextCtrl.text);
        _ccTextCtrl.clear();
      });
    }
    if (_bccTextCtrl.text.isNotEmpty) {
      setState(() {
        _bccEmails.add(_bccTextCtrl.text);
        _bccTextCtrl.clear();
      });
    }

    if (_toEmails.isEmpty)
      return _showError(i18n(context, "error_compose_no_receivers"));
    if (_attachments.where((a) => a is TempAttachmentUpload).isNotEmpty) {
      return showSnack(
          context: context,
          scaffoldState: _scaffoldKey.currentState,
          msg: i18n(context, "error_compose_wait_attachments"),
          isError: false);
    }

    return _bloc.add(SendMessage(
      to: _toEmails.join(","),
      cc: _ccEmails.join(","),
      bcc: _bccEmails.join(","),
      isHtml: false,
      subject: _subjectTextCtrl.text,
      composeAttachments: new List<ComposeAttachment>.from(_attachments),
      messageText: _bodyTextCtrl.text,
      draftUid: _currentDraftUid,
      identity: identity,
      alias: alias,
    ));
  }

  bool get _hasMessageChanged {
    if (_message != null) {
      final result = _subjectTextCtrl.text != _message.subject ||
          _bodyTextCtrl.text != _message.rawBody ||
          !listEquals<String>(
              MailUtils.getEmails(_message.toInJson), _toEmails) ||
          !listEquals<String>(
              MailUtils.getEmails(_message.ccInJson), _ccEmails) ||
          !listEquals<String>(
              MailUtils.getEmails(_message.bccInJson), _bccEmails) ||
          !listEquals(_savedAttachments, _attachments);
      if (result) {
        _savedAttachments = _attachments.toList();
      }
      return result;
    } else {
      return _bodyTextCtrl.text.isNotEmpty ||
          _subjectTextCtrl.text.isNotEmpty ||
          _toEmails.isNotEmpty ||
          _ccEmails.isNotEmpty ||
          _bccEmails.isNotEmpty ||
          _attachments.isNotEmpty;
    }
  }

  void _saveToDrafts() {
    if (!_hasMessageChanged) return;

    final attachmentsForSave =
        _attachments.where((a) => a is ComposeAttachment);

    return _bloc.add(SaveToDrafts(
      to: _toEmails.join(","),
      cc: _ccEmails.join(","),
      bcc: _bccEmails.join(","),
      isHtml: false,
      subject: _subjectTextCtrl.text,
      composeAttachments: new List<ComposeAttachment>.from(attachmentsForSave),
      messageText: _bodyTextCtrl.text,
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
                  Text(i18n(context, "messages_sending")),
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
      msg: "messages_saved_in_drafts",
      isError: false,
    );
  }

  _encryptLock(EncryptComplete state) {
    decryptText = _bodyTextCtrl.text;
    _bodyTextCtrl.text = state.text;
    _lock = state.type;

    setState(() {});
  }

  _decrypt() {
    _bodyTextCtrl.text = decryptText;
    decryptText = "";
    _lock = EncryptType.None;
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
      _bloc.add(EncryptBody(
        _toEmails,
        _bodyTextCtrl.text,
        result.encrypt,
        result.sign,
        result.pass,
        sender.mail,
      ));
    }
  }

  // TODO task frozen
//  Future<void> _onGoBack() async {
//    final result = await showDialog<DiscardComposeChangesOption>(
//      context: context,
//      builder: (_) => DiscardComposeChangesDialog(),
//    );
//
//    switch(result) {
//      case DiscardComposeChangesOption.discard:
//        Navigator.pop(context);
//        if (_currentDraftUid != null && _currentDraftUid != widget.draftUid) {
//          BlocProvider.of<MessagesListBloc>(context).add(DeleteMessages(uids: [_currentDraftUid], ));
//        }
//        break;
//      case DiscardComposeChangesOption.save:
//        Navigator.pop(context);
//        _saveToDrafts();
//        break;
//    }
//  }
  void setIdentityOrSender(AliasOrIdentity aliasOrIdentity) {
    changeSignature(
      MailUtils.htmlToPlain(AliasOrIdentity(alias, identity).signature),
      MailUtils.htmlToPlain(aliasOrIdentity.signature ?? ""),
    );
    this.alias = aliasOrIdentity.alias;
    this.identity = aliasOrIdentity.identity;
    _fromCtrl.text =
        identityViewName(aliasOrIdentity.name, aliasOrIdentity.mail);
  }

  void changeSignature(String oldSignature, String newSignature) {
    if (oldSignature.isEmpty && newSignature.isEmpty) {
      return;
    }
    var text = _bodyTextCtrl.text;
    if (text.isEmpty) {
      _bodyTextCtrl.text = text = "\n$newSignature";
      return;
    }
    int startIndex;
    int endIndex;
    if (oldSignature.isEmpty) {
      startIndex = -1;
    } else {
      startIndex = text.lastIndexOf(oldSignature);
    }
    if (startIndex == -1) {
      startIndex = text.length;
      endIndex = startIndex;
    } else {
      endIndex = startIndex + oldSignature.length;
    }
    var signature = newSignature;

    _bodyTextCtrl.text = text.replaceRange(startIndex, endIndex, signature);
  }

  void _showError(String err, [Map<String, String> arg]) {
    Navigator.popUntil(context, ModalRoute.withName(ComposeRoute.name));
    showSnack(
      context: context,
      scaffoldState: _scaffoldKey.currentState,
      msg: err,
      arg: arg,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lockUsers = _lock == EncryptType.Encrypt;

    Widget _done(FocusNode node) {
      return FlatButton(
        child: Text(
          i18n(context, "done"),
          style: theme.textTheme.body1.copyWith(color: Colors.black),
        ),
        onPressed: node.unfocus,
      );
    }

    Widget _keyboardActions(Widget child) {
      return KeyboardActions(
        config: KeyboardActionsConfig(
          keyboardActionsPlatform: kDebugMode
              ? KeyboardActionsPlatform.ALL
              : KeyboardActionsPlatform.IOS,
          keyboardBarColor: Colors.white,
          actions: [
            KeyboardAction(
              focusNode: toNode,
              toolbarButtons: [_done],
            ),
            KeyboardAction(
              focusNode: ccNode,
              toolbarButtons: [_done],
            ),
            KeyboardAction(
              focusNode: bccNode,
              toolbarButtons: [_done],
            ),
            KeyboardAction(
              focusNode: bodyNode,
              toolbarButtons: [_done],
            ),
          ],
        ),
        child: child,
      );
    }

    return BlocProvider<ComposeBloc>.value(
      value: _bloc,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: ComposeAppBar(_onAppBarActionSelected),
        body: _keyboardActions(
          BlocListener<ComposeBloc, ComposeState>(
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
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  IdentitySelector(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    enable: !lockUsers,
                    label: i18n(context, "messages_from"),
                    onIdentity: setIdentityOrSender,
                    textCtrl: _fromCtrl,
                  ),
                  Divider(height: 0.0),
                  ComposeEmails(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    enable: !lockUsers,
                    focusNode: toNode,
                    label: i18n(context, "messages_to"),
                    textCtrl: _toTextCtrl,
                    emails: _toEmails,
                  ),
                  Divider(height: 0.0),
                  ComposeEmails(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    enable: !lockUsers,
                    focusNode: ccNode,
                    label: i18n(context, "messages_cc"),
                    textCtrl: _ccTextCtrl,
                    emails: _ccEmails,
                    onCCSelected: () => setState(() => _showBCC = true),
                  ),
                  Divider(height: 0.0),
                  if (_showBCC)
                    ComposeEmails(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      enable: !lockUsers,
                      focusNode: bccNode,
                      label: i18n(context, "messages_bcc"),
                      textCtrl: _bccTextCtrl,
                      emails: _bccEmails,
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        if (_showBCC) Divider(height: 0.0),
                        ComposeSubject(
                          textCtrl: _subjectTextCtrl,
                          onAttach: () => _bloc.add(UploadAttachment()),
                        ),
                        if (_attachments.isNotEmpty) Divider(height: 0.0),
                        BlocBuilder<ComposeBloc, ComposeState>(
                          builder: (_, state) {
                            if (state is ConvertingAttachments) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            } else {
                              return Column(
                                children: _attachments
                                    .map((a) => ComposeAttachmentItem(
                                        a, _cancelAttachment))
                                    .toList(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0.0),
                  ComposeBody(
                    enable: _lock == EncryptType.None,
                    textCtrl: _bodyTextCtrl,
                    focusNode: bodyNode,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BuildProperty.cryptoEnable
            ? ComposeBottomBar(
                onEncrypt: _encryptDialog,
                onDecrypt: _decrypt,
              )
            : null,
      ),
    );
  }
}
