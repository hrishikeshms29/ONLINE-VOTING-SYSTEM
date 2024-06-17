import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String address,
    required String sex,
    required String dob,
    required String recoveryEmail,
    required String recoveryPhone,
    String? profileImageUrl,
    String? fingerprintData,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'sex': sex,
      'dob': dob,
      'recoveryEmail': recoveryEmail,
      'recoveryPhone': recoveryPhone,
      'profileImageUrl': profileImageUrl,
      'fingerprintData': fingerprintData,
    });
  }
}
