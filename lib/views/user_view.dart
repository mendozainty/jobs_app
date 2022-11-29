import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/constants/appBar_view.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:jobs_app/services/db/db_service.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late final TextEditingController _email;
  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _address;
  late final TextEditingController _cpf;
  late final TextEditingController _pix;
  late final TextEditingController _birth;
  late final TextEditingController _rg;

  @override
  void initState() {
    _email = TextEditingController();
    _name = TextEditingController();
    _phone = TextEditingController();
    _address = TextEditingController();
    _cpf = TextEditingController();
    _pix = TextEditingController();
    _birth = TextEditingController();
    _rg = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _cpf.dispose();
    _pix.dispose();
    _birth.dispose();
    _rg.dispose();
    super.dispose();
  }

  final Stream<DocumentSnapshot> _userStream = DbService.firestore()
      .collection('users')
      .doc(AuthService.firebase().currentUser!.email)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Usuário'),
      body: StreamBuilder(
        stream: _userStream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (snapshot.hasError) {
            <Widget>[const Text('Algo deu errado')];
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            <Widget>[const Text('carregando')];
          }
          return Table(
              border: TableBorder.symmetric(),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(85),
                1: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
              children: <TableRow>[
                TableRow(children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TableCell(
                      child: SizedBox(
                        height: 60,
                        child: Center(child: Text('Foto')),
                      ),
                    ),
                  ),
                  TableCell(
                      child: SizedBox(
                    height: 60,
                    child: (data!['photoUrl'] != null
                        ? Image.network(data['photoUrl'])
                        : const Text('Complete o seu nome')),
                  ))
                ]),
                TableRow(children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TableCell(
                      child: SizedBox(
                        height: 60,
                        child: Center(child: Text('Nome')),
                      ),
                    ),
                  ),
                  TableCell(
                      child: SizedBox(
                    height: 60,
                    child: (data['name'] != null
                        ? Center(child: Text(data['name']))
                        : const Text('Complete o seu nome')),
                  ))
                ]),
                TableRow(children: <Widget>[
                  const TableCell(
                    child: SizedBox(
                      height: 60,
                      child: Center(child: Text('Email')),
                    ),
                  ),
                  TableCell(
                      child: SizedBox(
                    height: 60,
                    child: (data['email'] != null
                        ? Center(child: Text(data['email']))
                        : const Center(child: Text('Complete o seu nome'))),
                  ))
                ]),
                TableRow(children: <Widget>[
                  const TableCell(
                    child: SizedBox(
                      height: 60,
                      child: Center(child: Text('Telefone')),
                    ),
                  ),
                  TableCell(
                      child: SizedBox(
                    height: 60,
                    child: (data['phone'] != null
                        ? Center(child: Text(data['phone']))
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              controller: _phone,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                  hintText: 'Entre seu Telefone'),
                            ),
                          )),
                  ))
                ]),
              ]);
        },
      ),
    );
  }
}
