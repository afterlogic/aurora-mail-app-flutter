import 'package:aurora_mail/modules/calendar/ui/widgets/text_input.dart';
import 'package:flutter/material.dart';

class MainInfo extends StatelessWidget {
  final String? title;
  final String? description;
  final String? location;
  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final TextEditingController? locationController;
  final bool isEditable;

  /// if [isEditable] is true, controllers must be provided
  const MainInfo(
      {super.key,
      this.isEditable = false,
      this.titleController,
      this.descriptionController,
      this.locationController,
      this.description,
      this.location,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isEditable
          ? [
              TextInput(
                controller: titleController!,
                labelText: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                multiLine: true,
                controller: descriptionController!,
                labelText: 'Description',
              ),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                multiLine: true,
                controller: locationController!,
                labelText: 'Location',
              ),
            ]
          : [
              Text('Title', style: TextStyle(color: Colors.grey)),
              const SizedBox(
                height: 4,
              ),
              Text(title ?? ''),
              const SizedBox(
                height: 20,
              ),
              Text('Description', style: TextStyle(color: Colors.grey)),
              const SizedBox(
                height: 4,
              ),
              Text(description ?? ''),
              const SizedBox(
                height: 20,
              ),
              Text('Location', style: TextStyle(color: Colors.grey)),
              const SizedBox(
                height: 4,
              ),
              Text(location ?? ''),
            ],
    );
  }
}
