import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fableframe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text('Login'),
            LoginButton(),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {


  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  Future<void> _login() async {
    await Provider.of<PocketbaseProvider>(context, listen: false).login();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ElevatedButton.icon(
        onPressed: () => _login(),
        label: const Text('Login'),
        icon: const Icon(
          FontAwesomeIcons.addressCard,
          color: Colors.white,
          size: 20,
        ),
      )
    );
  }
}
