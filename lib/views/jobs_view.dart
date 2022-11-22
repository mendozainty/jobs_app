import 'package:flutter/material.dart';
import 'package:jobs_app/constants/appBar_view.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Jobs'),
    );
  }
}
