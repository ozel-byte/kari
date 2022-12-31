import 'package:bioappmikary/pages/src/agregarPaciente/blue.dart';
import 'package:bioappmikary/pages/src/menu/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgregarPaciente extends StatefulWidget {
  const AgregarPaciente({super.key});

  @override
  State<AgregarPaciente> createState() => _AgregarPacienteState();
}

class _AgregarPacienteState extends State<AgregarPaciente> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEdad = TextEditingController();
  TextEditingController _controllerProfesion = TextEditingController();
  TextEditingController _controllerPeso = TextEditingController();
  TextEditingController _controllerAhf = TextEditingController();
  TextEditingController _controllerapp = TextEditingController();
  TextEditingController _controllerpa = TextEditingController();
  TextEditingController _controllerDiametroMuscular = TextEditingController();
  TextEditingController _controllerEscalaEvaluativa = TextEditingController();

  String selectorActFisica = "no";
  String selectorActSexo = "h";
  final ref = FirebaseFirestore.instance.collection("Paciente");
  final ref_cita = FirebaseFirestore.instance.collection("Cita");

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Paciente"),
        centerTitle: true,
        actions: [
          IconButton(

              onPressed: () async {
                
                if (_controllerName.text.isNotEmpty &&
                    _controllerPeso.text.isNotEmpty &&
                    _controllerEdad.text.isNotEmpty &&
                    _controllerAhf.text.isNotEmpty &&
                    _controllerProfesion.text.isNotEmpty &&
                    _controllerapp.text.isNotEmpty &&
                    _controllerpa.text.isNotEmpty &&
                    _controllerDiametroMuscular.text.isNotEmpty &&
                    _controllerEscalaEvaluativa.text.isNotEmpty) {
                  Map<String, dynamic> user = {
                    "antecedentes": _controllerAhf.text,
                    "app": _controllerapp.text,
                    "edad": _controllerEdad.text,
                    "fisica": selectorActFisica,
                    "nombre": _controllerName.text,
                    "pa": _controllerpa.text,
                    "peso": _controllerPeso.text,
                    "profesion": _controllerProfesion.text,
                    "sexo": selectorActSexo,
                    "diametro-muscular": _controllerDiametroMuscular.text,
                    "escala": _controllerEscalaEvaluativa.text
                  };
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return BluetoothAddUser(
                        user: user,
                      );
                    },
                  ));

                  //     setState(() {
                  //     loading = true;
                  //     });
                  // final resp  =  await  ref.add({
                  //         "antecedentes": _controllerAhf.text,
                  //         "app": _controllerapp.text,
                  //         "edad": _controllerEdad.text,
                  //         "fisica": selectorActFisica,
                  //         "nombre": _controllerName.text,
                  //         "pa": _controllerpa.text,
                  //         "peso": _controllerPeso.text,
                  //         "profesion": _controllerProfesion.text,
                  //         "sexo": selectorActSexo
                  //       });

                  //         await ref_cita.add({
                  //           "fecha": DateTime.now().toString().split(" ")[0],
                  //           "id": resp.id
                  //         });
                  //       setState(() {
                  //         loading = false;
                  //       });
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se agrego correctamente el paciente")));
                  // Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Color(0xfff8d7da),
                      content: Text(
                        "Faltan campos por rellenar!!",
                        style: TextStyle(color: Color(0xff842029)),
                      )));
                }
              },
              icon: loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _controllerName,
                decoration: const InputDecoration(hintText: "Nombre"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _controllerEdad,
                decoration: InputDecoration(hintText: "Edad"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _controllerProfesion,
                decoration: InputDecoration(hintText: "Profesión"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _controllerPeso,
                decoration: InputDecoration(hintText: "Peso"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _controllerAhf,
                maxLines: 5,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Antecedentes heredofamiliares"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                maxLines: 5,
                controller: _controllerapp,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Antecedentes personlaes patologicos"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("¿Realiza alguna actividad física?"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: "si",
                      groupValue: selectorActFisica,
                      onChanged: (value) {
                        setState(() {
                          selectorActFisica = value!;
                        });
                      },
                    ),
                    Text("Si")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "no",
                      groupValue: selectorActFisica,
                      onChanged: (value) {
                        setState(() {
                          selectorActFisica = value!;
                        });
                      },
                    ),
                    Text("No")
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                maxLines: 5,
                controller: _controllerpa,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    hintText: "Padecimiento actual"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Selecione su sexo"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: "m",
                      groupValue: selectorActSexo,
                      onChanged: (value) {
                        setState(() {
                          selectorActSexo = value!;
                        });
                      },
                    ),
                    Text("Mujer")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "h",
                      groupValue: selectorActSexo,
                      onChanged: (value) {
                        setState(() {
                          selectorActSexo = value!;
                        });
                      },
                    ),
                    Text("Hombre")
                  ],
                )
              ],
            ),
            const Divider(),
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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
