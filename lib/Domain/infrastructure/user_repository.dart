import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getUsers() async {
    try {
      return await _firestore.collection('users').get();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
