import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '/constants/constants.dart';
import '/models/message_model.dart';
import '/models/user_model.dart';

class FireStoreServices {
  final _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  createUser(String userID, UserModel user) async => await _firebaseFirestore
      .collection(FirestoreConstants.pathUserCollection)
      .doc(userID)
      .set(user.toJson());

  sendMessage(MessageModel message, String roomId) async => await _firebaseFirestore
      .collection(FirestoreConstants.pathRoomCollection)
      .doc(roomId)
      .collection(FirestoreConstants.pathRoomConversationsCollection)
      .add(message.toJson());

  Stream<QuerySnapshot> snapRoomMessages(String roomID) => _firebaseFirestore
      .collection(FirestoreConstants.pathRoomCollection)
      .doc(roomID)
      .collection(FirestoreConstants.pathRoomConversationsCollection)
      .snapshots();

  Future<QuerySnapshot> getRoomMessages(String roomID) => _firebaseFirestore
      .collection(FirestoreConstants.pathRoomCollection)
      .doc(roomID)
      .collection(FirestoreConstants.pathRoomConversationsCollection)
      .orderBy(FirestoreConstants.timestamp)
      .get();

  Future<QuerySnapshot> allUsers() async => await _firebaseFirestore
      .collection(FirestoreConstants.pathUserCollection)
      .get();

  Future<DocumentSnapshot> currentUser(String currentUserId) async => await _firebaseFirestore
      .collection(FirestoreConstants.pathUserCollection)
      .doc(currentUserId)
      .get();

  Future<String> uploadFile(String path, File imageFile) async {
    String fileName = basename(imageFile.path);
    final firebaseStorageRef = _storage.ref().child('$path/$fileName');
    await firebaseStorageRef.putFile(imageFile);
    return firebaseStorageRef.getDownloadURL();
  }
}
