import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  /*
  Stream<List<Map<String,dynamic>>> = 

  Stream meaning we are going to listen to or firestore
  list [
  map 
  {
    'email': test@gmail.com,
    'id': ...
  },
   {
    'email': bob@gmail.com,
    'id': ...
  },
]
  */

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data())
          .where((user) =>
              user["uid"] !=
              _auth.currentUser?.uid) // Exclure l'utilisateur connecté
          .toList();
    });
  }

  // send message

  // get messages
}
