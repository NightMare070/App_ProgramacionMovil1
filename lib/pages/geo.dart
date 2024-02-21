import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Geo extends StatefulWidget {
  const Geo({super.key});

  @override
  State<Geo> createState() => _GeoState();
}

class _GeoState extends State<Geo> {
  String latitud = '';
  String longitud = '';
  late Position ubicacion;

  Future<Position> obtenerUbicacion() async {
    bool servicioOn;
    LocationPermission permiso;

    servicioOn = await Geolocator.isLocationServiceEnabled();
    if (!servicioOn) {
      return Future.error('Servicio de ubicación deshabilitado');
    }

    permiso = await Geolocator.checkPermission();
    if(permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if(permiso == LocationPermission.denied) {
        return Future.error('Permiso de ubicación denegado');
      }
    }

    if(permiso == LocationPermission.deniedForever) {
      return Future.error('Permiso de ubicación denegado permanentemente');
    }

    return Geolocator.getCurrentPosition();
  }

  void botonPresinado() async{
    ubicacion = await obtenerUbicacion();
    setState(() {
      latitud = ubicacion.latitude.toString();
      longitud = ubicacion.longitude.toString();
    });
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
          Text('latitud $latitud'),
          Text('longitud: $longitud'),
          MaterialButton(
            onPressed: () {
              botonPresinado();
            },
            child: const Text('Obtener ubicacion'),
          )
        ],
      )),
    );
  }
}