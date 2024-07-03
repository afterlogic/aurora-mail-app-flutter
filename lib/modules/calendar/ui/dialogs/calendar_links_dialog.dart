import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalendarLinksDialog extends StatefulWidget {
  final Calendar calendar;
  const CalendarLinksDialog(this.calendar);

  static Future show(BuildContext context, {required Calendar calendar}) {
    return showDialog(
        context: context, builder: (_) => CalendarLinksDialog(calendar));
  }

  @override
  State<CalendarLinksDialog> createState() => _CalendarLinksDialogState();
}

class _CalendarLinksDialogState extends State<CalendarLinksDialog> {
  bool isPublicLinkEnabled = false;


  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      removeContentPadding: true,
      title: 'Get a link',
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LinkSection(
              title: 'DAV URL',
              url:
                  'https://caldav.afterlogic.com/calendars/502f898e-0321-49b3-9581-efc1585b2405',
            ),
            SizedBox(height: 16),
            _LinkSection(
              title: 'Ссылка на .ics',
              url:
                  'https://caldav.afterlogic.com/calendars/502f898e-0321-49b3-9581-efc1585b2405',
              titleIcon: IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(
                  Icons.file_download_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: (){
                setState(() {
                  isPublicLinkEnabled = !isPublicLinkEnabled;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isPublicLinkEnabled,
                        onChanged: (bool? value) {
                          setState(() {
                            isPublicLinkEnabled = value ?? false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Get a public link to the calendar',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            if (isPublicLinkEnabled) ...[
              const SizedBox(
                height: 8,
              ),
              _LinkSection(
                url:
                    'https://afterlogic.com/calendars/502f898e-0321-49b3-9581-efc1585b2405',
              ),
            ]
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class _LinkSection extends StatelessWidget {
  final String? title;
  final String url;
  final Widget? titleIcon;
  const _LinkSection(
      {super.key, this.title, required this.url, this.titleIcon});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!, style: TextStyle(fontSize: 14)),
                if (titleIcon != null) titleIcon!
              ],
            ),
          ),
        if (title != null) const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: url));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.copy_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    url,
                    style: TextStyle(
                        color: Theme.of(context).disabledColor, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(color: Color(0xFFCBCBCB), thickness: 1.25,)
      ],
    );
  }
}
