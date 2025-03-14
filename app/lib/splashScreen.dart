import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    checkUserLogined();
    super.initState();
  }

  checkUserLogined() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggin = sharedPreferences.getBool("isLoggin") ?? false;
    Future.delayed(Duration(seconds: 3), () {
      if (isLoggin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Loading...",
          style: TextStyle(
            fontFamily: 'Arial',
            decoration: TextDecoration.none,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
