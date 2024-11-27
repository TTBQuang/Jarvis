import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jarvis/model/user_token.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_model.dart';
import '../auth/auth_screen.dart';
import '../profile/profile_screen.dart';

class AuthRedirect extends StatefulWidget {
  const AuthRedirect({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthRedirectState();
  }
}

class _AuthRedirectState extends State<AuthRedirect> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      // adUnitId: 'ca-app-pub-6340941336992938/5450417660', // prod
      adUnitId: 'ca-app-pub-3940256099942544/9214589741', // test
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Failed to load a banner ad: $error');
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    final userToken = context.select<AuthViewModel, UserToken?>(
        (authViewModel) => authViewModel.user.userToken);

    if (userToken != null) {
      return Stack(
        children: [
          const ProfileScreen(),
          if (_isBannerAdReady)
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBannerAd(),
            )
        ],
      );
    } else {
      return Stack(
        children: [
          const AuthScreen(),
          if (_isBannerAdReady)
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBannerAd(),
            )
        ],
      );
    }
  }

  Widget _buildBannerAd() {
    return Stack(
      children: [
        SizedBox(
          height: _bannerAd.size.height.toDouble(),
          width: _bannerAd.size.width.toDouble(),
          child: AdWidget(ad: _bannerAd),
        ),
        Positioned(
          top: -15,
          right: -15,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isBannerAdReady = false;
              });
              _bannerAd.dispose();
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }
}