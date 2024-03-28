import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:realm_mongo/services/realm_config.dart';
import 'package:realm_mongo/utils/ui_hepler.dart';
import 'package:realm_mongo/utils/validator.dart';
import 'package:realm_mongo/widgets/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _ResgiterScreenState();
}

class _ResgiterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
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
                  label: const Text('Password'),
                  isObscure: true,
                  validation: Validator.inputEmptyTextChecker,
                  controller: _passwordController),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _registerUser();
                      _navigateToLogin();
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        )
                      : Text('Create account'.toUpperCase()))
            ],
          ),
        ),
      )),
    );
  }

  _navigateToLogin() {
    Navigator.of(context).pop();
  }

  Future<void> _registerUser() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await RealmConfig.instance.registerWithEmailPassword(
          _emailController.text, _passwordController.text);
    } on AppException catch (e) {
      setState(() {
        _isLoading = false;
      });
      UiHelper.showSnachBar(context, e.message);
    }
  }
}
