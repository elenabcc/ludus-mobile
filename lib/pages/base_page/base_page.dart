import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget body;
  final String title;

  BasePage({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          // Altri pulsanti qui
        ],
      ),
      body: body,
    );
  }
}
