
import 'package:aurora_mail/build_property.dart';
import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/mail/repository/search_util.dart';
import 'package:aurora_mail/utils/input_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdvancedSearch extends StatefulWidget {
  final String? searchText;

  AdvancedSearch(this.searchText);

  @override
  State<StatefulWidget> createState() => AdvancedSearchState();
}

class AdvancedSearchState extends State<AdvancedSearch> {
  bool? withAttachment = false;
  TextEditingController? fromCtrl;
  TextEditingController? toCtrl;
  TextEditingController? subjectCtrl;
  TextEditingController? textCtrl;
  DateTime? since;
  DateTime? till;

  final DateFormat dateFormat = DateFormat('dd.MM.yyyy');

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
          till = item.till;
          break;
        case SearchPattern.Text:
          textCtrl = TextEditingController(text: item.value);
          break;
        case SearchPattern.Attachment:
          // Ignore the attachment text, use only the checkbox
          break;
      }
    });
    fromCtrl ??= TextEditingController();
    toCtrl ??= TextEditingController();
    subjectCtrl ??= TextEditingController();
    textCtrl ??= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDialogWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.9;

    return AlertDialog(
      title: Text(S.of(context).label_message_advanced_search),
      content: SizedBox(
        width: maxDialogWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16.0),
              InputUtils.buildUnlymeTextField(
                controller: fromCtrl!,
                labelText: S.of(context).messages_from,
              ),
              SizedBox(height: BuildProperty.useCustomInputStyles ? 16.0 : 8.0),
              InputUtils.buildUnlymeTextField(
                controller: toCtrl!,
                labelText: S.of(context).messages_to,
              ),
              SizedBox(height: BuildProperty.useCustomInputStyles ? 16.0 : 8.0),
              InputUtils.buildUnlymeTextField(
                controller: subjectCtrl!,
                labelText: S.of(context).messages_subject,
              ),
              SizedBox(height: BuildProperty.useCustomInputStyles ? 16.0 : 8.0),
              InputUtils.buildUnlymeTextField(
                controller: textCtrl!,
                labelText: S.of(context).input_message_search_text,
              ),
              SizedBox(height: BuildProperty.useCustomInputStyles ? 16.0 : 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: InputUtils.buildUnlymeInputDecorator(
                      context: context,
                      labelText: S.of(context).input_message_search_since,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          since = date;
                          setState(() {});
                        }
                      },
                      child: since == null
                          ? null
                          : SizedBox(
                              height: 20,
                              child: Center(
                                child: Text(dateFormat.format(since!)),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: InputUtils.buildUnlymeInputDecorator(
                      context: context,
                      labelText: S.of(context).input_message_search_till,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          till = date;
                          setState(() {});
                        }
                      },
                      child: till == null
                          ? null
                          : SizedBox(
                              height: 20,
                              child: Center(
                                child: Text(dateFormat.format(till!)),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: BuildProperty.useCustomInputStyles ? 16.0 : 8.0),
              Row(
                children: [
                  Checkbox(
                    value: withAttachment,
                    onChanged: (bool? value) {
                      withAttachment = value;
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        withAttachment = !withAttachment!;
                        setState(() {});
                      },
                      child: Text(
                        S.of(context).messages_view_tab_attachments,
                        style: TextStyle(
                          color: BuildProperty.useCustomInputStyles
                              ? Color(0xFF6F788D)
                              : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).btn_cancel),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(S.of(context).messages_list_app_bar_search),
          onPressed: _search,
        ),
      ],
    );
  }

  _search() {
    var searchString = "";
    if (fromCtrl!.text.isNotEmpty) {
      searchString += searchUtil.wrap(SearchPattern.From, fromCtrl!.text);
      searchString += " ";
    }
    if (toCtrl!.text.isNotEmpty) {
      searchString += searchUtil.wrap(SearchPattern.To, toCtrl!.text);
      searchString += " ";
    }
    if (subjectCtrl!.text.isNotEmpty) {
      searchString += searchUtil.wrap(SearchPattern.Subject, subjectCtrl!.text);
      searchString += " ";
    }
    if (textCtrl!.text.isNotEmpty) {
      searchString += searchUtil.wrap(SearchPattern.Text, textCtrl!.text);
      searchString += " ";
    }
    if (withAttachment!) {
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
