import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../base_page/base_page.dart';
import '../classes/events.dart';

class ReusableDropdownSearch<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final Function(T?) onChanged;
  final String Function(T) itemToString; // Converte T in String per display
  final Color? backgroundColor;
  final String? hintText;
  final bool showSearchBox;

  const ReusableDropdownSearch({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemToString,
    this.backgroundColor,
    this.hintText,
    this.showSearchBox = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: (f, cs) => items.map(itemToString).toList(),
      popupProps: PopupProps.menu(
        showSearchBox: showSearchBox,
        searchFieldProps: TextFieldProps(),
        itemBuilder: (context, item, isDisabled, isSelected) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            title: Text(
              item,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
        containerBuilder: (ctx, popupWidget) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.grey[20],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: popupWidget,
              ),
            ),
          ],
        ),
      ),
      dropdownBuilder: (context, selectedItem) => ListTile(
        title: Text(
          selectedItem != null
              ? itemToString(
                  items.firstWhere((i) => itemToString(i) == selectedItem),
                )
              : '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor ?? Colors.grey[20],
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText ?? 'Seleziona...',
          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
      selectedItem: selectedItem != null
          ? itemToString(selectedItem as T)
          : null,
      onChanged: (value) {
        if (value != null) {
          onChanged(items.firstWhere((item) => itemToString(item) == value));
        }
      },
    );
  }
}

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
    initializeDateFormatting('it_IT', null);
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
    final args =
        (ModalRoute.of(context)!.settings.arguments ?? <String, dynamic>{})
            as Map;
    Event selectedDate = args['selectedDate'];
    List<Event> dates = args['dates'];
    return BasePage(
      title: 'Crea Tavolo',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Spazio sx/dx
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(top: 20)),
            Expanded(
              child: Column(
                spacing: 15,
                children: [
                  // Dropdown per scegliere il gioco
                  ReusableDropdownSearch<Game>(
                    items: games,
                    selectedItem: selectedGame,
                    onChanged: (game) => selectedGame = game,
                    itemToString: (game) => game.title ?? '',
                    hintText: 'Scegli il gioco...',
                    showSearchBox: true,
                  ),
                  // Dropdown per scegliere la data
                  ReusableDropdownSearch<Event>(
                    items: dates,
                    selectedItem: selectedDate,
                    onChanged: (date) => selectedDate = date as Event,
                    itemToString: (date) => toBeginningOfSentenceCase(
                      DateFormat(
                        'EEEE, dd MMMM',
                        'it_IT',
                      ).format(date.date.toDate()),
                    ),
                    hintText: 'Scegli la data...',
                  ),
                  // Dropdown per scegliere l'ora per la data selezionata
                  ReusableDropdownSearch<String>(
                    items: selectedDate.availableTimes,
                    selectedItem: selectedDate.availableTimes[0],
                    onChanged: (time) => selectedTime = time,
                    itemToString: (time) => time,
                    hintText: 'Scegli l\'ora...',
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
                      await FirebaseFirestore.instance
                          .collection('tables')
                          .add({
                            'game': selectedGame?.title,
                            'maxPlayers': 6,
                            'date': selectedDate.date,
                            'players': [],
                            'time': selectedTime,
                            'imagePath': '',
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
      ),
    );
  }
}
