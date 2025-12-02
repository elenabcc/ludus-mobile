import 'package:flutter/material.dart';
import 'base_page/base_page.dart';

class Game {
  final int id;
  final String title;
  final List<int> numPlayers;
  final List<int> duration;
  final String description;
  final double evaluation;
  final String author;
  final String graphic;
  final int pubYear;
  final String gameType;
  final int age;
  final String category;
  final List<String> mechanics;
  final List<String> owner;

  const Game({
    required this.id,
    required this.title,
    required this.numPlayers,
    required this.duration,
    required this.description,
    required this.evaluation,
    required this.author,
    required this.graphic,
    required this.pubYear,
    required this.gameType,
    required this.age,
    required this.category,
    required this.mechanics,
    required this.owner,
  });
}

class Games extends StatelessWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Giochi',
      body: Center(child: Text('Contenuto Giochi')),
    );
  }
}
