import 'package:flutter/material.dart';

class AddIcon extends StatelessWidget {
  const AddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.add,
      color: Theme.of(context).primaryColor,
      size: 26,
    );
  }
}