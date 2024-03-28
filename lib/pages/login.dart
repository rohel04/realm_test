import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_mongo/home.dart';
import 'package:realm_mongo/pages/register.dart';
import 'package:realm_mongo/services/realm_config.dart';
import 'package:realm_mongo/utils/ui_hepler.dart';
import 'package:realm_mongo/utils/validator.dart';
import 'package:realm_mongo/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormWidget(
              controller: _emailController,
              label: const Text('Email'),
              validation: Validator.inputEmptyTextChecker,
            ),
            const SizedBox(height: 20),
            TextFormWidget(
              isObscure: true,
              validation: Validator.inputEmptyTextChecker,
              controller: _passwordController,
              label: const Text('Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20)),
                onPressed: () async {
                  try {
                    await _authentication();
                    _navigateToHome();
                  } on RealmError catch (e) {
                    UiHelper.showSnachBar(context, e.message);
                  }
                },
                child: _isLoading
                    ? const CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      )
                    : Text('Login'.toUpperCase())),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20)),
                onPressed: () {
                  _navigateToRegisterPage();
                },
                child: Text('Register'.toUpperCase()))
          ],
        ),
      )),
    );
  }

  _navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  _navigateToRegisterPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  Future<User> _authentication() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var result = await RealmConfig.instance.authenticateEmailPassword(
          _emailController.text, _passwordController.text);
      return result;
    } on AppException catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw RealmError(e.message);
    }
  }
}
