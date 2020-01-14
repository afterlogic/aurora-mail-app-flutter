import 'dart:async';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/contacts/blocs/contacts_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_actions.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/mail_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/utils/internationalization.dart';
import 'package:aurora_mail/utils/mail_utils.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _ComposeAndroidState extends State<ComposeAndroid> {
  final _bloc = new ComposeBloc();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Timer _timer;

  bool _showBCC = false;

  int _currentDraftUid;
  Message _message;

  final _toEmails = new List<String>();
  final _ccEmails = new List<String>();
  final _bccEmails = new List<String>();
  final _attachments = new List();
  final _toTextCtrl = new TextEditingController();
  final _ccTextCtrl = new TextEditingController();
  final _bccTextCtrl = new TextEditingController();
  final _subjectTextCtrl = new TextEditingController();
  final _bodyTextCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSaveToDraftsTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _prepareMessage();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) _timer.cancel();
    _bloc.close();
  }

  void _prepareMessage() {
    final action = widget.composeAction;

    if (action is OpenFromDrafts) _initFromDrafts(action);
    if (action is Forward) _initForward(action);
    if (action is Reply) _initReply(action);
    if (action is ReplyToAll) _initReplyAll(action);
    if (action is EmailToContacts) _initFromContacts(action);
  }

  void _initFromDrafts(OpenFromDrafts action) async {
    _currentDraftUid = action.draftUid;
    _message = action.message;

    final str = action.message.attachmentsInJson;
    final attachments = MailAttachment.fromJsonString(str);
    _bloc.add(GetComposeAttachments(attachments));

    _toEmails.addAll(MailUtils.getEmails(_message.toInJson));
    _ccEmails.addAll(MailUtils.getEmails(_message.ccInJson));
    _bccEmails.addAll(MailUtils.getEmails(_message.bccInJson));
    _subjectTextCtrl.text = _message.subject;
    _bodyTextCtrl.text = MailUtils.htmlToPlain(_message.html);
  }

  void _initForward(Forward action) async {
    _message = action.message;

    _subjectTextCtrl.text = MailUtils.getForwardSubject(_message);
    _bodyTextCtrl.text = MailUtils.getForwardBody(context, _message);
  }

  void _initReply(Reply action) async {
    _message = action.message;

    _toEmails.addAll(MailUtils.getEmails(_message.fromInJson));
    _subjectTextCtrl.text = MailUtils.getReplySubject(_message);
    _bodyTextCtrl.text = MailUtils.getReplyBody(context, _message);
  }

  void _initReplyAll(ReplyToAll action) async {
    _message = action.message;

    _toEmails.addAll(MailUtils.getEmails(_message.fromInJson));
    _ccEmails.addAll(MailUtils.getEmails(_message.toInJson, exceptEmails: [AuthBloc.currentAccount.email]));
    _ccEmails.addAll(MailUtils.getEmails(_message.ccInJson));
    _subjectTextCtrl.text = MailUtils.getReplySubject(_message);
    _bodyTextCtrl.text = MailUtils.getReplyBody(context, _message);
  }

  void _initFromContacts(EmailToContacts action) {
    final toEmails = action.contacts.map((c) => MailUtils.getFriendlyName(c));
    _toEmails.addAll(toEmails);
  }

  void _initSaveToDraftsTimer() async {
    _timer = Timer.periodic(
      SAVE_TO_DRAFTS_PERIOD,
      (Timer timer) => _saveToDrafts(),
    );
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
      subject: _subjectTextCtrl.text,
      composeAttachments: new List<ComposeAttachment>.from(_attachments),
      messageText: _bodyTextCtrl.text,
      draftUid: _currentDraftUid,
    ));
  }

  bool get _hasMessageChanged {
    if (_message != null) {
      return _subjectTextCtrl.text != _message.subject ||
          _bodyTextCtrl.text != MailUtils.htmlToPlain(_message.html) ||
          !listEquals<String>(MailUtils.getEmails(_message.toInJson), _toEmails) ||
          !listEquals<String>(MailUtils.getEmails(_message.ccInJson), _ccEmails) ||
          !listEquals<String>(MailUtils.getEmails(_message.bccInJson), _bccEmails);
    } else {
      return _bodyTextCtrl.text.isNotEmpty ||
          _subjectTextCtrl.text.isNotEmpty ||
          _toEmails.isNotEmpty ||
          _ccEmails.isNotEmpty ||
          _bccEmails.isNotEmpty;
    }
  }

  void _saveToDrafts() {
    if (!_hasMessageChanged) return;

    final attachmentsForSave = _attachments.where((a) => a is ComposeAttachment);

    return _bloc.add(SaveToDrafts(
      to: _toEmails.join(","),
      cc: _ccEmails.join(","),
      bcc: _bccEmails.join(","),
      subject: _subjectTextCtrl.text,
      composeAttachments: new List<ComposeAttachment>.from(attachmentsForSave),
      messageText: _bodyTextCtrl.text,
      draftUid: _currentDraftUid,
    ));
  }

  void _showSending() {
    showDialog(
        context: context,
        barrierDismissible: false,
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
    Navigator.popUntil(context, ModalRoute.withName(MessagesListRoute.name));
  }

  // to provide mail bloc
  void _onMessageSaved(BuildContext context, int draftUid) {
    _currentDraftUid = draftUid;
    BlocProvider.of<MailBloc>(context).add(CheckFoldersMessagesChanges());

    showSnack(
      context: context,
      scaffoldState: _scaffoldKey.currentState,
      msg: i18n(context, "messages_saved_in_drafts"),
      isError: false,
    );
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

  void _showError(String err) {
    Navigator.popUntil(context, ModalRoute.withName(ComposeRoute.name));
    showSnack(
        context: context, scaffoldState: _scaffoldKey.currentState, msg: err);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: ComposeAppBar(_onAppBarActionSelected),
      body: BlocProvider<ComposeBloc>.value(
        value: _bloc,
        child: BlocListener<ComposeBloc, ComposeState>(
          listener: (context, state) {
            if (state is MessageSending) _showSending();
            if (state is MessageSent) _onMessageSent(context);
            if (state is MessageSavedInDrafts)
              _onMessageSaved(context, state.draftUid);
            if (state is ComposeError) _showError(state.errorMsg);
            if (state is UploadStarted)
              _setUploadProgress(state.tempAttachment);
            if (state is AttachmentUploaded)
              _onAttachmentUploaded(state.composeAttachment);
            if (state is ReceivedComposeAttachments)
              setState(() => _attachments.addAll(state.attachments));
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              ComposeEmails(
                label: i18n(context, "messages_to"),
                textCtrl: _toTextCtrl,
                emails: _toEmails,
              ),
              Divider(height: 0.0),
              ComposeEmails(
                label: i18n(context, "messages_cc"),
                textCtrl: _ccTextCtrl,
                emails: _ccEmails,
                onCCSelected: () => setState(() => _showBCC = true),
              ),
              Divider(height: 0.0),
              if (_showBCC)
                ComposeEmails(
                  label: i18n(context, "messages_bcc"),
                  textCtrl: _bccTextCtrl,
                  emails: _bccEmails,
                ),
              if (_showBCC) Divider(height: 0.0),
              ComposeSubject(
                textCtrl: _subjectTextCtrl,
                onAttach: () => _bloc.add(UploadAttachment()),
              ),
              if (_attachments.isNotEmpty) Divider(height: 0.0),
              BlocBuilder<ComposeBloc, ComposeState>(builder: (_, state) {
                if (state is ConvertingAttachments) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Column(
                    children: _attachments
                        .map((a) => ComposeAttachmentItem(a, _cancelAttachment))
                        .toList(),
                  );
                }
              }),
//              Divider(height: 0.0),
              ComposeBody(textCtrl: _bodyTextCtrl),
            ],
          ),
        ),
      ),
    );
  }
}
