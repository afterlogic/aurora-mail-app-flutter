import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainInfo extends StatelessWidget {
  final String? title;
  final String? description;
  final String? location;

  const MainInfo(
      {super.key,
      required this.description,
      required this.location,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
