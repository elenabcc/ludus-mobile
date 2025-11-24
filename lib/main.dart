import 'package:flutter/material.dart';
import 'pages/games.dart';
import 'pages/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.blue),
      ),
      home:
          const AuthGate(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Header Menu'),
            ),
            ExpansionTile(
              leading: Icon(Icons.casino),
              title: Text('Giochi'),
              childrenPadding: EdgeInsets.only(left: 20.0),
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Giochi LudusGate'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people_alt_outlined),
                  title: Text('Tutti i giochi'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite_border),
                  title: Text('I miei giochi'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.flash_on),
                  title: Text('Il mio BGG'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Nuovo gioco'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.local_grocery_store_outlined),
                  title: Text('Mercatino giochi'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(Icons.star_half),
              title: Text('Ranking'),
              childrenPadding: EdgeInsets.only(left: 20.0),
              children: [
                ListTile(
                  leading: Icon(Icons.people_alt_outlined),
                  title: Text('Classifica giocatori'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.casino),
                  title: Text('Classifica giochi'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.trending_up),
                  title: Text('Trend serate di gioco'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text('Partite disputate'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(Icons.tune),
              title: Text('Admin'),
              childrenPadding: EdgeInsets.only(left: 20.0),
              children: [
                ListTile(
                  leading: Icon(Icons.manage_accounts),
                  title: Text('Gestione utenti'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.menu),
                  title: Text('Log degli utenti'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.textsms_outlined),
                  title: Text('Invio messaggi'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.calendar_month_outlined),
                  title: Text('Calendario'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text('Aggiungi evento'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.output),
                  title: Text('Giochi in prestito'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Games()),
                    );
                  },
                ),
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.assignment_ind),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Pagina1 extends StatelessWidget {
  const Pagina1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagina 1')),
      body: Center(child: Text('Contenuto Pagina 1')),
    );
  }
}

class Pagina2 extends StatelessWidget {
  const Pagina2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagina 2')),
      body: Center(child: Text('Contenuto Pagina 2')),
    );
  }
}

class Pagina3 extends StatelessWidget {
  const Pagina3({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagina 3')),
      body: Center(child: Text('Contenuto Pagina 3')),
    );
  }
}
