import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int contador = 0;

  void incrementar() {
    setState(() {
      contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    const tamano30 = TextStyle(fontSize: 30);

    return Scaffold(
      //backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: const Text('Contador'),
        elevation: 0.0,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Numero de clicks",
            style: tamano30,
          ),
          Text(
            "$contador",
            style: tamano30,
            textAlign: TextAlign.center,
          ),
        ],
      )),
      // Cambia la posicion del boton
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFloatingActionButton(
        incrementarFN: incrementar,
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final Function incrementarFN;
  const CustomFloatingActionButton({
    super.key,
    required this.incrementarFN,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // Fila de botones
      children: [
        FloatingActionButton(
          // Boton de menos
          //onPressed: () => setState(() {contador--;}),
          onPressed: null,
          child: const Icon(Icons.remove_circle),
          //child: const Text("Añadir"),
        ),
        //const SizedBox(width: 20,),
        FloatingActionButton(
          // Boton de reset
          //onPressed: () => setState(() {contador = 0;}),
          onPressed: null,
          child: const Icon(Icons.replay_outlined),
          //child: const Text("Añadir"),
        ),
        // Espacio en blanco entre botones
        //const SizedBox(width: 20,),
        FloatingActionButton(
          // Boton de mas
          //onPressed: () => setState(() {contador++;}),
          onPressed: incrementarFN(),
          child: const Icon(Icons.add_circle),
          //child: const Text("Añadir"),
        ),
      ],
    );
  }
}
