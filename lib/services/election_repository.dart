import 'package:cloud_firestore/cloud_firestore.dart';

class ElectionRepository {
  static Future<List<Map<String, dynamic>>> getUpcomingElections() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('elections')
          .where('date', isGreaterThan: Timestamp.now())
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Error fetching upcoming elections: $e');
    }
  }

  static Future<Map<String, dynamic>> getElectionDetails(String electionId) async {
    try {
      final electionDoc =
      await FirebaseFirestore.instance.collection('elections').doc(electionId).get();

      if (electionDoc.exists) {
        final electionData = electionDoc.data()!;
        final classesSnapshot =
        await FirebaseFirestore.instance.collection('elections/$electionId/classes').get();
        final classesData = classesSnapshot.docs.map((doc) {
          final data = doc.data();
          data['classId'] = doc.id;
          return data;
        }).toList();
        electionData['classes'] = classesData;
        return electionData;
      } else {
        throw Exception('Election not found');
      }
    } catch (e) {
      throw Exception('Error fetching election details: $e');
    }
  }

  static Future<List<String>> getVotersInClass(String electionId, String classId) async {
    try {
      final votersSnapshot = await FirebaseFirestore.instance
          .collection('elections/$electionId/classes/$classId/voters')
          .get();
      return votersSnapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      throw Exception('Error fetching voters: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  static Future<void> addVoterToClass(String electionId, String classId, String voterId) async {
    try {
      await FirebaseFirestore.instance
          .collection('elections/$electionId/classes/$classId/voters')
          .doc(voterId)
          .set({});
    } catch (e) {
      throw Exception('Error adding voter: $e');
    }
  }
}
