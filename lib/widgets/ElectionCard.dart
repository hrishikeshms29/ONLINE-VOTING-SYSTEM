import 'package:flutter/material.dart';

class ElectionCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ElectionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        onTap: onTap,
      ),
    );
  }
}
