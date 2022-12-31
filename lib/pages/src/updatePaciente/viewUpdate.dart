import 'package:bioappmikary/pages/src/updatePaciente/updatePaciente.dart';
import 'package:bioappmikary/pages/src/viewPaciente/viewPaciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewUpdate extends StatefulWidget {
 Map<String, dynamic>? paciente; 
  ViewUpdate({super.key, this.paciente});

  @override
  State<ViewUpdate> createState() => _ViewUpdateState();
}

class _ViewUpdateState extends State<ViewUpdate> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEdad = TextEditingController();
  TextEditingController _controllerProfesion = TextEditingController();
  TextEditingController _controllerPeso = TextEditingController();
  TextEditingController _controllerAhf = TextEditingController();
  TextEditingController _controllerapp = TextEditingController();
  TextEditingController _controllerpa = TextEditingController();

  String selectorActFisica = "no";
  final ref = FirebaseFirestore.instance.collection("Paciente");
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerEdad.text = widget.paciente!["data"]["edad"];
    _controllerName.text = widget.paciente!["data"]["nombre"];
    _controllerAhf.text = widget.paciente!["data"]["antecedentes"];
    _controllerPeso.text = widget.paciente!["data"]["peso"];
    _controllerProfesion.text = widget.paciente!["data"]["profesion"];
    _controllerapp.text = widget.paciente!["data"]["app"];
    _controllerpa.text = widget.paciente!["data"]["pa"];
    selectorActFisica = widget.paciente!["data"]["fisica"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Paciente"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await ref.doc(widget.paciente!["id"]).update({
                  "antecedentes": _controllerAhf.text,
                  "edad": _controllerEdad.text,
                  "nombre": _controllerName.text,
                  "peso": _controllerPeso.text,
                  "profesion": _controllerProfesion.text,
                  "app": _controllerapp.text,
                  "pa": _controllerpa.text,
                  "fisica": selectorActFisica
                });
                setState(() {
                  loading = false;
                });
                if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Se actualizaron correctamente los campos")));
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const UpdatePaciente();
                          },
                        )));
                }
              },
              icon: loading ? const  CircularProgressIndicator(
                color: Colors.white,
              ) :  const Icon(Icons.check))
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
                decoration: InputDecoration(hintText: "Profesion"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _controllerPeso,
                decoration: InputDecoration(hintText: "peso"),
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
                decoration:
                    InputDecoration(hintText: "Antecedentes heredoFamiliares"),
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
                    hintText: "Antecedentes personlaes patologicos"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("¿Realiza alguna actividad Fisica?"),
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
                decoration: InputDecoration(hintText: "Padecimiento actual"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
