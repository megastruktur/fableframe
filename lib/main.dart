import 'package:fableframe/home/home.dart';
import 'package:fableframe/login/login.dart';
import 'package:fableframe/routes.dart';
import 'package:fableframe/services/database.dart';
import 'package:fableframe/shared/splash_screen.dart';
import 'package:fableframe/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => PocketbaseProvider(),
      child: const FFApp(),
    )
  );
}

class FFApp extends StatefulWidget {
  const FFApp({super.key});

  @override
  State<FFApp> createState() => _FFAppState();
}

class _FFAppState extends State<FFApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PocketbaseProvider())
      ],

      child: Consumer<PocketbaseProvider>(
        builder: (context, pbp, _) => MaterialApp(
          title: 'Pocketbase FF',
          theme: appTheme,
          routes: appRoutes,
          home: pbp.isAuth
            // @todo Redirect to previous screen when logged.
            ? const HomeScreen()
            : FutureBuilder(
              // Tries to log in via token in Prefs.
              future: pbp.tryAutoLogin(),
              builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                ? const SplashScreen()
                : const LoginScreen(),
              ),
          
        ),
      ),
    );
  }
}
