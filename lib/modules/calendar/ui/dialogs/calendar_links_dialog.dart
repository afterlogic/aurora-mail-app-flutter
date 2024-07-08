import 'package:aurora_mail/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:aurora_mail/modules/calendar/blocs/calendars/calendars_bloc.dart';
import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:aurora_mail/modules/calendar/ui/dialogs/base_calendar_dialog.dart';
import 'package:aurora_mail/modules/calendar/ui/models/calendar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class CalendarLinksDialog extends StatefulWidget {
  final String calendarId;
  const CalendarLinksDialog(this.calendarId);

  static Future show(BuildContext context, {required String calendarId}) {
    return showDialog(
        context: context, builder: (_) => CalendarLinksDialog(calendarId));
  }

  @override
  State<CalendarLinksDialog> createState() => _CalendarLinksDialogState();
}

class _CalendarLinksDialogState extends State<CalendarLinksDialog> {
  late final CalendarsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CalendarsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseCalendarDialog(
      removeContentPadding: true,
      title: 'Get a link',
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: BlocBuilder<CalendarsBloc, CalendarsState>(
          builder: (context, state) {
            final selectedCalendar = state.calendars
                ?.firstWhereOrNull((e) => e.id == widget.calendarId);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LinkSection(
                  title: 'DAV URL',
                  url: selectedCalendar?.DAVUrl,
                ),
                SizedBox(height: 16),
                _LinkSection(
                  title: 'Link to .ics',
                  url: selectedCalendar?.ICSUrl,
                  titleIcon: IconButton(
                    onPressed: () async {
                      if (selectedCalendar == null) return;
                      final externalStorageDirPath =
                          (await getApplicationDocumentsDirectory())
                              .absolute
                              .path;
                      FlutterDownloader.enqueue(
                        url: selectedCalendar.getDownloadUrl(
                            BlocProvider.of<AuthBloc>(context).currentUser),
                        savedDir: externalStorageDirPath,
                        fileName: selectedCalendar.exportHash,
                        saveInPublicStorage: true,
                      );
                    },
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
                  onTap: () {
                    if (selectedCalendar != null) {
                      bloc.add(UpdateCalendarPublic(selectedCalendar));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: selectedCalendar?.isPublic,
                            onChanged: (bool? value) {
                              if (selectedCalendar != null) {
                                bloc.add(
                                    UpdateCalendarPublic(selectedCalendar));
                              }
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
                if (selectedCalendar?.isPublic == true) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  _LinkSection(
                    url: selectedCalendar?.getPublicLink(
                        BlocProvider.of<AuthBloc>(context).currentUser),
                  ),
                ]
              ],
            );
          },
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
  final String? url;
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
                    url ?? '',
                    style: TextStyle(
                        color: Theme.of(context).disabledColor, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Color(0xFFCBCBCB),
          thickness: 1.25,
        )
      ],
    );
  }
}
