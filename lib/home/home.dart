import 'package:fableframe/services/database.dart';
import 'package:fableframe/shared/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      bottomNavigationBar: const BottomNavBar(activePage: 0),
    );

  }
}
