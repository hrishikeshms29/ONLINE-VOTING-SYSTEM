import 'package:electro_vote/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _recoveryEmailController = TextEditingController();
  final TextEditingController _recoveryPhoneController = TextEditingController();
  String? _profileImageUrl;
  String? _sex;
  final List<String> _sexOptions = ['Male', 'Female', 'Other'];

  final AuthService _authService = AuthService();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();
      setState(() {
        _profileImageUrl = downloadUrl;
      });
    }
  }

  Future<void> _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _authService.updateProfile(
        uid: user.uid,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        address: _addressController.text,
        sex: _sex ?? '',
        dob: _dobController.text,
        recoveryEmail: _recoveryEmailController.text,
        recoveryPhone: _recoveryPhoneController.text,
        profileImageUrl: _profileImageUrl,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_profileImageUrl != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_profileImageUrl!),
                ),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Pick Profile Image'),
              ),
              CustomTextField(
                controller: _firstNameController,
                label: 'First Name',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _lastNameController,
                label: 'Last Name',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _addressController,
                label: 'Address',
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _sex,
                items: _sexOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _sex = newValue;
                  });
                },
                decoration: const InputDecoration(labelText: 'Sex'),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _dobController,
                    label: 'Date of Birth',
                    // suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _recoveryEmailController,
                label: 'Recovery Email',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _recoveryPhoneController,
                label: 'Recovery Phone',
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Update Profile',
                onPressed: _updateProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
