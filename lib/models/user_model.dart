import 'package:cloud_firestore/cloud_firestore.dart';

import '/constants/constants.dart';

enum Authorization { admin, moderator, user }

extension AddonsAuthorization on Authorization {
  String get value => toString().split(".").last;

  static Authorization fromString(String status) =>
  Authorization.values.firstWhere((element) => element.value == status);
}

class UserModel {
  final String? id;
  final String email;
  final String aboutMe;
  final String photoUrl;
  final String username;
  final Authorization authorization;

  UserModel({
    this.id,
    required this.email,
    required this.aboutMe,
    required this.photoUrl,
    required this.username,
    required this.authorization,
  });

  Map<String, String> toJson() {
    return {
      FirestoreConstants.email: email,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.username: username,
      FirestoreConstants.authorization: authorization.value,
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      email: doc.get(FirestoreConstants.email),
      aboutMe: doc.get(FirestoreConstants.aboutMe),
      photoUrl: doc.get(FirestoreConstants.photoUrl),
      username: doc.get(FirestoreConstants.username),
      authorization: AddonsAuthorization.fromString(doc.get(FirestoreConstants.authorization)),
    );
  }
}
