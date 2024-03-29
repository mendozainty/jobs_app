import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:jobs_app/services/db/db_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobs_app/services/db/db_service.dart';

class FirestoreDbProvider implements DbProvider {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> addUser(collection) {
    final users = db.collection(collection);
    final uid = AuthService.firebase().currentUser?.uid;
    final name = AuthService.firebase().currentUser?.name;
    final email = AuthService.firebase().currentUser?.email;
    final phone = AuthService.firebase().currentUser?.phone;
    final photoUrl = AuthService.firebase().currentUser?.photoUrl;
    var isManager = false;
    final dbuser = <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'isManager': isManager,
      'timestamp': FieldValue.serverTimestamp(),
      'artisticNickName': null,
      'rg': null,
      'cpf': null,
      'birthDate': null,
      'address': null,
    };

    final docRef = users.doc(email).set(dbuser);
    return docRef;
  }

  @override
  Future<DocumentReference<Object?>?> getUser(collection) async {
    final users = db.collection(collection);
    final email = AuthService.firebase().currentUser?.email;
    final docRef = users.doc(email);
    await docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data != null) {
        return data;
      }
      return null;
    });
    return null;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> get userStream {
    final userStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    return userStream;
  }

  @override
  CollectionReference<Map<String, dynamic>> collection(collectionPath) {
    return FirebaseFirestore.instance.collection(collectionPath);
  }

  @override
  // TODO: implement collectionPath
  String get collectionPath => throw UnimplementedError();

  @override
  Future<void> updateUser(json) {
    try {
      db
          .collection('users')
          .doc(AuthService.firebase().currentUser?.email)
          .update(json);
    } catch (e) {
      print(e);
    }

    return DbService.firestore().getUser('users');
  }
}
