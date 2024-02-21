import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetInto extends StatefulWidget {
  const GetInto({super.key, required this.home});

  final Function home;

  @override
  State<GetInto> createState() => _GetIntoState();
}

class _GetIntoState extends State<GetInto> {
  TextEditingController _textEditingController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _guardarNombre() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs != Null) {
      prefs.setString('nombre', _textEditingController.text);
      setState(() {
        _textEditingController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        backgroundColor: Colors.cyan,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Ingresa tus datos:',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    TextField(
                      //obscureText: true,
                      onSubmitted: (value) {
                        _guardarNombre();
                        widget.home(0);
                      },
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Nombre:'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _guardarNombre();
                        widget.home(0);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
