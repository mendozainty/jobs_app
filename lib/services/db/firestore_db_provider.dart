import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobs_app/services/db/db_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_app/services/db/user_schema.dart';

class FirestoreDbProvider implements DbProvider {
  final db = FirebaseFirestore.instance;

  @override
  Future<DocumentReference<Object?>?> getDoc() {
    // TODO: implement getDoc
    throw UnimplementedError();
  }

  @override
  // TODO: implement collection
  String get collection => throw UnimplementedError();

  @override
  Future<DocumentReference<Object?>?> addUser(collection, userData) async {
    var user = userData;
    user = FirebaseAuth.instance.currentUser;
    final dbuser = DbUser(
        uid: FirebaseAuth.instance.currentUser?.uid,
        name: FirebaseAuth.instance.currentUser?.displayName,
        email: user?.email,
        phone: user?.phoneNumber,
        photoUrl: user?.photoURL,
        isManager: false);

    final docRef = db
        .collection('users')
        .withConverter(
          fromFirestore: DbUser.fromFirestore,
          toFirestore: (DbUser dbuser, options) => dbuser.toFirestore(),
        )
        .doc(dbuser.name);
    await docRef.set(dbuser);
    print(docRef.id);
    return docRef;
  }

  @override
  // TODO: implement userData
  DbUser get userData => throw UnimplementedError();
}
