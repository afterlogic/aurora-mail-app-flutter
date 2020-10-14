import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:aurora_mail/shared_ui/sized_dialog_content.dart';
import 'package:aurora_mail/utils/internationalization.dart'; import 'package:aurora_mail/res/str/s.dart';
import 'package:flutter/material.dart';

class AdvancedSearch extends StatefulWidget {
  final String searchText;

  AdvancedSearch(this.searchText);

  @override
  State<StatefulWidget> createState() => AdvancedSearchState();
}

class AdvancedSearchState extends State<AdvancedSearch> {
  bool withAttachment = false;
  var previousText = "";
  TextEditingController fromCtrl;

  TextEditingController toCtrl;
  TextEditingController subjectCtrl;

  TextEditingController textCtrl;
  TextEditingController attachmentCtrl;
  DateTime since;
  DateTime till;

  @override
  void initState() {
    super.initState();
    searchUtil.searchParams(widget.searchText).forEach((item) {
      switch (item.pattern) {
        case SearchPattern.Default:
          break;
        case SearchPattern.Email:
          break;
        case SearchPattern.From:
          fromCtrl = TextEditingController(text: item.value);
          break;
        case SearchPattern.To:
          toCtrl = TextEditingController(text: item.value);
          break;
        case SearchPattern.Subject:
          subjectCtrl = TextEditingController(text: item.value);
          break;
        case SearchPattern.Has:
          withAttachment = (item as HasSearchParams)
                  .flags
                  ?.contains(SearchFlag.Attachment) ==
              true;
          break;
        case SearchPattern.Date:
          since = (item as DateSearchParams).since;
          till = (item as DateSearchParams).till;
          break;
        case SearchPattern.Text:
          textCtrl = TextEditingController(text: item.value);
          break;
        case SearchPattern.Attachment:
          attachmentCtrl = TextEditingController(text: item.value);
          break;
      }
    });
    fromCtrl ??= TextEditingController();
    toCtrl ??= TextEditingController();
    subjectCtrl ??= TextEditingController();
    textCtrl ??= TextEditingController();
    attachmentCtrl ??= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(i18n(context, S.label_message_advanced_search)),
      content: SizedDialogContent(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: i18n(context, S.messages_from),
                ),
                controller: fromCtrl,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: i18n(context, S.messages_to),
                ),
                controller: toCtrl,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: i18n(context, S.messages_subject),
                ),
                controller: subjectCtrl,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: i18n(context, S.input_message_search_text),
                ),
                controller: textCtrl,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: DateTime.now(),
                        );

                        since = date;
                        setState(() {});
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: i18n(context, S.input_message_search_since),
                        ),
                        child: SizedBox(
                            height: 20,
                            child: since == null
                                ? null
                                : Text(dateFormat.format(since))),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: DateTime.now(),
                        );
                        till = date;
                        setState(() {});
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: i18n(context, S.input_message_search_till),
                        ),
                        child: SizedBox(
                          height: 20,
                          child: till == null
                              ? null
                              : Text(dateFormat.format(till)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: i18n(context, S.messages_view_tab_attachments),
                    ),
                    onChanged: (v) {
                      if (previousText.isEmpty != v.isEmpty) {
                        setState(() {});
                      }
                      previousText = v;
                    },
                    controller: attachmentCtrl,
                  ),
                  Checkbox(
                    value: withAttachment || attachmentCtrl.text.isNotEmpty,
                    onChanged: (bool value) {
                      if (attachmentCtrl.text.isEmpty) {
                        withAttachment = value;
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(i18n(context, S.btn_cancel)),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(i18n(context, S.messages_list_app_bar_search)),
          onPressed: _search,
        ),
      ],
    );
  }

  _search() {
    var searchString = "";
    if (fromCtrl.text.isNotEmpty) {
      searchString += searchUtil.wrap(SearchPattern.From, fromCtrl.text);
      searchString += " ";
    }
    if (toCtrl.text.isNotEmpty) {
      searchString += searchUtil.wrap(SearchPattern.To, toCtrl.text);
      searchString += " ";
    }
    if (subjectCtrl.text.isNotEmpty) {
      searchString += searchUtil.wrap(SearchPattern.Subject, subjectCtrl.text);
      searchString += " ";
    }
    if (textCtrl.text.isNotEmpty) {
      searchString += searchUtil.wrap(SearchPattern.Text, textCtrl.text);
      searchString += " ";
    }
    if (attachmentCtrl.text.isNotEmpty) {
      searchString +=
          searchUtil.wrap(SearchPattern.Attachment, attachmentCtrl.text);
      searchString += " ";
    }
    if (withAttachment) {
      searchString += searchUtil.wrapFlag([SearchFlag.Attachment]);
      searchString += " ";
    }
    if (since != null || till != null) {
      searchString += searchUtil.wrapDate(since, till);
      searchString += " ";
    }
    Navigator.pop(context, searchString);
  }
}
