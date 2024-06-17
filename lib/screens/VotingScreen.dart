import 'package:flutter/material.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voting')),
      body: Center(
        child: Text(
          'Voting functionality goes here!',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
