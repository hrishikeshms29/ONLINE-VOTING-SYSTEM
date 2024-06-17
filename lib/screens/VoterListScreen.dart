import 'package:flutter/material.dart';
import '../services/election_repository.dart';

class VoterListScreen extends StatelessWidget {
  final String electionId;
  final String classId;

  const VoterListScreen({Key? key, required this.electionId, required this.classId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Details')),
      body: FutureBuilder<List<String>>(
        future: ElectionRepository.getVotersInClass(electionId, classId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final voters = snapshot.data ?? [];
          return ListView.builder(
            itemCount: voters.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(voters[index]),
              );
            },
          );
        },
      ),
    );
  }
}
