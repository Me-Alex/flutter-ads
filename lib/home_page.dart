import 'package:ads/dashboard.dart';
import 'package:ads/widget/sign_up_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser!;

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              debugPrint(snapshot.data?.displayName);
              debugPrint("mancare");
              createUser(user.uid, 0, user.email);
              return const DashboardPage();
            } else if (snapshot.hasError) {
              return const Center(child: Text("SOmething went wrong!"));
            } else {
              return const SignUpWidget();
            }
          },
        ),
      );

  Future<void> createUser(String userid, int money, email) async {
    final users = FirebaseFirestore.instance.collection('users').doc(userid);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final nestedData=documentSnapshot.get(FieldPath(['money']));
        
        debugPrint('User already added');
      } else {
        debugPrint("am ajuns aici");
        final json = {
          'user': userid,
          'money': 0,
          'email': email,
        };

        debugPrint("mancare2");
        users
            .set(json)
            .then((value) => debugPrint("User Added"))
            .catchError((error) => debugPrint("Failed to add user: $error"));

        debugPrint('Document exists on the database');
      }
    });
  }
}
