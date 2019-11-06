import 'dart:async';

import 'package:aurora_mail/config.dart';
import 'package:aurora_mail/modules/mail/blocs/compose_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/blocs/mail_bloc/bloc.dart';
import 'package:aurora_mail/modules/mail/models/compose_attachment.dart';
import 'package:aurora_mail/modules/mail/models/temp_attachment_upload.dart';
import 'package:aurora_mail/modules/mail/screens/compose/compose_route.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/utils/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/compose_app_bar.dart';
import 'components/compose_attachment_item.dart';
import 'components/compose_body.dart';
import 'components/compose_section.dart';
import 'components/compose_subject.dart';

class ComposeAndroid extends StatefulWidget {
  final int draftUid;

  const ComposeAndroid({Key key, this.draftUid}) : super(key: key);

  @override
  _ComposeAndroidState createState() => _ComposeAndroidState();
}

class _ComposeAndroidState extends State<ComposeAndroid> {
  final _bloc = new ComposeBloc();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Timer _timer;

  bool _showBCC = false;

  int _currentDraftUid;

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
    _currentDraftUid = widget.draftUid;
    _initSaveToDraftsTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _bloc.close();
  }

  void _initSaveToDraftsTimer() async {
    await Future.delayed(SAVE_TO_DRAFTS_PERIOD);
    _timer = Timer.periodic(
      SAVE_TO_DRAFTS_PERIOD,
      (Timer timer) => _saveToDrafts(),
    );
  }

  void _onAppBarActionSelected(ComposeAppBarAction action) {
    switch (action) {
      case ComposeAppBarAction.saveToDrafts:
      case ComposeAppBarAction.cancel:
        return _saveToDrafts();
      case ComposeAppBarAction.send:
        return _sendMessage();
    }
  }

  void _setUploadProgress(TempAttachmentUpload tempAttachment) {
    setState(() {
      _attachments.add(tempAttachment);
    });
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

    // TODO translate
    if (_toEmails.isEmpty) return _showError("Please provide receivers");
    if (_attachments.where((a) => a is TempAttachmentUpload).isNotEmpty) {
      return showSnack(
          context: context,
          scaffoldState: _scaffoldKey.currentState,
          // TODO translate
          msg: "Please wait until attachments finish uploading",
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

  void _saveToDrafts() {
    if (_bodyTextCtrl.text.isEmpty) return;

    final attachmentsForSave =
        _attachments.where((a) => a is ComposeAttachment);

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
                  // TODO translate
                  Text("Sending message..."),
                ],
              ),
            ));
  }

  // to provide mail bloc
  void _onMessageSent(BuildContext context) {
    BlocProvider.of<MailBloc>(context).add(CheckFoldersMessagesChanges());
    Navigator.popUntil(context, ModalRoute.withName(MessagesListRoute.name));
  }

  // to provide mail bloc
  void _onMessageSaved(BuildContext context, int draftUid) {
    _currentDraftUid = draftUid;
    BlocProvider.of<MailBloc>(context).add(CheckFoldersMessagesChanges());

    // TODO VO: not working
    showSnack(
      context: context,
      scaffoldState: _scaffoldKey.currentState,
      // TODO translate
      msg: "Message saved in drafts",
      isError: false,
    );
  }

  void _showError(String err) {
    Navigator.popUntil(context, ModalRoute.withName(ComposeRoute.name));
    showSnack(
        context: context, scaffoldState: _scaffoldKey.currentState, msg: err);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(APP_BAR_HEIGHT_ANDROID),
        child: ComposeAppBar(_onAppBarActionSelected),
      ),
      body: BlocProvider<ComposeBloc>.value(
        value: _bloc,
        child: BlocListener<ComposeBloc, ComposeState>(
          listener: (context, state) {
            if (state is MessageSending) _showSending();
            if (state is MessageSent) _onMessageSent(context);
            if (state is MessageSavedInDrafts)
              _onMessageSaved(context, state.draftUid);
            if (state is ComposeError) _showError(state.error);
            if (state is UploadStarted)
              _setUploadProgress(state.tempAttachment);
            if (state is AttachmentUploaded)
              _onAttachmentUploaded(state.composeAttachment);
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              // TODO translate
              ComposeSection(
                label: "To",
                textCtrl: _toTextCtrl,
                emails: _toEmails,
              ),
              Divider(height: 0.0),
              // TODO translate
              ComposeSection(
                label: "CC",
                textCtrl: _ccTextCtrl,
                emails: _ccEmails,
                onCCSelected: () => setState(() => _showBCC = true),
              ),
              Divider(height: 0.0),
              if (_showBCC)
                // TODO translate
                ComposeSection(
                  label: "BCC",
                  textCtrl: _bccTextCtrl,
                  emails: _bccEmails,
                ),
              if (_showBCC)
                Divider(height: 0.0),
              ComposeSubject(
                textCtrl: _subjectTextCtrl,
                onAttach: () => _bloc.add(UploadAttachment()),
              ),
              if (_attachments.isNotEmpty)
                Divider(height: 0.0),
              Column(
                children: _attachments
                    .map((a) => ComposeAttachmentItem(a, _cancelAttachment))
                    .toList(),
              ),
              Divider(height: 0.0),
              ComposeBody(textCtrl: _bodyTextCtrl),
            ],
          ),
        ),
      ),
    );
  }
}
