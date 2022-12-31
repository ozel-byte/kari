import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewPaciente extends StatefulWidget {
  const ViewPaciente({super.key});

  @override
  State<ViewPaciente> createState() => _ViewPacienteState();
}

class _ViewPacienteState extends State<ViewPaciente> {
  final ref = FirebaseFirestore.instance.collection("Paciente");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_rounded,color: Colors.grey,)),
        title: const TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 5),
            hintText: "Buscar paciente",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey)
          ),
        ),

      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_pin),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 400,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Informacion",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Actividad Fisica: ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              .get("fisica"))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Antecedentes Heredofamiliares: ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              .get("antecedentes"))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Antecedentes personales Patologicos: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              snapshot.data!.docs[index].get("app"))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Peso: ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              .get("peso"))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Profesion: ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(snapshot.data!.docs[index]
                                              .get("profesion"))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Padecimiento Actual: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data!.docs[index].get("pa"))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "ROM: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data!.docs[index].get("tamaño"))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Diametro: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data!.docs[index].get("diametro-muscular"))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Escala: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data!.docs[index].get("escala"))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      title: Text(snapshot.data!.docs[index].get("nombre")),
                      subtitle: Text("Precione para ver mas detalles")
                    ),
                    const Divider(
                      indent: 70,
                      height: 0,
                      color: Colors.grey,
                    ),
                  ],
                );
                // return ExpansionTile(
                //   leading: Icon(Icons.person),
                //   title: Text(snapshot.data!.docs[index].get("nombre")),
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text("Informacion",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                //           SizedBox(height: 20,),
                //           ListTile(
                //             leading: Icon(Icons.run_circle_outlined),
                //             title: Text("Edad:"),
                //             trailing: Text(snapshot.data!.docs[index].get("edad")+" años"),
                //           ),
                //             Text("Edad: ${snapshot.data!.docs[index].get("edad")}"),
                //             Text("Actividad Fisica: ${snapshot.data!.docs[index].get("fisica")}"),
                //             Text("Antecedentes Heredofamiliares: ${snapshot.data!.docs[index].get("antecedentes")}"),
                //             Text("Antecedentes personales Patologicos: ${snapshot.data!.docs[index].get("app")}"),

                //             Text("Peso: ${snapshot.data!.docs[index].get("peso")}"),
                //             Text("Profesion: ${snapshot.data!.docs[index].get("profesion")}"),
                //             Text("Padecimiento Actual: ${snapshot.data!.docs[index].get("pa")}"),
                //           SizedBox(height: 20,),

                //       ],
                //     )
                //   ],
                // );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
