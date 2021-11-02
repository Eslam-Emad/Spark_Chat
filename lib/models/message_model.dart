import 'package:cloud_firestore/cloud_firestore.dart';

import '/constants/constants.dart';

enum MessageType { text, image, audio, video }

extension AddonsType on MessageType {
  String get value => toString().split(".").last;

  static MessageType fromString(String status) =>
   MessageType.values.firstWhere((element) => element.value == status);
}

class MessageModel {
  final String idTo;
  final String idFrom;
  final String content;
  final String timestamp;
  final MessageType type;

  MessageModel({
    required this.idTo,
    required this.type,
    required this.idFrom,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.type: type.value,
      FirestoreConstants.content: content,
      FirestoreConstants.timestamp: timestamp,
    };
  }

  factory MessageModel.fromDocument(DocumentSnapshot doc) {
    return MessageModel(
      idTo: doc.get(FirestoreConstants.idTo),
      idFrom: doc.get(FirestoreConstants.idFrom),
      content: doc.get(FirestoreConstants.content),
      timestamp: doc.get(FirestoreConstants.timestamp),
      type: AddonsType.fromString(doc.get(FirestoreConstants.type)),
    );
  }
}
