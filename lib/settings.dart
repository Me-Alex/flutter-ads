// ignore_for_file: prefer_const_constructors

import 'package:ads/my_drawer_header.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Settings "),
        ),
        body: Center(
          child: Text("Settings Page \n       -Coming soon",
              style: TextStyle(fontSize: 30)),
        ),
        drawer: MainDrawer(),
      );
}
