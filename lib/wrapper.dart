import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_mongo/home.dart';
import 'package:realm_mongo/pages/login.dart';
import 'package:realm_mongo/services/realm_config.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    checkSession();
    super.initState();
  }

  checkSession() async {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      User? user = RealmConfig.instance.app.currentUser;
      if (user == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        await RealmConfig.instance.runConfig();
        _navigateToHome();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: CircularProgressIndicator())),
    );
  }

  _navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
