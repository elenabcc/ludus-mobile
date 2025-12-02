import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'base_page/base_page.dart';

class Table {
  String name;
  int players;
  int maxPlayers;
  String time;
  String imagePath;

  Table({
    required this.name,
    required this.players,
    required this.maxPlayers,
    required this.time,
    required this.imagePath,
  });

  bool get canJoin => players < maxPlayers;
}

class Event {
  Timestamp date;
  List<String> availableTimes;

  Event({required this.date, required this.availableTimes});
}

class Tables extends StatefulWidget {
  const Tables({super.key});

  @override
  State<Tables> createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  List<Event> dates = [];
  Timestamp? selectedDate;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  String title = 'Tavoli disponibili';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('it_IT', null);
    loadDates();
  }

  Future<void> loadDates() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: _getStartOfDay(Timestamp.now()))
        .orderBy('date')
        .limit(4)
        .get();

    setState(() {
      dates = snapshot.docs
          .map(
            (doc) => Event(
              date: doc['date'],
              availableTimes: List.castFrom(doc['availableTimes']),
            ),
          )
          .toList();
      if (dates.isNotEmpty && selectedDate == null) {
        selectedDate = dates[0].date;
      }
      ;
    });
  }

  Timestamp _getStartOfDay(Timestamp date) => Timestamp.fromDate(
    DateTime(date.toDate().year, date.toDate().month, date.toDate().day),
  );

  Timestamp _getEndOfDay(Timestamp date) => Timestamp.fromDate(
    DateTime(
      date.toDate().year,
      date.toDate().month,
      date.toDate().day,
      23,
      59,
      59,
      999,
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (selectedDate == null) {
      return BasePage(
        title: title,
        body: Center(
          child: CircularProgressIndicator(color: Colors.deepPurple),
        ),
      );
    }

    return BasePage(
      title: title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: dates
                  .map(
                    (doc) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ), // spazio orizzontale tra bottoni
                        child: ElevatedButton(
                          onPressed: selectedDate == doc.date
                              ? null
                              : () {
                                  selectedDate = doc.date;
                                  setState(() {});
                                },
                          child: Text(
                            DateFormat(
                              'dd MMM',
                              'it_IT',
                            ).format(doc.date.toDate()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selectedDate == doc.date
                                  ? Colors.grey
                                  : Colors.deepPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('tables')
                    .where(
                      'date',
                      isGreaterThanOrEqualTo: _getStartOfDay(selectedDate!),
                    )
                    .where('date', isLessThan: _getEndOfDay(selectedDate!))
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ),
                    );
                  }
                  var docs = snapshot.data!.docs;
                  var isUserInTable = (docs
                      .where(
                        (doc) =>
                            (doc['players'] as List).contains(currentUser?.uid),
                      )
                      .toList()
                      .isNotEmpty);
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var doc = docs[index];
                      var containsUser = (doc['players'] as List).contains(
                        FirebaseAuth.instance.currentUser?.uid,
                      );
                      return ListTile(
                        onTap: () {},
                        // tileColor: containsUser ? Colors.grey[10] : null,
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'default-game.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          doc['game'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(text: 'Giocatori: '),
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: containsUser
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                text:
                                    '${doc['players'].length}/${doc['maxPlayers']}\n',
                              ),
                              TextSpan(text: 'Orario: '),
                              TextSpan(
                                text: DateFormat(
                                  'HH:mm',
                                ).format(doc['date'].toDate()),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: containsUser
                              ? () async {
                                  await FirebaseFirestore.instance
                                      .collection('tables')
                                      .doc(doc.id)
                                      .update({
                                        'players': FieldValue.arrayRemove([
                                          FirebaseAuth
                                              .instance
                                              .currentUser
                                              ?.uid,
                                        ]),
                                      });
                                }
                              : (doc['players'].length < doc['maxPlayers']) &
                                    !isUserInTable
                              ? () async {
                                  await FirebaseFirestore.instance
                                      .collection('tables')
                                      .doc(doc.id)
                                      .update({
                                        'players': FieldValue.arrayUnion([
                                          FirebaseAuth
                                              .instance
                                              .currentUser
                                              ?.uid,
                                        ]),
                                      });
                                }
                              : null,
                          child: Icon(
                            containsUser ? Icons.remove : Icons.add,
                            color: containsUser
                                ? Colors.deepPurple
                                : (doc['players'].length < doc['maxPlayers']) &
                                      !isUserInTable
                                ? Colors.deepPurple
                                : Colors.grey,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/createTable');
                  },
                  child: const Text(
                    'Crea nuovo tavolo',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
