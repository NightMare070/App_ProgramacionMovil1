import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final db = FirebaseFirestore.instance;

  late DateTime fechaInicio;
  late DateTime fechaFinal;
  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  // ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  final TextEditingController _nombreEvento = TextEditingController();
  final TextEditingController _inicioEvento = TextEditingController();
  final TextEditingController _finEvento = TextEditingController();
  final TextEditingController _colorEvento = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _cargarDatos() async {
    String nombre = _nombreEvento.text;
    DateTime inicio = fechaInicio;
    DateTime fin = fechaFinal;
    int color = currentColor.value;

/*     Timestamp inicioTimeStamp =
        Timestamp.fromMillisecondsSinceEpoch(inicio.millisecondsSinceEpoch);
    Timestamp finalTimeStamp =
        Timestamp.fromMillisecondsSinceEpoch(fin.millisecondsSinceEpoch); */

    Map<String, dynamic> datos = {
      'Nombre': nombre,
      'Inicio': inicio,
      'Fin': fin,
      'Color': color
    };

    await db.collection('calendario').doc(nombre).set(datos);
  }

  /* final TextEditingController _nombreTec = TextEditingController();
  final TextEditingController _inicioTec = TextEditingController();
  TextEditingController _finTec = TextEditingController();
  TextEditingController _colorTec = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _cargarDatos() async {
    String nombre = _nombreTec.text;
    DateTime inicio = DateTime.parse(_inicioTec.text);
    Timestamp fin =
        Timestamp.fromDate(DateTime.parse(_finTec.text)); //Solo datetime
    int color = int.parse(_colorTec.text);

    //No es TEC es DT
    final inicio = Timestamp(_inicioTec.milisecondsSinceEpoch / 1000, 0);
    final inicio = Timestamp(_finTec.milisecondsSinceEpoch / 1000, 0);

    Map<String, dynamic> datos = {
      'Nombre': nombre,
      'Inicio': inicio,
      'Fin': fin,
      'Color': color
    };

    await db.collection('calendario').doc(nombre).set(datos);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar evento',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  TextField(
                    controller: _nombreEvento,
                    onSubmitted: (value) {
                      _cargarDatos();
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre del evento:'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _inicioEvento,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Fecha de inicio:'),
                    onTap: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onChanged: (dateTime) {
                        print('Fecha y hora seleccionada: $dateTime');
                      }, onConfirm: (dateTime) {
                        setState(() {
                          fechaInicio = dateTime;
                          _inicioEvento.text = dateTime.toString();
                        });
                      }, currentTime: DateTime.now());
                    },
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _finEvento,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Fecha de final:'),
                    onTap: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onChanged: (dateTime) {
                        print('Fecha y hora seleccionada: $dateTime');
                      }, onConfirm: (dateTime) {
                        setState(() {
                          fechaFinal = dateTime;
                          _finEvento.text = dateTime.toString();
                        });
                      }, currentTime: DateTime.now());
                    },
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Selecciona un color'),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                          pickerColor: pickerColor,
                                          onColorChanged: changeColor),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              currentColor = pickerColor;
                                              Navigator.of(context).pop();
                                              print(currentColor.value);
                                            });
                                          },
                                          child: const Text('Listo'))
                                    ],
                                  );
                                });
                          },
                          child: const Text('Selecciona un color')),
                      Container(
                        width: 50,
                        height: 50,
                        color: currentColor,
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _cargarDatos();
                      },
                      child: const Text('Agregar'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}