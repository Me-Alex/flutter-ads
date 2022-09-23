import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      return null;
    }
  }

  static String? get interstitialAdUnitID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/8691691433';
    } else {
      return null;
    }
  }

  static String? get rewardedAdUnitID {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2248134325455841/9191335711';
    } else {
      return null;
    }
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => {debugPrint('Ad loaded')},
    onAdOpened: (ad) => debugPrint('Ad opened'),
    onAdClosed: (ad) => debugPrint('Ad closed'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Failed to load: $error');
    },
  );
}
