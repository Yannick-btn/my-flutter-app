import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/models/message.dart';

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
          .where((user) => user["uid"] != _auth.currentUser?.uid)
          .toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user info
    final String currenUserId = _auth.currentUser!.uid;
    final String currenUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a message
    Message newMessage = Message(
        senderID: currenUserId,
        senderEmail: currenUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    // construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currenUserId, receiverID];
    ids.sort(); // sort the ids (make sure the chatroomID is the same for any 2 people)
    String chatRoomID = ids.join('_');
    // add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }
  // get messages

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construct a chatroomID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
