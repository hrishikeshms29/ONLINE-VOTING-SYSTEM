import 'package:cloud_firestore/cloud_firestore.dart';

class ElectionService {
  static Future<String> createElection(
      String title,
      String description,
      DateTime date,
      String location,
      int constituencies,
      DateTime registrationDeadline,
      String time,
      DateTime resultDate,
      String creatorId) async {
    final electionRef = FirebaseFirestore.instance.collection('elections').doc();
    await electionRef.set({
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'location': location,
      'constituencies': constituencies,
      'registrationDeadline': Timestamp.fromDate(registrationDeadline),
      'time': time,
      'resultDate': Timestamp.fromDate(resultDate),
      'creatorId': creatorId,
    });

    // Create constituency collections
    for (int i = 0; i < constituencies; i++) {
      final className = 'Class ${i + 1}';
      final classId = 1000 + i + 1; // Generate class ID
      await addClass(electionRef.id, classId, className);
    }

    return electionRef.id;
  }
  static Stream<QuerySnapshot> getHostedElections(String userId) {
    return FirebaseFirestore.instance
        .collection('elections')
        .where('creatorId', isEqualTo: userId)
        .snapshots();
  }
  static Future<Map<String, dynamic>> getElectionDetails(String electionId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> electionDoc =
      await FirebaseFirestore.instance.collection('elections').doc(electionId).get();

      if (electionDoc.exists) {
        final Map<String, dynamic> electionData = electionDoc.data()!;

        // Fetch classes documents under the election
        final QuerySnapshot<Map<String, dynamic>> classesSnapshot =
        await FirebaseFirestore.instance.collection('elections/$electionId/classes').get();

        // Convert classes data to a Map
        final List<Map<String, dynamic>> classesData = classesSnapshot.docs.map((doc) {
          final data = doc.data();
          data['classId'] = doc.id;  // Store the class document ID as classId
          return data;
        }).toList();

        // Add classes data to the election data
        electionData['classes'] = classesData;

        return electionData;
      } else {
        throw Exception('Election not found');
      }
    } catch (e) {
      throw Exception('Error fetching election details: $e');
    }
  }

  static Future<void> addVotersCollection(String electionId, String className) async {
    final classRef = FirebaseFirestore.instance
        .collection('elections')
        .doc(electionId)
        .collection('classes')
        .doc(className)
        .collection('voters');
    // Add a dummy document to initialize the collection
    await classRef.add({'init': true});
  }

  static Future<void> addVoterToClass(String electionId, String classId, String voterId) async {
    // Check if the voter ID already exists in other classes of the same election
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('elections')
        .doc(electionId)
        .collection('classes')
        .get();

    for (final QueryDocumentSnapshot classSnapshot in querySnapshot.docs) {
      final classData = classSnapshot.data();
      final classRef = classSnapshot.reference;

      final votersSnapshot = await classRef.collection('voters').where('voterId', isEqualTo: voterId).get();
      if (votersSnapshot.docs.isNotEmpty) {
        // Voter ID already exists in another class, handle accordingly
        return Future.error('Voter ID already exists in another class');
      }
    }

    // Add voter to the specified class
    final voterRef = FirebaseFirestore.instance
        .collection('elections')
        .doc(electionId)
        .collection('classes')
        .doc(classId)
        .collection('voters')
        .doc(voterId);

    await voterRef.set({'voterId': voterId});
  }

  static Future<List<String>> getVotersInClass(String electionId, String classId) async {
    final votersQuerySnapshot = await FirebaseFirestore.instance
        .collection('elections')
        .doc(electionId)
        .collection('classes')
        .doc(classId)
        .collection('voters')
        .get();

    final List<String> voters = [];
    for (final voterSnapshot in votersQuerySnapshot.docs) {
      voters.add(voterSnapshot.data()['voterId']);
    }
    return voters;
  }

  static Future<void> addClass(String electionId, int classId, String className) async {
    final classRef = FirebaseFirestore.instance
        .collection('elections')
        .doc(electionId)
        .collection('classes')
        .doc('$classId');
    await classRef.set({'className': className});
  }

  static Future<void> updateClassName(String electionId, int classId, String newClassName) async {
    final classRef = FirebaseFirestore.instance
        .collection('elections')
        .doc(electionId)
        .collection('classes')
        .doc('$classId');
    await classRef.update({'className': newClassName});
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> usersSnapshot =
      await FirebaseFirestore.instance.collection('users').get();

      final List<Map<String, dynamic>> users = usersSnapshot.docs.map((doc) {
        return {
          'uid': doc.id,
          'firstName': doc.data()['firstName'] ?? 'Unknown',
          'lastName': doc.data()['lastName'] ?? 'Unknown',

        };
      }).toList();

      return users;
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  // static Future<void> updateClassName(
  //     String electionId, String oldClassName, String newClassName) async {
  //   final classRef = FirebaseFirestore.instance
  //       .collection('elections')
  //       .doc(electionId)
  //       .collection('classes')
  //       .doc(oldClassName);
  //   await classRef.update({'className': newClassName});
  // }
}
