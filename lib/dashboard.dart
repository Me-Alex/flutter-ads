import 'package:ads/my_drawer_header.dart';
import 'package:ads/service/ad_mod_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final user = FirebaseAuth.instance.currentUser!;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  BannerAd? _banner;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  int _rewardedScore = 0;

  @override
  void initState() {
    super.initState();
    _createRewardedAd();
    _createBannerAd();
    _createInterstitialAd();
    _updateRewardedScore();
  }

  void _updateRewardedScore() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final nestedData = documentSnapshot.get(FieldPath(['money']));
        _rewardedScore = nestedData;
        setState(() => _rewardedScore);
        debugPrint('User $nestedData');
      }
    });
  }

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerListener,
      request: AdRequest(),
    )..load();
  }

  void _createInterstitialAd() {
    debugPrint("done loading");
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitID!,
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => _interstitialAd = ad,
          onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null),
      request: AdRequest(),
    );
  }

  void _showInterstitialAD() {
    debugPrint('entered teh ad');
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: AdMobService.rewardedAdUnitID!,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewardedAd = ad,
        onAdFailedToLoad: (error) => _rewardedAd = null,
      ),
      request: AdRequest(),
    );
  }

  void _showRewardedAd() {
    debugPrint('entered teh ad');
    if (_rewardedAd != null) {
      debugPrint('avem add ');
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createRewardedAd();
        },
      );
      _rewardedScore += 1;
      _rewardedAd!.show(
          onUserEarnedReward: (ad, reward) => setState(() => _rewardedScore));
      _rewardedAd = null;
      final data = FirebaseFirestore.instance.collection('users').doc(user.uid);
      data
          .update({'money': _rewardedScore})
          .then((value) => debugPrint("User Updated"))
          .catchError((error) => debugPrint("Failed to update user: $error"));
    } else {
      _createRewardedAd();
     
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: MainDrawer(),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            color: Colors.black,
            child: ListView(
              children: [
                Text("Points ${_rewardedScore}",
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    color: Color.fromARGB(255, 195, 197, 58),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(200, 50),
                          ),
                          icon: const FaIcon(FontAwesomeIcons.play,
                              color: Colors.red),
                          label: const Text("Watch add"),
                          onPressed: () {
                            _showRewardedAd();
                            debugPrint("pressed");
                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30),
                          width: 500,
                          height: 50,
                          child:
                              Text("+1 Point", style: TextStyle(fontSize: 30)),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    color: Color.fromARGB(255, 255, 0, 0),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(200, 50),
                          ),
                          icon: const FaIcon(FontAwesomeIcons.play,
                              color: Color.fromARGB(255, 55, 134, 61)),
                          label: const Text("Watch add"),
                          onPressed: () {
                            _showInterstitialAD();
                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30),
                          width: 500,
                          height: 50,
                          child: Text("", style: TextStyle(fontSize: 30)),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    color: Color.fromARGB(255, 129, 35, 125),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(200, 50),
                          ),
                          icon: const FaIcon(FontAwesomeIcons.play,
                              color: Color.fromARGB(255, 69, 55, 134)),
                          label: const Text("Watch add"),
                          onPressed: () {
                            _showInterstitialAD();
                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 30),
                          width: 500,
                          height: 50,
                          child: Text("", style: TextStyle(fontSize: 30)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _banner == null
            ? Container(
                height: 52,
                child: Text("nu mere"),
              )
            : Container(
                height: 52,
                child: AdWidget(ad: _banner!),
              ),
      );
}
