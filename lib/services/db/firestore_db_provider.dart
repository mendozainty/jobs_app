import 'package:jobs_app/services/db/db_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_app/services/db/user_schema.dart';

class FirestoreDbProvider implements DbProvider {
  @override
  initializeDb() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore;
  }

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
    collection = 'users';
    final docRef = FirebaseFirestore.instance
        .collection(collection)
        .withConverter(
          fromFirestore: DbUser.fromFirestore,
          toFirestore: (DbUser dbuser, options) => dbuser.toFirestore(),
        )
        .doc();
    await docRef.set(userData.name);
    return docRef;
  }

  @override
  // TODO: implement userData
  DbUser get userData => throw UnimplementedError();
}
