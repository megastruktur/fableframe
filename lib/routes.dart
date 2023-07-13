import 'package:fableframe/characters/characters.dart';
import 'package:fableframe/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:fableframe/home/home.dart';
import 'package:fableframe/login/login.dart';

var appRoutes = <String, WidgetBuilder>{
  '/login': (BuildContext context) => LoginScreen(),
  '/profile': (BuildContext context) => ProfileScreen(),
  '/characters': (BuildContext context) => CharactersScreen(),
};
