import 'package:electro_vote/services/election_service.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class VoterScreen extends StatefulWidget {
  final String electionId;
  final String classId;

  const VoterScreen({Key? key, required this.electionId, required this.classId})
      : super(key: key);

  @override
  _VoterScreenState createState() => _VoterScreenState();
}

class _VoterScreenState extends State<VoterScreen> {
  final List<MultiSelectItem<String>> _items = [];
  List<String> _selectedVoters = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final List<Map<String, dynamic>> users = await ElectionService.getUsers();
      setState(() {
        _items.clear();
        for (var user in users) {
          final String displayName = '${user['firstName']} ${user['lastName']}';
          _items.add(MultiSelectItem<String>(user['uid'], displayName));
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load users: $e')),
      );
    }
  }

  Future<void> _addVoters() async {
    if (_selectedVoters.isNotEmpty) {
      try {
        for (String voterId in _selectedVoters) {
          await ElectionService.addVoterToClass(widget.electionId, widget.classId, voterId);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voters added successfully!')),
        );
        setState(() {
          _selectedVoters.clear();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add voters: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voters')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MultiSelectDialogField(
              items: _items,
              title: const Text('Select Voters'),
              selectedColor: Theme.of(context).primaryColor,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.person_add,
                color: Colors.blue,
              ),
              buttonText: const Text(
                'Add Voters',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              onConfirm: (results) {
                setState(() {
                  _selectedVoters = results.cast<String>();
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addVoters,
              child: const Text('Add Selected Voters'),
            ),
            const SizedBox(height: 32),
            const Text(
              'Voters List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: ElectionService.getVotersInClass(widget.electionId, widget.classId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final voters = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: voters.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(voters[index]),
                        // Add any additional voter information if needed
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
