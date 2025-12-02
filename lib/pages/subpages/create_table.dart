import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../base_page/base_page.dart';

class Game {
  String? title;
  Game({this.title});
}

class CreateTablePage extends StatefulWidget {
  const CreateTablePage({super.key});
  @override
  _CreateTablePageState createState() => _CreateTablePageState();
}

class _CreateTablePageState extends State<CreateTablePage> {
  Game? selectedGame;
  String? selectedDate;
  String? selectedTime;
  List<Game> games = [];

  @override
  void initState() {
    super.initState();
    loadGames();
  }

  Future<void> loadGames() async {
    final snapshot = await FirebaseFirestore.instance.collection('games').get();
    setState(() {
      games = snapshot.docs.map((doc) => Game(title: doc['title'])).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Crea Tavolo',
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // Dropdown per scegliere il gioco
                DropdownSearch<String>(
                  items: (f, cs) =>
                      games.map((game) => game.title as String).toList(),
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(),
                    disabledItemFn: (String? item) => false,
                  ),
                  decoratorProps: DropDownDecoratorProps(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Gioco',
                      hintText: 'Scegli il gioco...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onChanged: (value) => selectedGame = games.firstWhere(
                    (game) => game.title == value,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 8.0)),

                // Dropdown per scegliere la data
                DropdownSearch<String>(
                  items: (f, cs) => [
                    '10/12/2025',
                    '17/12/2025',
                    '07/01/2026',
                    '14/01/2026',
                  ],
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(),
                    disabledItemFn: (String? item) => false,
                  ),
                  decoratorProps: DropDownDecoratorProps(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Data',
                      hintText: 'Scegli la data...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onChanged: (value) => selectedDate = value,
                ),
                Padding(padding: const EdgeInsets.only(top: 8.0)),
                // Dropdown per scegliere l'ora per la data selezionata
                DropdownSearch<String>(
                  items: (f, cs) => ['21:00', '21:30', '22:00', '22:30'],
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(),
                    disabledItemFn: (String? item) => false,
                  ),
                  decoratorProps: DropDownDecoratorProps(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Ora',
                      hintText: 'Scegli l\'ora...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onChanged: (value) => selectedTime = value,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
            child: SizedBox(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance.collection('tables').add({
                      'game': selectedGame?.title,
                      'maxPlayers': 6,
                      'date': selectedDate,
                      'players': [],
                      'time': selectedTime,
                      'imagePath':
                          'https://www.magobiribago.it/wp-content/uploads/2021/11/8033772890199-1.jpg',
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tavolo creato con successo!'),
                      ),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Errore durante la creazione: $e'),
                      ),
                    );
                  }
                },
                child: const Text('Crea tavolo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
