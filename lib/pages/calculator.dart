import 'package:flutter/material.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcButton(String text, Color bgColor, Color textColor) {
    return ElevatedButton(
        onPressed: () {
          calcular(text);
        },
        style: ButtonStyle(
            shape: const MaterialStatePropertyAll(CircleBorder()),
            backgroundColor: MaterialStatePropertyAll(bgColor),
            padding: const MaterialStatePropertyAll(EdgeInsets.all(20)),
            minimumSize: const MaterialStatePropertyAll(Size(90, 80)),
            maximumSize: const MaterialStatePropertyAll(Size(90, 100))),
        child: Text(text, style: TextStyle(fontSize: 24, color: textColor)));
  }

  String numActualString = '0';
  dynamic operando1;
  dynamic operacionTemporal = 0;

  String operacion = '';
  String preview = '';

  int contadorPuntos = 0;
  dynamic numAnterior = 0;

  dynamic resultado = 0;
  bool igual = false;

  dynamic ejecutarOperacion(String operacion, dynamic num1, dynamic num2) {
    dynamic resultado = 0;
    switch (operacion) {
      case '+':
        resultado = ((num1) + (num2));
        break;
      case '-':
        resultado = ((num1) - (num2));
        break;
      case '*':
        resultado = ((num1) * (num2));
        break;
      case '/':
        if (num2 != 0.0) {
          resultado = ((num1) / (num2));
        } else {
          resultado = 'Error';
        }
        break;
      default:
        return null;
    }
    return resultado;
  }

  void calcular(String textoBoton) {
    switch (textoBoton) {
      case '+':
        print('Se ejecuto un +');
        if (operacion != '+') {
          setState(() {
            print('NO es una suma');
            if (operacion == '') {
              operando1 = double.parse(numActualString);
            }
            if (operacion != '') {
              operando1 = ejecutarOperacion(
                  operacion, operando1, double.parse(numActualString));
            }
            operacion = '+';
            preview = '$operando1 $operacion';
            numActualString = '0';
          });
        } else {
          setState(() {
            print('SI es una suma');
            operacionTemporal = (operando1) + (double.parse(numActualString));
            operando1 = operacionTemporal;
            preview = '$operacionTemporal $operacion';
            numActualString = '0';
          });
        }
        break;
      case '-':
        print('Se ejecuto un -');
        if (operacion != '-') {
          setState(() {
            print('NO es una resta');
            if (operacion == '') {
              operando1 = double.parse(numActualString);
            }
            if (operacion != '') {
              operando1 = ejecutarOperacion(
                  operacion, operando1, double.parse(numActualString));
            }
            operacion = '-';
            preview = '$operando1 $operacion';
            numActualString = '0';
          });
        } else {
          setState(() {
            print('SI es una resta');
            operacionTemporal = (operando1) - (double.parse(numActualString));
            operando1 = operacionTemporal;
            preview = '$operacionTemporal $operacion';
            numActualString = '0';
          });
        }
        break;
      case '*':
        print('Se ejecuto un *');
        if (operacion != '*') {
          setState(() {
            print('NO es una multi');
            if (operacion == '') {
              operando1 = double.parse(numActualString);
            }
            if (operacion != '') {
              operando1 = ejecutarOperacion(
                  operacion, operando1, double.parse(numActualString));
            }
            operacion = '*';
            preview = '$operando1 $operacion';
            numActualString = '0';
          });
        } else {
          setState(() {
            print('SI es una multi');
            operacionTemporal = (operando1) * (double.parse(numActualString));
            operando1 = operacionTemporal;
            preview = '$operacionTemporal $operacion';
            numActualString = '0';
          });
        }
        break;
      case '/':
        print('Se ejecuto un /');
        if (operacion != '/') {
          setState(() {
            print('NO es una division');
            if (operacion == '') {
              operando1 = double.parse(numActualString);
            }
            if (operacion != '') {
              operando1 = ejecutarOperacion(
                  operacion, operando1, double.parse(numActualString));
            }
            operacion = '/';
            preview = '$operando1 $operacion';
            numActualString = '0';
          });
        } else {
          setState(() {
            print('SI es una division');
            if (double.parse(numActualString) != 0.0) {
              operacionTemporal = (operando1) / (double.parse(numActualString));
              operando1 = operacionTemporal;
              preview = '$operacionTemporal $operacion';
              numActualString = '0';
            } else {
              print('Error de division');
              setState(() {
                numActualString = 'Error';
              });
              operando1;
              operacionTemporal = 0;

              operacion = '';
              preview = '';

              contadorPuntos = 0;
              numAnterior = 0;

              resultado = 0;

              igual = true;
            }
          });
        }
        break;
      case 'AC':
        print('Se ejecuto un AC');
        setState(() {
          numActualString = '0';
          operando1;
          operacionTemporal = 0;

          operacion = '';
          preview = '';

          contadorPuntos = 0;
          numAnterior = 0;

          resultado = 0;

          igual = false;
        });
        break;
      case 'e':
        print('Se ejecuto un e');
        setState(() {
          numActualString = e.toString();
        });
        break;
      case '<-':
        print('Se ejecuto un <-');
        if (numActualString.length > 1 && igual == false) {
          setState(() {
            numActualString =
                numActualString.substring(0, numActualString.length - 1);
          });
        } else {
          setState(() {
            numActualString = '0';
          });
        }
        break;
      case 'π':
        print('Se ejecuto un π');
        setState(() {
          numActualString = pi.toString();
        });
        break;
      case '.':
        print('Se ejecuto un .');
        if (contadorPuntos == 0) {
          setState(() {
            numActualString += textoBoton;
          });
          contadorPuntos++;
        }
        break;
      case '=':
        print('Se ejecuto un =');
        resultado = operando1 = ejecutarOperacion(
            operacion, operando1, double.parse(numActualString));
        if (resultado != null) {
          setState(() {
            numActualString = resultado.toString();
            operando1;
            operacionTemporal = 0;

            operacion = '';
            preview = '';

            contadorPuntos = 0;
            numAnterior = 0;

            resultado = 0;

            igual = true;
          });
        } else if (resultado == 'Error') {
          numActualString = resultado;
          operando1;
          operacionTemporal = 0;

          operacion = '';
          preview = '';

          contadorPuntos = 0;
          numAnterior = 0;

          resultado = 0;

          igual = true;
        }
        break;
      default:
        print('Numero presionado');
        //Comprobacion para que no haya 0 al inicio
        if (igual) {
          setState(() {
            numActualString = '0';
          });
          igual = false;
        }
        if (numActualString.startsWith('0') &&
            numActualString.contains('.') == false) {
          numActualString = numActualString.substring(1);
        }
        setState(() {
          numActualString += textoBoton;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '$preview',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    //EN ESTE CHILD SOLO VA TEXT
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 30,
                        child: Scrollbar(
                          //thumbVisibility: true,
                          //trackVisibility: true,
                          child: SingleChildScrollView(
                            reverse: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              //AGREGAR QUE EL SCROLL SE VAYA AL FINAL CUANDO SE BORRA UN NUMERO
                              '$numActualString',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )))
              ],
            ),
            const Divider(
              color: Colors.grey, // Color de la línea divisora
              thickness: 2, // Grosor de la línea divisora
              height: 60, // Altura de la línea divisora
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.deepPurple, Colors.white),
                calcButton('e', Colors.deepPurple, Colors.white),
                calcButton('<-', Colors.deepPurple, Colors.white),
                calcButton('/', Colors.redAccent, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.blueGrey, Colors.white),
                calcButton('8', Colors.blueGrey, Colors.white),
                calcButton('9', Colors.blueGrey, Colors.white),
                calcButton('*', Colors.redAccent, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.blueGrey, Colors.white),
                calcButton('5', Colors.blueGrey, Colors.white),
                calcButton('6', Colors.blueGrey, Colors.white),
                calcButton('-', Colors.redAccent, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.blueGrey, Colors.white),
                calcButton('2', Colors.blueGrey, Colors.white),
                calcButton('3', Colors.blueGrey, Colors.white),
                calcButton('+', Colors.redAccent, Colors.white),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('π', Colors.deepPurple, Colors.white),
                calcButton('0', Colors.blueGrey, Colors.white),
                calcButton('.', Colors.deepPurple, Colors.white),
                calcButton('=', Colors.yellowAccent, Colors.black),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
