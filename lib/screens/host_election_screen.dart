import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/election_service.dart';

class HostElectionScreen extends StatefulWidget {
  const HostElectionScreen({Key? key}) : super(key: key);

  @override
  _HostElectionScreenState createState() => _HostElectionScreenState();
}

class _HostElectionScreenState extends State<HostElectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _constituenciesController = TextEditingController();
  final _registrationDeadlineController = TextEditingController();
  final _timeController = TextEditingController();
  final _resultDateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _constituenciesController.dispose();
    _registrationDeadlineController.dispose();
    _timeController.dispose();
    _resultDateController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final date = DateTime.parse(_dateController.text);
      final location = _locationController.text;
      final constituencies = int.parse(_constituenciesController.text);
      final registrationDeadline = DateTime.parse(_registrationDeadlineController.text);
      final time = _timeController.text;
      final resultDate = DateTime.parse(_resultDateController.text);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? user = _auth.currentUser;
      var creatorId = "exampleCreatorId"; // Replace with actual creator ID
      if (user != null) {
        creatorId = user.uid;
      }
      // final creatorId = "exampleCreatorId"; // Replace with actual creator ID

      final electionId = await ElectionService.createElection(
        title,
        description,
        date,
        location,
        constituencies,
        registrationDeadline,
        time,
        resultDate,
        creatorId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Election created successfully!')),
      );

      Navigator.pushNamed(context, '/election-details', arguments: electionId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Host an Election')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                    return 'Please enter a valid date (YYYY-MM-DD)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _constituenciesController,
                decoration: const InputDecoration(labelText: 'Number of Constituencies'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of constituencies';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _registrationDeadlineController,
                decoration: const InputDecoration(labelText: 'Registration Deadline (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registration deadline';
                  }
                  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                    return 'Please enter a valid date (YYYY-MM-DD)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time of Election'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time of the election';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _resultDateController,
                decoration: const InputDecoration(labelText: 'Result Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the result date';
                  }
                  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                    return 'Please enter a valid date (YYYY-MM-DD)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Election'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
