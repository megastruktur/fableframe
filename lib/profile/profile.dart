import 'package:fableframe/services/database.dart';
import 'package:fableframe/shared/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var user = Provider.of<PocketbaseProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Hello User"),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(activePage: 1),
    );
  }
}
