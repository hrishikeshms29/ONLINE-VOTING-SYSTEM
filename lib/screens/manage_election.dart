import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/election_service.dart';
import 'ElectionDetailsScreen.dart'; // Import ElectionDetailsScreen

class ManageElectionScreen extends StatefulWidget {
  final String userId; // Add userId parameter

  const ManageElectionScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ManageElectionScreenState createState() => _ManageElectionScreenState();
}

class _ManageElectionScreenState extends State<ManageElectionScreen> {
  final _classController = TextEditingController();
  final _newClassNameController = TextEditingController();
  List<String> _elections = []; // List to store hosted election IDs

  @override
  void initState() {
    super.initState();
    _fetchHostedElections();
  }

  @override
  void dispose() {
    _classController.dispose();
    _newClassNameController.dispose();
    super.dispose();
  }

  Future<void> _fetchHostedElections() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? user = _auth.currentUser;
      var userId = user?.uid;

      // Get the stream of hosted elections
      final Stream<QuerySnapshot<Object?>> hostedElectionsStream =
      ElectionService.getHostedElections(userId!);

      // Listen to the stream and update the list of elections
      hostedElectionsStream.listen((QuerySnapshot<Object?> snapshot) {
        List<String> elections = [];
        snapshot.docs.forEach((DocumentSnapshot<Object?> document) {
          // Extract the election ID from each document
          String electionId = document.id;
          elections.add(electionId);
        });
        setState(() {
          _elections = elections;
        });
      });
    } catch (e) {
      // Handle error
      print('Error fetching hosted elections: $e');
    }
  }


  Future<void> _addClass() async {
    // Same as before
  }

  Future<void> _updateClassName() async {
    // Same as before
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Elections')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // List of hosted elections
            Expanded(
              child: ListView.builder(
                itemCount: _elections.length,
                itemBuilder: (context, index) {
                  final electionId = _elections[index];
                  return Card(
                    child: ListTile(
                      title: Text('Election ID: $electionId'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ElectionDetailsScreen(electionId: electionId),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Add and update class widgets
          ],
        ),
      ),
    );
  }
}
