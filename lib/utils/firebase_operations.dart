import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
class FirebaseOperation {
  static Future<void> addIssue(String subject, String description) async {
    _firebaseFirestore
      .collection('issues')
      .add({
        "subject": subject,
        "description": description,
      })
      .whenComplete(() => print("Success"))
      .catchError((e) => {print(e.toString())});
  }
}