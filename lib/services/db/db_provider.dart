import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_app/services/db/user_schema.dart';

abstract class DbProvider {
  final String collection;
  final Stream<QuerySnapshot<Map<String, dynamic>>> userStream;

  DbProvider(
    this.collection,
    this.userStream,
  );

  Future<DocumentReference?> getUser(collection);
  Future<void> addUser(
    collection,
  );
}
