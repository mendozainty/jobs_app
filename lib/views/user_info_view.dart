import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/services/db/db_service.dart';
import 'package:jobs_app/services/maps/google_maps.dart';
import '../constants/appBar_view.dart';
import '../services/auth/auth_services.dart';

class UserInfoCustomScrollingView extends StatefulWidget {
  const UserInfoCustomScrollingView({super.key});

  @override
  State<UserInfoCustomScrollingView> createState() =>
      _UserInfoCustomScrollingViewState();
}

class _UserInfoCustomScrollingViewState
    extends State<UserInfoCustomScrollingView> {
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
        appBar: AppBarCustom('Seus dados'),
        body: StreamBuilder(
          stream: _userStream,
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (snapshot.hasError) {
              <Widget>[const Text('Algo deu errado')];
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              <Widget>[const CircularProgressIndicator.adaptive()];
            }
            // (data!['photoUrl']) != null
            return snapshot.hasData
                ? CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          height: 40,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          child: (data!['photoUrl']) != null
                              ? Center(
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        data['photoUrl'],
                                        fit: BoxFit.fill,
                                      ),
                                      Positioned(
                                          right: 18,
                                          top: 18,
                                          child: IconButton(
                                            icon: const Icon(Icons.edit),
                                            tooltip: 'Editar',
                                            onPressed: () {},
                                          ))
                                    ],
                                  ),
                                )
                              : const Text('Adicione sua foto'),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 30,
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 60,
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          title: (data['name'] != null
                              ? Text(data['name'])
                              : const Text('Complete o seu nome')),
                          subtitle: const Text('Nome'),
                          trailing: const Icon(Icons.edit),
                        ),
                      )),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 60,
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          title: (data['email'] != null
                              ? Text(data['email'])
                              : const Text('Complete o seu Email')),
                          subtitle: const Text('Email'),
                        ),
                      )),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 60,
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          title: (data['phone'] != null
                              ? Text(data['phone'])
                              : TextField(
                                  controller: _phone,
                                  autocorrect: false,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                      hintText: 'Complete o seu Telefone'))),
                          subtitle: const Text('Telefone'),
                        ),
                      )),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 60,
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          title: (data['address'] != null
                              ? Text(data['address'])
                              : TextField(
                                  controller: _address,
                                  autocorrect: false,
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: const InputDecoration(
                                      hintText: 'Insira seu endereço'))),
                          subtitle: const Text('Endereço'),
                        ),
                      )),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 60,
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          title: (data['rg'] != null
                              ? Text(data['rg'])
                              : TextField(
                                  controller: _rg,
                                  autocorrect: false,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: 'Insira seu RG'))),
                          subtitle: const Text('Rg'),
                        ),
                      )),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 60,
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          title: (data['cpf'] != null
                              ? Text(data['cpf'])
                              : TextField(
                                  controller: _cpf,
                                  autocorrect: false,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: 'Insira seu CPF'))),
                          subtitle: const Text('CPF'),
                        ),
                      )),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 60,
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: -4),
                          title: (data['birthDate'] != null
                              ? Text(data['birthDate'])
                              : TextField(
                                  controller: _birth,
                                  autocorrect: false,
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                      hintText:
                                          'Insira sua data de nascimento'))),
                          subtitle: const Text('Data de Nascimento'),
                        ),
                      )),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 50,
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(20, 50),
                              maximumSize: const Size(20, 50),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.indigo.shade500,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )),
                          child: const Text('Salvar'),
                          onPressed: () async {
                            final address = _address.text;
                            try {
                              await getLatLong(address)
                                  .then((location) => getMap(location));
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      )),
                    ],
                  )
                : const Text('data');
          },
        ));
  }
}
