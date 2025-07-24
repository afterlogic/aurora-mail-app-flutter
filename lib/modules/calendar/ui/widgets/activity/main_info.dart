import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:aurora_mail/utils/input_utils.dart';
import 'package:aurora_mail/generated/l10n.dart';

class MainInfo extends StatelessWidget {
  final String? title;
  final String? description;
  final String? location;
  final TextEditingController? titleController;
  final TextEditingController? descriptionController;
  final TextEditingController? locationController;
  final FocusNode? titleFocus;
  final FocusNode? descriptionFocus;
  final FocusNode? locationFocus;
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
      this.title,
      this.titleFocus,
      this.descriptionFocus,
      this.locationFocus});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isEditable
          ? [
              InputUtils.buildUnlymeTextFormField(
                controller: titleController!,
                focusNode: titleFocus!,
                labelText: S.of(context).calendar_input_title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text';
                  }
                  return null;
                },
                keyboardType: null,
                enabled: true,
                onChanged: null,
                onEditingComplete: null,
                obscureText: false,
                maxLines: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              InputUtils.buildUnlymeTextFormField(
                controller: descriptionController!,
                focusNode: descriptionFocus!,
                labelText: S.of(context).calendar_input_description,
                keyboardType: TextInputType.multiline,
                enabled: true,
                validator: null,
                onChanged: null,
                onEditingComplete: null,
                obscureText: false,
                maxLines: 4,
              ),
              const SizedBox(
                height: 20,
              ),
              InputUtils.buildUnlymeTextFormField(
                controller: locationController!,
                focusNode: locationFocus!,
                labelText: S.of(context).calendar_input_location,
                keyboardType: TextInputType.multiline,
                enabled: true,
                validator: null,
                onChanged: null,
                onEditingComplete: null,
                obscureText: false,
                maxLines: 4,
              ),
            ]
          : [
              if (title?.isNotEmpty ?? false) ...[
                Text(S.of(context).calendar_input_title, style: TextStyle(color: Colors.grey)),
                const SizedBox(
                  height: 4,
                ),
                Text(title!),
                const SizedBox(
                  height: 20,
                ),
              ],
              if (description?.isNotEmpty ?? false) ...[
                Text(S.of(context).calendar_input_description, style: TextStyle(color: Colors.grey)),
                const SizedBox(
                  height: 4,
                ),
                LinkWell(description!),
                const SizedBox(
                  height: 20,
                ),
              ],
              if (description?.isNotEmpty ?? false) ...[
                Text(S.of(context).calendar_input_location, style: TextStyle(color: Colors.grey)),
                const SizedBox(
                  height: 4,
                ),
                LinkWell(location!),
              ],
            ],
    );
  }
}
