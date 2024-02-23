import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final db = FirebaseFirestore.instance;

  int _contador = 0;

  void writeData() async {
    await db.collection('numeros').doc('n0').set({'contador': _contador});
  }

  void readData() async {
    await db.collection('numeros').doc('n0').get().then((event) {
      setState(() {
        _contador = event.data()!['contador'];
      });
    });
  }

  @override
  void initState() {
    readData();
  }

  void _incrementCounter() {
    setState(() {
      _contador++;
    });
    writeData();
  }

  void _decrementCounter() {
    setState(() {
      _contador--;
    });
    writeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contador'),
          backgroundColor: Colors.yellowAccent,
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'El valor del contador es:',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '$_contador',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'Plus',
              onPressed: _incrementCounter,
              tooltip: 'Incrementa el contador',
              backgroundColor: Colors.greenAccent,
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              heroTag: 'Minus',
              onPressed: _decrementCounter,
              tooltip: 'Decrementa el contador',
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.remove),
            )
          ],
        ));
  }
}
