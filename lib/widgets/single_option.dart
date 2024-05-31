import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final List<String> options;

  const Options({required this.options, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: options.map((option) {
        return Chip(
          label: Text(option),
          backgroundColor: Colors.grey[200],
        );
      }).toList(),
    );
  }
}
