import 'package:flutter/material.dart';

class ElectionScreen extends StatelessWidget {
  const ElectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Elections')),
      body: Center(
        child: Text(
          'Election List goes here!',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
