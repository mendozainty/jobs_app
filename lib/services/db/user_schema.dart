/* import 'package:cloud_firestore/cloud_firestore.dart';

class DbUser {
  final String? uid;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? phone;
  final String? cpf;
  final String? address;
  final String? rg;
  final String? pix;
  final String? timestampLastUpdate;
  final String? jobPosition;
  final bool? isManager;
  final List<String>? jobs;

  DbUser({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.phone,
    this.cpf,
    this.address,
    this.rg,
    this.pix,
    this.timestampLastUpdate,
    this.jobPosition,
    this.isManager,
    this.jobs,
  });

  factory DbUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return DbUser(
      uid: data?['uid'],
      name: data?['name'],
      email: data?['email'],
      photoUrl: data?['photoUrl'],
      phone: data?['phone'],
      cpf: data?['cpf'],
      address: data?['address'],
      rg: data?['rg'],
      pix: data?['pix'],
      timestampLastUpdate: data?['timestampLastUpdate'],
      jobPosition: data?['jobPosition'],
      isManager: data?['isManager'],
      jobs: data?['jobs'] is Iterable ? List.from(data?['email']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (photoUrl != null) "": photoUrl,
      if (phone != null) "phone": phone,
      if (cpf != null) "cpf": cpf,
      if (address != null) "address": address,
      if (rg != null) "rg": rg,
      if (pix != null) "pix": pix,
      if (timestampLastUpdate != null)
        "timestampLastUpdate": timestampLastUpdate,
      if (jobPosition != null) "jobPosition": jobPosition,
      if (isManager != null) "isManager": isManager,
      if (jobs != null) "jobs": jobs,
    };
  }
}
 */