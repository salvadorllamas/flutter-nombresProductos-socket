import 'dart:io';
import 'dart:math';

import 'package:ban_name/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Jabón para trastes', votes: 2),
    Band(id: '2', name: 'Detergente para ropa', votes: 5),
    Band(id: '3', name: 'Esponjas', votes: 7),
    Band(id: '4', name: 'Escoba', votes: 9),
    Band(id: '5', name: 'Trapeador', votes: 10),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00BCD1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Productos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        elevation: 24,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTitle(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 24,
        onPressed: addNewBand,
      ),
    );
  }

//este widge es para mostrar la estructura el arreglo de bandas  ejemplo
  Widget _bandTitle(Band band) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direccion ${direction}');
        print('id ${band.id}');
      },
      background: Container(
        padding: EdgeInsets.only(left: 30),
        color: Colors.white,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Eliminar Dato',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(
          band.name,
          style: TextStyle(fontSize: 20),
        ),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 24),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if (!Platform.isAndroid) {
      //se ejecuta solo  cuando el dispositivo es android
      return showDialog(
          context: context,
          builder: (contex) {
            return AlertDialog(
              title: const Text(
                'Nuevos productos  :',
              ),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                    child: const Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addToBandToList(textController.text)),
              ],
            );
          });
    }
    showCupertinoDialog(
        //dialogo  de ios
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('Nuevos productos:'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Agregar'),
                onPressed: () => addToBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text(
                  'Salir',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  void addToBandToList(String name) {
    final int random = Random().nextInt(100);
    if (name.length > 1) {
      //podemos  agregar datos  a la lista
      bands.add(
          new Band(id: DateTime.now().toString(), name: name, votes: random));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
