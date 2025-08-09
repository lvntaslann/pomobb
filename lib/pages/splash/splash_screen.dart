import 'package:flutter/material.dart';
import 'package:pomobb/pages/home/home.dart';

import '../../themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.2;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBgColor,
      body: Stack(
        children: [
          Positioned(
            top: 250,
            left: 55,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: _opacity,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 800),
                scale: _scale,
                curve: Curves.easeInOut,
                child: Image.asset(
                  "assets/logo/pomobb-logo.png",
                  height: 300,
                  width: 300,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 70,
            left: 80,
            child: Text(
              "Copyright © 2025 tüm hakları saklıdır",
              style: TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}