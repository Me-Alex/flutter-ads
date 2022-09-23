// ignore_for_file: prefer_const_constructors

import 'package:ads/my_drawer_header.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Privacy Policy "),
        ),
        body: Center(
          child: Text("Privacy Policy Page \n       -Coming soon",
              style: TextStyle(fontSize: 30)),
        ),
        drawer: MainDrawer(),
      );
}
