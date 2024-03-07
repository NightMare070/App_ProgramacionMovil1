import 'package:flutter/material.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class imagenClickeable extends StatefulWidget {
  const imagenClickeable({
    super.key,
    required this.largo,
    required this.ancho,
    required this.ruta,
    required this.accion
  });

  final double largo;
  final double ancho;
  final String ruta;
  final void Function() accion;

  @override
  State<imagenClickeable> createState() => _imagenClickeableState();
}

class _imagenClickeableState extends State<imagenClickeable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.largo,
      width: widget.ancho,
      child: MaterialButton(
        onPressed: widget.accion, 
        child: widget.ruta.startsWith('http')
          ? Image.network(widget.ruta)
          : Image.asset(widget.ruta),
      ),
    );
  }
}

class _ImagesState extends State<Images> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagenes'),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagenClickeable(
                largo: 300, 
                ancho: 300, 
                ruta: 'assets/gatos/enojao.jpg', 
                accion:() {
                  print("Imagen clickeada de gato enojao");
                }),
              /* SizedBox(
                child: MaterialButton(
                  child: Image.asset('assets/gatos/enojao.jpg'),
                  onPressed: (){
                    print('Gato enojado');
                  },
                ),
                height: 300,
              ), */
              SizedBox(
                child: Image.network('https://imagenes.20minutos.es/files/image_1920_1080/uploads/imagenes/2023/08/22/gato-esfinge-sphynx-dmitri-makeev-wikimedia-commons-cc-by-sa-4-0.jpeg'),
                height: 300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}