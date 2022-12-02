import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobs_app/services/auth/auth_services.dart';
import 'package:jobs_app/services/db/db_service.dart';
import 'package:jobs_app/views/user_info_view.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return const UserInfoCustomScrollingView();
  }
}
