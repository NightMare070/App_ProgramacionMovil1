import 'package:flutter/material.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class listaImagen extends StatefulWidget {
  const listaImagen(
    {super.key, required this.rutaImagen, required this.descripcion}
    );

    final List<String> rutaImagen;
    final List<String> descripcion;

  @override
  State<listaImagen> createState() => _listaImagenState();
}

class _listaImagenState extends State<listaImagen> {
  List<Widget> listaWidgets = [];

  @override
  void initState() {
    super.initState();
    crearWidgets();
  }

  void crearWidgets() {
    for (var i = 0; i < widget.rutaImagen.length; i++) {
      listaWidgets.add(Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8), // Color de la sombra
                spreadRadius: 5, // Radio de propagación de la sombra
                blurRadius: 7, // Radio de desenfoque de la sombra
                offset: const Offset(0, 3), // Cambio de posición de la sombra
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    /* decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Color de la sombra
                          spreadRadius: 5, // Radio de propagación de la sombra
                          blurRadius: 7, // Radio de desenfoque de la sombra
                          offset: const Offset(
                              0, 3), // Cambio de posición de la sombra
                        ),
                      ],
                    ), */
                    child: Image.asset(
                      widget.rutaImagen[i],
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Text(widget.descripcion[i],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ));
      listaWidgets.add(const SizedBox(height: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: listaWidgets,
    );
  }
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
        title: const Text(
          'Imagenes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: listaImagen(rutaImagen: [
          'assets/gatos/enojao.jpg',
          'assets/gatos/enojao.jpg',
          'assets/gatos/enojao.jpg',
          'assets/gatos/enojao.jpg',
          'assets/gatos/enojao.jpg',
          'assets/gatos/enojao.jpg',
          'assets/gatos/enojao.jpg',
          'assets/gatos/enojao.jpg'
        ], descripcion: [
          'Imagen 1',
          'Imagen 2',
          'Imagen 3',
          'Imagen 4',
          'Imagen 5',
          'Imagen 6',
          'Imagen 7',
          'Imagen 8'
        ]),
      )
    );
  }

  /* @override
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
  } */
}