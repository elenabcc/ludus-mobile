import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  Timestamp date;
  List<String> availableTimes;

  Event({required this.date, required this.availableTimes});
}
