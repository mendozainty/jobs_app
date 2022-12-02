import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DbProvider {
  final String collectionPath;
  CollectionReference<Map<String, dynamic>> collection(collectionPath);
  //final Stream<QuerySnapshot<Map<String, dynamic>>> userStream;

  DbProvider(
    this.collectionPath,
    //this.userStream,
  );

  Future<DocumentReference?> getUser(collection);
  Future<void> addUser(
    collection,
  );
  Future<void> updateUser(json);
}
