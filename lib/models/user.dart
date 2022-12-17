// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart' show immutable;

// import '../services/cloud/cloud_constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

part 'user.g.dart';

/// {@template user}
/// User description
/// {@endtemplate}
class BillUser {
  /// {@macro user}
  const BillUser({
    required this.userName,
    required this.userAvatarLink,
    required this.name,
    required this.email,
  });

  /// Creates a User from Json map
  factory BillUser.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  /// A description for userName
  final String userName;

  /// A description for userAvatarLink
  final String userAvatarLink;

  /// A description for name
  final String name;

  final String email;

  BillUser.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      // : userID = snapshot.data()![userIDName],
      : name = snapshot.data()!['userName'],
        // firstName = snapshot.data()[userFirstName],
        // lastName = snapshot.data()[userLastName],
        userName = snapshot.data()!['name'],
        userAvatarLink = snapshot.data()!['userAvatarLink'],
        email = snapshot.data()!['email'];

  /// Creates a Json map from a User
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static const dummy = BillUser(
      userName: '@shirsho',
      userAvatarLink: 'assets/images/face.jpg',
      name: 'Shirshajit',
      email: 'shirshajit@gmail.com');
}
