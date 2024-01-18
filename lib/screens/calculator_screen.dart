import 'package:flutter/material.dart';
import 'botones.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CalculatorScreen> {
  var userInput = '';
  var answer = '';

  // Lista de todos los botones
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(97, 0, 0, 0),
      body: Column(
        children: <Widget>[
          Expanded(
            // Contenedor que muestra la operación y el resultado
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Texto que introduce el usuario
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  // Texto del Resultado
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 70,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
          Expanded(
            // Zona de los botones
            flex: 2,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                // Esta sección es la que crea los botones, también
                // tiene en cuenta si es un operador o algún otro boton con
                // función diferente, además de cambiarle el color
                itemBuilder: (BuildContext context, int index) {
                  // Botón de limpiar
                  if (index == 0) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.purple[100],
                      textColor: Colors.red,
                    );
                  }

                  // Botón +/-
                  else if (index == 1) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          cambiarSigno();
                          calcResultado();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.purple[100],
                      textColor: const Color.fromARGB(255, 27, 22, 31),
                    );
                  }
                  // Botón modulo %
                  else if (index == 2) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                          calcResultado();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.purple[100],
                      textColor: const Color.fromARGB(255, 27, 22, 31),
                    );
                  }
                  // Botón de borrado
                  else if (index == 3) {
                    return MyButton(
                      buttontapped: () {
                        // Este warning no lo puedo quitar porque de la forma
                        // que sugiere el IDE no funciona
                        if (userInput.length > 0) {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        }
                      },
                      icon: Icons.backspace,
                      buttonText: buttons[index],
                      color: Colors.purple[100],
                      textColor: const Color.fromARGB(255, 27, 22, 31),
                    );
                  }
                  // Botón de igual
                  else if (index == 18) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          //calcResultado();
                          if (answer == 'Infinity' || answer == 'Error') {
                            userInput = '';
                            answer = '';
                          } else if (answer.isNotEmpty) {
                            userInput = answer;
                            answer = '';
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.purple[500],
                      textColor: Colors.white,
                    );
                  }

                  //  Resto de Botones
                  else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                          calcResultado();
                        });
                      },
                      buttonText: buttons[index],
                      color: esOperador(buttons[index])
                          ? Colors.purple[100]
                          : const Color.fromARGB(255, 27, 22, 31),
                      textColor: esOperador(buttons[index])
                          ? const Color.fromARGB(255, 27, 22, 31)
                          : Colors.purple[100],
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  // Función que comprueba si el botón es un operador
  bool esOperador(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  // Función que cambia el signo del último número introducido
  // Si hay varios operadores seguidos, cambia solo el último número
  void cambiarSigno() {
    RegExp regExp = RegExp(
      r"[x/+-]",
    );
    Iterable<RegExpMatch> iter = RegExp(r"(?<=[0-9])-").allMatches(userInput);
    if (iter.isNotEmpty &&
        userInput.substring(iter.last.start, iter.last.end) == '-') {
      // Esto es para cuando es un número negativo y queremos volverlo positivo
      userInput = userInput.replaceRange(iter.last.start, iter.last.end, '+');
    } else if (regExp.hasMatch(userInput)) {
      Iterable<RegExpMatch> iter2 = regExp.allMatches(userInput);
      String ultimo = userInput.substring(iter2.last.start, iter2.last.end);
      if (ultimo.length == 1 && ultimo[ultimo.length - 1] == '+') {
        // Si es positivo simplemente reemplazarlo a negativo
        userInput =
            userInput.replaceRange(iter2.last.start, iter2.last.end, '-');
      } else if (ultimo[ultimo.length - 1] == '-') {
        // Borra el último operador
        userInput =
            userInput.replaceRange(iter2.last.start, iter2.last.end, '');
      } else {
        // Añade un operador negativo
        userInput = userInput.replaceRange(
            iter2.last.start, iter2.last.end, ultimo + '-');
      }

      /*
      List<String> lista = userInput.split(regExp);
      String ultimo = lista.last;
      if (ultimo[0] != '-') {
        lista.last = '-' + ultimo;
      } else {
        lista.last = ultimo.substring(1);
      }
      // Vuelve a juntar la lista en un string
      userInput = lista.join(userInput[regExp.firstMatch(userInput)!.start]);
      */
    } else if (userInput[0] != '-') {
      userInput = '-' + userInput;
    } else {
      userInput = userInput.substring(1);
    }
  }

  // Función que calcula el resultado
  // Esta función se llama cada vez que se introduce un nuevo número
  // y comprueba si el texto introducido es una operación válida
  // Si lo es, calcula el resultado y lo devuelve
  void calcResultado() {
    String input = userInput;
    if (userInput.isEmpty) {
      answer = '';
      return;
    }
    // Si el usuario introduce un %, se
    if (userInput.contains('%')) {
      input = procesarModulo(input);
    }
    // Este regex comprueba que el usuario ha introducido una operación válida
    // Link al regex para probarlo: https://regex101.com/r/5KEnk1/6
    // V0: r"[0-9]+[x/+-][0-9]+(?:[/+*-][0-9]+)*(?![x/+\-])"
    // V1: r"[0-9]+[x/+-]-?[0-9]+(?:[/+*-][0-9]+)*(?![x/+\-])"
    // modificado para que pueda aceptar números negativos después de un operador
    // V2: r"^-?[0-9]+[x/+-]-?[0-9]+(?:[/+*-][0-9]+)*(?![x/+\-])"
    // Para que pueda tener un número negativo al principio pero no otro operador
    // V3: r"^-?[0-9.]+[x/+-]-?[0-9.]+(?:[/+*-][0-9.]+)*(?![x/+\-])"
    // Añadidos Decimales
    // V4: r"^-?[0-9]+(?:\.[0-9]+)?[x/+-]-?[0-9]+(?:\.[0-9]+)?([0-9]+)?(?:[/+x-][0-9]+(?:\.[0-9]+)?)*$"
    // Optimizados los decimales y la expresión en general
    // V5: r"^-?[0-9]+(?:\.[0-9]+)?[x/+-]-?[0-9]+(?:\.[0-9]+)?([0-9]+)?(?:[/+x-]-?[0-9]+(?:\.[0-9]+)?)*$"
    // Arreglado el problema de que no se podía poner un número negativo al principio despues de un operador
    RegExp regExp = RegExp(
      r"^-?[0-9]+(?:\.[0-9]+)?[x/+-]-?[0-9]+(?:\.[0-9]+)?([0-9]+)?(?:[/+x-]-?[0-9]+(?:\.[0-9]+)?)*$",
      caseSensitive: false,
      multiLine: false,
    );
    if (regExp.hasMatch(input)) {
      answer = calculo(input);
    } else {
      answer = '';
    }
  }

  // Función que calcula el resultado de la operación
  String calculo(String operacion) {
    String opFiltered = operacion;
    opFiltered = operacion.replaceAll('x', '*');
    String resultado = '';

    // Aquí uso la librería math_expressions para calcular el resultado
    Parser p = Parser();
    try {
      Expression exp = p.parse(opFiltered);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      // Si el resultado es un número entero, se muestra sin decimales
      if (eval == eval.roundToDouble()) {
        resultado = eval.round().toString();
      } else {
        resultado = eval.toString();
      }
      //resultado = eval.toString();
    } catch (e) {
      resultado = 'Error';
    }
    return resultado;
  }

  String procesarModulo(String input) {
    // Split the input into numeric part, operator, and remaining string
    RegExp regex = RegExp(r'([0-9.]+)%');
    Iterable<RegExpMatch> iter = regex.allMatches(input);
    String resultado = input;

    for (RegExpMatch match in iter) {
      String numericPart = match.group(1)!;
      double convertedNumeric = double.parse(numericPart) / 100.0;

      resultado = resultado.replaceRange(
          match.start, match.end, convertedNumeric.toString());
      // Recursively process the result until no more matches are found
    }

    return resultado;
  }
}
