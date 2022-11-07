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

  String selectorActFisica = "no";
  final ref = FirebaseFirestore.instance.collection("Paciente");
  bool loading = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Paciente"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async{
            if (_controllerName.text.isNotEmpty && _controllerPeso.text.isNotEmpty && _controllerEdad.text.isNotEmpty && _controllerAhf.text.isNotEmpty && _controllerProfesion.text.isNotEmpty && _controllerapp.text.isNotEmpty && _controllerpa.text.isNotEmpty) {
            setState(() {
            loading = true;
            });
            await  ref.add({
                "antecedentes": _controllerAhf.text,
                "app": _controllerapp.text,
                "edad": _controllerEdad.text,
                "fisica": selectorActFisica,
                "nombre": _controllerName.text,
                "pa": _controllerpa.text,
                "peso": _controllerPeso.text,
                "profesion": _controllerProfesion.text
              });
              setState(() {
                loading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se agrego correctamente el paciente")));
              Navigator.pop(context);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Color(0xfff8d7da),
                content: Text("Faltan campos por rellenar!!",style: TextStyle(color: Color(0xff842029)),)));
            }
          }, icon: loading ? const CircularProgressIndicator(color: Colors.white,) : Icon(Icons.check))
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:  [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 50),
                              child: TextField(
                                controller: _controllerName,
                                decoration: const InputDecoration(
                                  hintText: "Nombre"
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 50),
                              child: TextField(
                                controller: _controllerEdad,
                                decoration: InputDecoration(
                                  hintText: "Edad"
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 50),
                              child: TextField(
                                controller: _controllerProfesion,
                                decoration: InputDecoration(
                                  hintText: "Profesion"
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 50),
                              child: TextField(
                                controller: _controllerPeso,
                                decoration: InputDecoration(
                                  hintText: "peso"
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 50),
                              child: TextField(
                                controller: _controllerAhf,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Antecedentes heredoFamiliares"
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 50),
                              child: TextField(
                                maxLines: 5,
                                controller: _controllerapp,
                                decoration: InputDecoration(
                                  hintText: "Antecedentes personlaes patologicos"
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text("¿Realiza alguna actividad Fisica?"),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      
                                      value: "si", groupValue: selectorActFisica, onChanged: (value) {
                                      setState(() {
                                      selectorActFisica = value!;
                                        
                                      });
                                    },),
                                    Text("Si")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      
                                      value: "no", groupValue: selectorActFisica, onChanged: (value) {
                                        setState(() {
                                        selectorActFisica = value!;
                                          
                                        });
                                    },),
                                    Text("No")
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                             Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 50),
                              child: TextField(
                                maxLines: 5,
                                
                                controller: _controllerpa,
                                decoration: InputDecoration(
                                  
                                  hintText: "Padecimiento actual"
                                ),
                              ),
                            ),
                          ],
                        ),
      ),
    );
  }
}