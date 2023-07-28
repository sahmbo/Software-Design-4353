import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  Future<void> saveProfileData(String collectionPath, String? username, Map<String, dynamic> profile) async {
    // Save the profile data to Firestore using the provided collection path
    await FirebaseFirestore.instance.collection(collectionPath).doc(username).set(profile);
  }
}