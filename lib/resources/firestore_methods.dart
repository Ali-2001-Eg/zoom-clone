import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetingHistory')
      .orderBy('createdAt', descending: true)
      .snapshots();

  void addToMeetingHistory(String meetingName) {
    try {
      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetingHistory')
          .add({
        'meetingName': meetingName,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
