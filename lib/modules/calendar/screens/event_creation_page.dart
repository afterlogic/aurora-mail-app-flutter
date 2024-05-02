import 'package:aurora_mail/generated/l10n.dart';
import 'package:aurora_mail/modules/calendar/widgets/calendar_tile.dart';
import 'package:aurora_mail/modules/calendar/widgets/text_input.dart';
import 'package:aurora_ui_kit/aurora_ui_kit.dart';
import 'package:flutter/material.dart';

class EventCreationPage extends StatefulWidget {
  static const name = "calendar_creation_page";
  const EventCreationPage({super.key});

  @override
  State<EventCreationPage> createState() => _EventCreationPageState();
}

class _EventCreationPageState extends State<EventCreationPage> {

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // #B6B5B5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AMAppBar(
        title: Text('New Event'),
        actions: [
          TextButton(onPressed: () {}, child: Text(S.of(context).btn_save))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CalendarTile(
                    circleColor: Colors.indigoAccent, text: 'My calendar'),
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: _titleController,
                  labelText: 'Title',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: _descriptionController,
                  labelText: 'Description',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: _locationController,
                  labelText: 'Location',
                ),
              ],
            ),
          ),
          const Divider(color: const Color(0xFFB6B5B5))
        ],
      ),
    );
  }
}
