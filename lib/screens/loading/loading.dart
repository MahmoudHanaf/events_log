import 'package:flutter/material.dart';
import 'package:charging_station/configs/config.dart';
import 'package:flutter/services.dart';

import '../onboarding/onboarding.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Onboarding()),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#2269be"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("#2269be"),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor("#2269be"),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  Images.logo,
                  width: 110,
                  height: 120,
                  color: Colors.white,
                ),

                Text(
                  "Speed charge",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
