import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_app/services/db/user_schema.dart';

abstract class DbProvider {
  final String collection;
  final DbUser userData;
  DbProvider(this.collection, this.userData);

  Future<DocumentReference?> getDoc();
  Future<DocumentReference?> addUser(
    collection,
    userData,
  );
}
