import 'package:flutter/material.dart';
import 'package:general_app/pages/about.dart';
import 'package:general_app/pages/add_event.dart';
import 'package:general_app/pages/calculator.dart';
import 'package:general_app/pages/get_into.dart';
import 'package:general_app/pages/geo.dart';
import 'package:general_app/pages/calendar.dart';
import 'pages/home_page.dart';
import 'pages/counter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const App());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  static final List<Widget> _pagesOptions = <Widget>[
    const HomePage(),
    const Counter(),
    const Calculator(),
    const Geo(),
    const Calendar()
  ];

  void _home(int n) {
    setState(() {
      _selectedIndex = n;
    });
  }

  @override
  void initState() {
    super.initState();
    _pagesOptions.add(GetInto(home: _home));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: {
        '/inicio': (context) => const HomePage(),
        '/contador': (context) => const Counter(),
        '/calculadora': (context) => const Calculator(),
        '/acerca de': (context) => const About(),
        '/agregar evento': (context) => const AddEvent()
      },
      home: Scaffold(
        body: _pagesOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(
                icon: Icon(Icons.numbers), label: 'Contador'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate), label: 'Calculadora'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: 'Ubicación'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Calendario'),
            BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Ingresa'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

/* class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/contador': (context) => const Counter(),
        '/calculadora': (context) => const Calculator(),
        '/acerca de': (context) => const About()
      },
    );
  }
} */
