import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Center(
        child: Text(
          'Results will be displayed here!',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
