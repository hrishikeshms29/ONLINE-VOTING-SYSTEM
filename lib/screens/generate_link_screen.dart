import 'package:flutter/material.dart';
import '../services/election_service.dart';

class GenerateLinkScreen extends StatelessWidget {
  final String electionId;

  const GenerateLinkScreen({Key? key, required this.electionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final link = 'https://yourapp.com/join/$electionId';

    return Scaffold(
      appBar: AppBar(title: const Text('Election Link')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Share this link to join the election:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16),
            SelectableText(
              link,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.blue),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to a screen where you can add voters or classes
              },
              child: const Text('Add Voters or Classes'),
            ),
          ],
        ),
      ),
    );
  }
}
