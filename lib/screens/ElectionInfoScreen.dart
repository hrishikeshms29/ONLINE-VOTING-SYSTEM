import 'package:electro_vote/screens/VoterListScreen.dart';
import 'package:flutter/material.dart';
import '../services/election_repository.dart';

class ElectionInfoScreen extends StatelessWidget {
  final String electionId;

  const ElectionInfoScreen({Key? key, required this.electionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Election Details')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ElectionRepository.getElectionDetails(electionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading election details'));
          }

          final electionDetails = snapshot.data ?? {};
          final classes = electionDetails['classes'] ?? [];

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(
                title: const Text('Title'),
                subtitle: Text(electionDetails['title'] ?? ''),
              ),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(electionDetails['description'] ?? ''),
              ),
              const SizedBox(height: 16),
              const Text('Classes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (classes.isNotEmpty)
                ...classes.map((classData) {
                  final classId = classData['classId'];
                  final className = classData['className'];
                  return ListTile(
                    title: Text('Class $classId: $className'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VoterListScreen(
                            electionId: electionId,
                            classId: classId,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
            ],
          );
        },
      ),
    );
  }
}
