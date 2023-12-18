import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String phone;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone});

  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return User(
      id: snapshot['userId'] ?? '',
      name: snapshot['name'] ?? '',
      email: snapshot['email'] ?? '',
      phone: snapshot['phone'] ?? '',
    );
  }
}

Future<DocumentSnapshot> getUserDocument(String userId) async {
  try {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return userSnapshot;
  } catch (e) {
    print('Error retrieving user document: $e');
    throw e; // You can handle the error accordingly in the calling code
  }
}
