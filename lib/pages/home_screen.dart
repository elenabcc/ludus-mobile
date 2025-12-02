import 'package:flutter/material.dart';
import 'games.dart';
import 'tables.dart';
import 'ranking.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  final String title = 'LudusGate';

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

final List<Widget> pages = [
  Tables(),
  const Games(),
  const Ranking(),
  const Profile(),
];

class _MyHomePageState extends State<HomeScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.deepPurple,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.grid_view_sharp),
            icon: Icon(Icons.grid_view_outlined),
            label: 'Tavoli',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.casino),
            icon: Icon(Icons.casino_outlined),
            label: 'Giochi',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.star),
            icon: Icon(Icons.star_border),
            label: 'Ranking',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_ind),
            label: "Profilo",
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
