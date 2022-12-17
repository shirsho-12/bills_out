import 'package:bills_out/models/user.dart';
import 'package:bills_out/services/cloud/cloud_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:developer' as devtools show log;

class FirebaseCloudStorage {
  static final FirebaseCloudStorage _instance =
      FirebaseCloudStorage._internal();
  FirebaseCloudStorage._internal();
  factory FirebaseCloudStorage() => _instance;

  final users = FirebaseFirestore.instance.collection('users');

  Future<BillUser> getAppUserFromEmail(String email) async {
    try {
      return await users.doc(email).get().then((doc) {
        if (doc.exists) {
          return BillUser.fromDocumentSnapshot(doc);
        } else {
          throw CouldNotGetAppUserException();
        }
      });
    } catch (e) {
      throw CouldNotGetAppUserException();
    }
  }

  Future<void> updateBillUser({
    String? name,
    String? userName,
    required String email,
    String? userAvatarLink,
  }) async {
    try {
      final doc = await users.doc(email).get();
      if (!doc.exists) {
        throw Exception();
      }

      if (name != null) {
        await users.doc(email).update({'name': name});
      }
      if (userName != null) {
        await users.doc(email).update({'userName': userName});
      }
      if (userAvatarLink != null) {
        await users.doc(email).update({'userAvatarLink': userAvatarLink});
      }
    } catch (e) {
      throw CouldNotUpdateAppUserException();
    }
  }

  Future<BillUser> createNewBillUser({
    required String name,
    required String username,
    required String email,
    String? userAvatarLink,
  }) async {
    await users.doc(email).set(
      {
        'name': name,
        'userName': username,
        'email': email,
        'userAvatarLink': userAvatarLink ??
            "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg",
      },
    );
    // devtools.log(fetchedUser.id);
    return BillUser(
        email: email,
        userName: username,
        name: name,
        userAvatarLink: userAvatarLink ?? "");
  }
}
