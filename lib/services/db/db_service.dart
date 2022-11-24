import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_app/services/db/db_provider.dart';
import 'package:jobs_app/services/db/user_schema.dart';

import 'firestore_db_provider.dart';

class DbService implements DbProvider {
  final DbProvider provider;
  const DbService(this.provider);
  factory DbService.firestore() {
    return DbService(
      FirestoreDbProvider(),
    );
  }

  @override
  initializeDb() => provider.initializeDb();

  @override
  Future<DocumentReference<Object?>?> getDoc() => provider.getDoc();

  @override
  Future<DocumentReference<Object?>?> addUser(collection, data) =>
      provider.addUser(
        collection,
        data,
      );

  @override
  // TODO: implement collection
  String get collection => provider.collection;

  @override
  // TODO: implement data
  DbUser get userData => provider.userData;
}
