import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_app/services/db/db_provider.dart';

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
  Future<void> addUser(collection) => provider.addUser(
        collection,
      );

  @override
  Future<DocumentReference<Object?>?> getUser(collection) => provider.getUser(
        collection,
      );

  @override
  CollectionReference<Map<String, dynamic>> collection(collectionPath) =>
      provider.collection(collectionPath);

  @override
  String get collectionPath => provider.collectionPath;
}
