import 'package:aurora_mail/modules/calendar/calendar_domain/models/calendar.dart';
import 'package:flutter/material.dart';

class ParticipantCard extends StatelessWidget {
  const ParticipantCard(
      {super.key,
      required this.participant,
      required this.onDelete,
      required this.onSelectedPermissionsOption});

  final Participant participant;
  final VoidCallback onDelete;
  final void Function(ParticipantPermissions?) onSelectedPermissionsOption;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Row(
          children: [
            Text(
              participant is ParticipantAll ? 'All' : participant.email,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton<ParticipantPermissions>(
                    onSelected: onSelectedPermissionsOption,
                    itemBuilder: (context) {
                      return ParticipantPermissions.values
                          .map((e) => PopupMenuItem(
                                value: e,
                                child: Text(e.buildString),
                              ))
                          .toList();
                    },
                    child: Text(
                      participant.permissions.buildString,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  const SizedBox(width: 4,),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.close),
                    onPressed: onDelete,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension ParticipantPermissionsString on ParticipantPermissions {
  String get buildString {
    switch (this) {
      case ParticipantPermissions.read:
        return ('Read');
      case ParticipantPermissions.readWrite:
        return ('Read/Write');
    }
  }
}
