import 'package:ads/my_drawer_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BodyRewards extends StatelessWidget {
  const BodyRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rewards"),
      ),
      drawer: const MainDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: RewardsCards(),
      ),
    );
  }
}

class RewardsCards extends StatefulWidget {
  const RewardsCards({Key? key}) : super(key: key);
  @override
  State<RewardsCards> createState() => _RewardsCards();
}

class _RewardsCards extends State<RewardsCards> {
  @override
  void initState() {
    super.initState();
  }

  void purchaseGiftCard(points) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final nestedData = documentSnapshot.get(FieldPath(['money']));

        final data =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        if (nestedData - 500 >= 0) {
          data
              .update({'money': nestedData - points})
              .then((value) => debugPrint("-500"))
              .catchError(
                  (error) => debugPrint("Failed to update user: $error"));
          debugPrint('Points are higher than $points');
        } else {
          debugPrint('Not enough money ');
        }
      }
    });
  }

  void _showDialog(points) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are u sure on want you want to buy"),
          content: const Text(
              "Soon after the request is manualy verified,You will receive via email your gift card"),
          actions: [
            MaterialButton(
              onPressed: () {
                debugPrint("Yes");
                purchaseGiftCard(points);
                Navigator.pop(context);
              },
              child: const Text(
                'Accept',
              ),
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  debugPrint("Cancel");
                },
                child: const Text("cancel"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                  'https://apostas.gazetaesportiva.com/static/wp/2021/12/imagem-destaque-paysafecard.webp'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "5\$",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () => {
                  _showDialog(500),
                  debugPrint("buy"),
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                ),
                child:
                    const Text('-500 Points', style: TextStyle(fontSize: 30)),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
            height: 220,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    'https://coingate-production.s3.amazonaws.com/uploads/gift_card_logo/529/9a78808b-728c-4dbd-8ee6-27bfb8558db9.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "5\$",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () => {
                    _showDialog(500),
                    debugPrint("buy"),
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  child:
                      const Text('-500 Points', style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(height: 5),
              ],
            )),
        const SizedBox(height: 10),
        Container(
            height: 220,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    'https://www.licente-jocuri.ro/image/cache/data/in_game/GOOGLE_PLAY/image_2-1920x1080.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "5\$",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () => {
                    _showDialog(500),
                    debugPrint("buy"),
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  child:
                      const Text('-500 Points', style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(height: 5),
              ],
            )),
        const SizedBox(height: 10),
        Container(
            height: 200,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    'https://apostas.gazetaesportiva.com/static/wp/2021/12/imagem-destaque-paysafecard.webp'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "10\$",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () => {
                    _showDialog(900),
                    debugPrint("buy"),
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  child:
                      const Text('-900 Points', style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(height: 5),
              ],
            )),
      ],
    );
  }
}
