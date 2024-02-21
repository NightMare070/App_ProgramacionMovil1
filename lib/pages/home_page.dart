import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String _mensaje = 'Bienvenida';
  String _nombre = '';

  Future<void> _getNombre() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs != Null) {
      setState(() {
        _nombre = (prefs.getString('nombre') ?? '');
        _mensaje = 'Bienvenid@ $_nombre';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getNombre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        backgroundColor: Colors.pinkAccent,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(_mensaje,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/acerca de');
        },
        tooltip: 'Acerca de...',
        child: const Icon(Icons.question_mark),
      ),
    );
  }
}
