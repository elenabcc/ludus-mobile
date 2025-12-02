import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/auth_gate.dart';
import 'pages/tables.dart';
import 'pages/games.dart';
import 'pages/profile.dart';
import 'pages/ranking.dart';
import 'pages/home_screen.dart';
import 'pages/subpages/create_table.dart';
import 'pages/base_page/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LudusGate',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      initialRoute: '/authentication',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/authentication': (context) => AuthGate(),
        '/tables': (context) => Tables(),
        '/games': (context) => Games(),
        '/profile': (context) => Profile(),
        '/ranking': (context) => Ranking(),
        '/createTable': (context) => CreateTablePage(),
        '/notifications': (context) => NotificationsPage(),
      },
    );
  }
}
