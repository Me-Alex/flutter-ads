import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  const AddUser({super.key, required this.fullName, required this.company, required this.age });

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
   

    return const Text(" sgfsgf");
  }
}
