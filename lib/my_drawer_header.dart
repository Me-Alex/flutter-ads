// ignore_for_file: prefer_const_constructors
import 'package:ads/rewards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';
import 'package:ads/privacy_policy.dart';
import 'package:ads/send_feedback.dart';
import 'package:ads/settings.dart';

import 'dashboard.dart';

final user = FirebaseAuth.instance.currentUser!;
bool state1 = true;
bool state2 = false;
bool state3 = false;
bool state4 = false;
bool state5 = false;
var money = 0;

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  void initState() {
    super.initState();
    updateMoney();
  }

  void updateMoney() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final nestedData = documentSnapshot.get(FieldPath(['money']));

        setState(() {
          money = nestedData;
        });
        debugPrint('update money now');
      }
    });
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.only(bottom: 50),
              child: Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        '${user.displayName}',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${money} Points",
                        style: TextStyle(fontSize: 18, color: Colors.red)),
                  ],
                ),
              ),
            ),
            MyButton(
              title: 'Dashboard',
              icon: Icons.dashboard_outlined,
              path: 1,
              state: state1,
            ),
            MyButton(
              title: 'Rewards',
              icon: Icons.shop,
              path: 5,
              state: state5,
            ),
            MyButton(
                title: 'Settings',
                icon: Icons.settings_outlined,
                path: 2,
                state: state2),
            MyButton(
                title: 'Privacy policy',
                icon: Icons.privacy_tip_outlined,
                path: 3,
                state: state3),
            MyButton(
                title: 'Send feedback',
                icon: Icons.feedback_outlined,
                path: 4,
                state: state4),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            ),
          ],
        ),
      );
}

class MyButton extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final bool state;
  final path;
  final IconData icon;
  final String title;
  MyButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.path,
      required this.state});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  late bool selected;

  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon),
      title: Text(widget.title, style: TextStyle(fontSize: 18)),
      onTap: () {
        Navigator.pop(context);
        if (widget.path == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardPage()));
          state1 = true;
          state2 = false;
          state3 = false;
          state4 = false;
          state5 = false;
        } else if (widget.path == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SettingsPage()));
          state1 = false;
          state2 = true;
          state3 = false;
          state4 = false;
          state5 = false;
        } else if (widget.path == 3) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
          state1 = false;
          state2 = false;
          state3 = true;
          state4 = false;
          state5 = false;
        } else if (widget.path == 4) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SendFeedbackPage()));
          state1 = false;
          state2 = false;
          state3 = false;
          state4 = true;
          state5 = false;
        } else if (widget.path == 5) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BodyRewards()));
          state1 = false;
          state2 = false;
          state3 = false;
          state4 = false;
          state5 = true;
        }
      },
      selected: widget.state,
    );
  }
}







































// class MyHeaderDrawer extends StatefulWidget {
//   @override
//   _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
// }

// class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.green[700],
//       width: double.infinity,
//       height: 200,
//       padding: const EdgeInsets.only(top: 20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 10),
//             height: 70,
//           ),
//           const Text(
//             "Rapid Tech",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           Text(
//             "info@rapidtech.dev",
//             style: TextStyle(
//               color: Colors.grey[200],
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MainDrawer extends StatefulWidget {
//   const MainDrawer({super.key});

//   @override
//   MainDrawerState createState() => MainDrawerState();
// }

// class MainDrawerState extends State<MainDrawer> {
//   var currentPage = DrawerSections.dashboard;

//   @override
//   Widget build(BuildContext context) {
//     var container;
//     if (currentPage == DrawerSections.dashboard) {
//       container = DashboardPage();
//     } else if (currentPage == DrawerSections.contacts) {
//       container = ContactsPage();
//     } else if (currentPage == DrawerSections.events) {
//       container = EventsPage();
//     } else if (currentPage == DrawerSections.notes) {
//       container = NotesPage();
//     } else if (currentPage == DrawerSections.settings) {
//       container = SettingsPage();
//     } else if (currentPage == DrawerSections.notifications) {
//       container = NotificationsPage();
//     } else if (currentPage == DrawerSections.privacy_policy) {
//       container = PrivacyPolicyPage();
//     } else if (currentPage == DrawerSections.send_feedback) {
//       container = SendFeedbackPage();
//     }
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.green[700],
//         // title: const Text("Free money"),
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             MyHeaderDrawer(),
//             MyDrawerList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget MyDrawerList() {
//     return Container(
//       padding: const EdgeInsets.only(
//         top: 15,
//       ),
//       child: Column(
//         // shows the list of menu drawer
//         children: [
//           menuItem(1, "Dashboard", Icons.dashboard_outlined,
//               currentPage == DrawerSections.dashboard ? true : false),
//           menuItem(2, "Contacts", Icons.people_alt_outlined,
//               currentPage == DrawerSections.contacts ? true : false),
//           menuItem(3, "Events", Icons.event,
//               currentPage == DrawerSections.events ? true : false),
//           menuItem(4, "Notes", Icons.notes,
//               currentPage == DrawerSections.notes ? true : false),
//           const Divider(),
//           menuItem(5, "Settings", Icons.settings_outlined,
//               currentPage == DrawerSections.settings ? true : false),
//           menuItem(6, "Notifications", Icons.notifications_outlined,
//               currentPage == DrawerSections.notifications ? true : false),
//           const Divider(),
//           menuItem(7, "Privacy policy", Icons.privacy_tip_outlined,
//               currentPage == DrawerSections.privacy_policy ? true : false),
//           menuItem(8, "Send feedback", Icons.feedback_outlined,
//               currentPage == DrawerSections.send_feedback ? true : false),
//           ElevatedButton(
//             child: const Text("Logout"),
//             onPressed: () {
//               final provider =
//                   Provider.of<GoogleSignInProvider>(context, listen: false);
//               provider.logout();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget menuItem(int id, String title, IconData icon, bool selected) {
//     return Material(
//       color: selected ? Colors.grey[300] : Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//           setState(() {
//             if (id == 1) {
//               currentPage = DrawerSections.dashboard;
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DashboardPage()));
//             } else if (id == 2) {
//               currentPage = DrawerSections.contacts;
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DashboardPage()));
//             } else if (id == 3) {
//               currentPage = DrawerSections.events;
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DashboardPage()));
//             } else if (id == 4) {
//               currentPage = DrawerSections.notes;
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DashboardPage()));
//             } else if (id == 5) {
//               currentPage = DrawerSections.settings;
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DashboardPage()));
//             } else if (id == 6) {
//               currentPage = DrawerSections.notifications;
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DashboardPage()));
//             } else if (id == 7) {
//               currentPage = DrawerSections.privacy_policy;
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DashboardPage()));
//             } else if (id == 8) {
//               currentPage = DrawerSections.send_feedback;
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const DashboardPage()));
//             }
//           });
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Icon(
//                   icon,
//                   size: 20,
//                   color: Colors.black,
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum DrawerSections {
//   dashboard,
//   contacts,
//   events,
//   notes,
//   settings,
//   notifications,
//   privacy_policy,
//   send_feedback,
// }
