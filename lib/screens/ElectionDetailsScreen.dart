import 'package:electro_vote/screens/voter_screen.dart';
import 'package:flutter/material.dart';
import '../services/election_service.dart';

class ElectionDetailsScreen extends StatelessWidget {
  final String electionId;

  const ElectionDetailsScreen({Key? key, required this.electionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Election Details')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ElectionService.getElectionDetails(electionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading election details'));
          }

          final Map<String, dynamic> electionDetails = snapshot.data ?? {};
          final List<dynamic> classes = electionDetails['classes'] ?? [];

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
              // Display classes with edit option
              const SizedBox(height: 16),
              const Text('Classes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (classes.isNotEmpty)
                ...classes.map((classData) {
                  final String classId = classData['classId'].toString();
                  final String className = classData['className'] as String;
                  return ListTile(
                    title: Text('Class $classId: $className'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _editClassName(context, electionId, classId, className);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.person),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VoterScreen(
                                  electionId: electionId,
                                  classId: classId,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );

                }).toList(),
              // Button to navigate to VoterScreen
              const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => VoterScreen(
              //           electionId: electionId,
              //         ),
              //       ),
              //     );
              //   },
              //   child: const Text('View Voters'),
              // ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _editClassName(BuildContext context, String electionId, String classId, String currentClassName) async {
    final TextEditingController _newClassNameController = TextEditingController(text: currentClassName);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Class Name'),
          content: TextFormField(
            controller: _newClassNameController,
            decoration: const InputDecoration(labelText: 'New Class Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_newClassNameController.text.isNotEmpty) {
                  await ElectionService.updateClassName(electionId, int.parse(classId), _newClassNameController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
