import 'package:bioappmikary/pages/src/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class HomeDataLast extends StatefulWidget {
  final Map<String,dynamic>? value;
  const HomeDataLast({super.key,this.value});

  @override
  State<HomeDataLast> createState() => _HomeDataLastState();
}

class _HomeDataLastState extends State<HomeDataLast> {
  TextEditingController _controllerDiametroMuscular = TextEditingController();
  TextEditingController _controllerEscalaEvaluativa = TextEditingController();
  final ref_cita = FirebaseFirestore.instance.collection("Cita");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cita nueva"),
        actions: [
          IconButton(onPressed: () async{
            if (_controllerDiametroMuscular.text.isNotEmpty && _controllerEscalaEvaluativa.text.isNotEmpty) {
            await ref_cita.add({
            "fecha": DateTime.now().toString().split(" ")[0],
            "id": widget.value!["id"],
            "nombre": widget.value!["data"]["nombre"],
            "diametro": _controllerDiametroMuscular.text,
            "escala": _controllerEscalaEvaluativa.text,
            "rom": widget.value!["tamaño"]
          }); 
          if (mounted) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Menu();
            },
          ));
          }
            }
          }, icon: Icon(Icons.check))
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _controllerDiametroMuscular,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: "Diámetro muscular"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [Icon(Icons.emoji_emotions), Text("1")],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.emoji_emotions,
                      color: Colors.blue,
                    ),
                    Text(
                      "2",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.emoji_emotions, color: Colors.blue),
                    Text("3", style: TextStyle(color: Colors.blue))
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.emoji_emotions, color: Colors.green),
                    Text("4", style: TextStyle(color: Colors.green))
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.emoji_emotions, color: Colors.green),
                    Text("5", style: TextStyle(color: Colors.green))
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.emoji_emotions, color: Colors.yellow),
                    Text("6", style: TextStyle(color: Colors.yellow))
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.emoji_emotions, color: Colors.yellow),
                    Text("7", style: TextStyle(color: Colors.yellow))
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.emoji_emotions, color: Colors.orange),
                    Text("8", style: TextStyle(color: Colors.orange))
                  ],
                ),
                Column(
                  children: const [
                    Icon(Icons.emoji_emotions, color: Colors.orange),
                    Text("9", style: TextStyle(color: Colors.orange))
                  ],
                ),
                Column(
                  children: const [
                    Icon(
                      Icons.emoji_emotions,
                      color: Colors.red,
                    ),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _controllerEscalaEvaluativa,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Escala evaluativa de dolor"),
              ),
            ),
        ],
      ),
    );
  }
}