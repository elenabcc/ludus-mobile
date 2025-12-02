import 'package:flutter/material.dart';
import 'base_page/base_page.dart';

class Ranking extends StatelessWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Ranking',
      body: Center(child: Text('Contenuto Ranking')),
    );
  }
}
