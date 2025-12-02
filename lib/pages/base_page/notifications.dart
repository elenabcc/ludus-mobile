import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<String> mockNotifications = [
    'Notifica 1',
    'Notifica 2',
    'Notifica 3',
    // altre notifiche mockate
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifiche')),
      body: ListView.builder(
        itemCount: mockNotifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.notifications),
                title: Text(mockNotifications[index]),
                onTap: () {
                  // Azione notifica
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
