import 'package:electro_vote/screens/ElectionInfoScreen.dart';
import 'package:flutter/material.dart';
import '../services/election_repository.dart';

class ElectionsListScreen extends StatelessWidget {
  const ElectionsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Elections')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ElectionRepository.getUpcomingElections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No upcoming elections found.'));
          } else {
            final elections = snapshot.data!;
            return ListView.builder(
              itemCount: elections.length,
              itemBuilder: (context, index) {
                final election = elections[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(election['title']),
                    subtitle: Text(election['description']),
                    trailing: Text(election['date'].toDate().toString().split(' ')[0]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElectionInfoScreen(electionId: election['id']),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
