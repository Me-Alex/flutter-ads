import 'package:ads/my_drawer_header.dart';
import 'package:flutter/material.dart';

class SendFeedbackPage extends StatelessWidget {
  SendFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Send Feedback"),
        ),
        body: Center(
          child: Text("Send Feedback Page \n       -Coming soon",
              style: TextStyle(fontSize: 30)),
        ),
        drawer: MainDrawer(),
      );
}
