import 'package:bioappmikary/pages/src/agregarPaciente/agregarPaciente.dart';
import 'package:bioappmikary/pages/src/bluetoo/bluetooth.dart';
import 'package:bioappmikary/pages/src/bluetooth/buscarUser.dart';
import 'package:bioappmikary/pages/src/deletePaciente/searchPaciente.dart';
import 'package:bioappmikary/pages/src/menu/searchCita.dart';
import 'package:bioappmikary/pages/src/menu/searchUserGrafic.dart';
import 'package:bioappmikary/pages/src/updatePaciente/updatePaciente.dart';
import 'package:bioappmikary/pages/src/viewPaciente/viewPaciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final ref_cita = FirebaseFirestore.instance.collection("Cita");
  double sizeBottomModal = 400;
  String name = "";
  bool activeDelete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Color(0xff36ADE2),
          elevation: 0.0,
          title: const Text(
            "Hola, Bienvenido!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: const Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/13336772/pexels-photo-13336772.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.45,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Citas",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue),
                      ),
                    ),
                    ListTile(
                        leading: Icon(Icons.all_inbox_outlined),
                        title: Text("Total de citas"),
                        trailing: StreamBuilder(
                          stream: ref_cita.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.size.toString(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        )),
                    const Divider(
                      indent: 70,
                      height: 0,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                              height: 600,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      width: size.width,
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.all(20),
                                            border: InputBorder.none,
                                            hintText: "Buscar Cita",
                                            suffixIcon: Icon(Icons.search)),
                                      ),
                                    ),
                                    Divider(),
                                    Container(
                                      width: size.width,
                                      height: size.height,
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("Cita")
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return (snapshot.connectionState ==
                                                  ConnectionState.waiting)
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : ListView.builder(
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    Map<String, dynamic>
                                                        paciente = {
                                                      "id": snapshot
                                                          .data!.docs[index].id,
                                                      "data": snapshot
                                                              .data!.docs[index]
                                                              .data()
                                                          as Map<String,
                                                              dynamic>
                                                    };
                                                    if (name.isEmpty) {
                                                      return ListTile(
                                                        onTap: () {
                                                          print(paciente);
                                                        },
                                                        leading:
                                                            Icon(Icons.person),
                                                        title: Text(
                                                            paciente["data"]
                                                                ["nombre"]),
                                                        subtitle: Text(
                                                            paciente["data"]
                                                                ["fecha"]),
                                                      );
                                                    }
                                                    // print(data["nombre"].toString().contains(name.toLowerCase()));
                                                    print(name);
                                                    if (paciente["data"]
                                                            ["nombre"]
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(name)) {
                                                      return ListTile(
                                                        onTap: () {
                                                          print(paciente);
                                                        },
                                                        leading: const Icon(
                                                            Icons.person),
                                                        title: Text(
                                                            paciente["data"]
                                                                ["nombre"]),
                                                        subtitle: Text(
                                                            paciente["data"]
                                                                ["fecha"]),
                                                      );
                                                    }
                                                    return Container();
                                                  },
                                                );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const ListTile(
                        leading: Icon(Icons.scoreboard_sharp),
                        title: Text("Ver citas"),
                        subtitle:
                            Text("Precione para visulaizar todas las citas"),
                        trailing: Icon(Icons.search),
                      ),
                    ),
                    Divider(
                      indent: 70,
                      height: 0,
                      color: Colors.grey,
                    ),
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return AgregarPaciente();
                                          },
                                        ));
                                      },
                                      leading: Icon(Icons.co_present_outlined),
                                      title: Text("¿Usuario Nuevo?"),
                                      subtitle: Text(
                                          "Precione para crear un nuevo usuario"),
                                    ),
                                    const Divider(
                                      indent: 70,
                                      height: 0,
                                      color: Colors.grey,
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return BuscarUser();
                                          },
                                        ));
                                      },
                                      leading: Icon(Icons.person_outline),
                                      title: Text("Usuario Existente"),
                                      subtitle: Text(
                                          "Precione para empezar a monitoriar"),
                                    ),
                                  ],
                                ));
                          },
                        );
                      },
                      leading: Icon(Icons.person_add_alt),
                      title: Text("Agregar cita"),
                      subtitle: Text("Precione para agregar una nueva cita"),
                    ),
                    Divider(
                      indent: 70,
                      height: 0,
                      color: Colors.grey,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return SearchCita();
                        },));
                      },
                      leading: Icon(Icons.delete_outline),
                      title: Text("Eliminar cita"),
                    ),
                    Divider(
                      indent: 70,
                      height: 0,
                      color: Colors.grey,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SearchUserGrafic();
                          },
                        ));
                      },
                      leading: Icon(Icons.bar_chart),
                      title: Text("Visualizar graficas"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                height: size.height * 0.4,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Text(
                        "Pacientes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ViewPaciente();
                            },
                          ));
                        },
                        leading: Icon(Icons.person_search_outlined),
                        title: Text("Visualizar pacientes"),
                        subtitle: Text("Con sus graficas"),
                      ),
                    ),
                    const Divider(
                      indent: 70,
                      height: 0,
                      color: Colors.grey,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return UpdatePaciente();
                          },
                        ));
                      },
                      leading: Icon(Icons.file_upload_outlined),
                      title: Text("Actualizar datos del paciente"),
                    ),
                    Divider(
                      indent: 70,
                      height: 0,
                      color: Colors.grey,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SearchPaciente();
                          },
                        ));
                      },
                      leading: Icon(Icons.delete_outline_rounded),
                      title: Text("Eliminar paciente"),
                    ),
                  ],
                ),
              )
            ],
          ),
        )

        // ListView(
        //   children: [
        //   const  Padding(
        //       padding: const EdgeInsets.only(left: 20, top: 20),
        //       child: Text(
        //         "Total de citas:",
        //         style: TextStyle(
        //             color: Color(0xff30241D),
        //             fontWeight: FontWeight.bold,
        //             fontSize: 25),
        //       ),
        //     ),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     Row(
        //       children: const [
        //         SizedBox(
        //           width: 20,
        //         ),
        //         Icon(
        //           Icons.schedule,
        //           color: Colors.brown,
        //         ),
        //         Text(" 10 citas",
        //             style: TextStyle(color: Color(0xff59544C), fontSize: 25)),
        //       ],
        //     ),
        //     SizedBox(height: 20,),

        //     Padding(
        //       padding:  EdgeInsets.only(top: size.height*0.02),
        //       child: Container(
        //           height: size.height*0.57,
        //           decoration:  BoxDecoration(
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               blurRadius: 2,
        //               spreadRadius: 2,
        //               color: Colors.grey.withOpacity(0.1)
        //             )
        //           ],

        //           ),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //             const  Padding(
        //                 padding: const EdgeInsets.only(left: 20,top: 20),
        //                 child: Text("Paciente",style: TextStyle(color: Color(0xff443B33),fontSize: 20,fontWeight: FontWeight.bold),),
        //               ),
        //              const SizedBox(
        //                 height: 10,
        //               ),
        //               ListTile(
        //       onTap: () {
        //         Navigator.push(context, MaterialPageRoute(
        //           builder: (context) {
        //             return AgregarPaciente();
        //           },
        //         ));
        //       },
        //       leading: Icon(Icons.person_add),
        //       title: Text("Agregar Paciente"),
        //       trailing: Icon(Icons.arrow_forward_ios),
        //     ),
        //     Divider(),
        //     ListTile(
        //       onTap: () {
        //         Navigator.push(context, MaterialPageRoute(
        //           builder: (context) {
        //             return SearchPaciente();
        //           },
        //         ));
        //       },
        //       leading: Icon(Icons.delete),
        //       title: Text("Eliminar Paciente"),
        //       trailing: Icon(Icons.arrow_forward_ios),
        //     ),
        //     Divider(),
        //     ListTile(
        //       onTap: () {
        //         Navigator.push(context, MaterialPageRoute(
        //           builder: (context) {
        //             return UpdatePaciente();
        //           },
        //         ));
        //       },
        //       leading: Icon(Icons.update),
        //       title: Text("Modificar datos del paciente"),
        //       trailing: Icon(Icons.arrow_forward_ios),
        //     ),
        //     Divider(),
        //     ListTile(
        //       onTap: () {
        //         Navigator.push(context, MaterialPageRoute(
        //           builder: (context) {
        //             return ViewPaciente();
        //           },
        //         ));
        //       },
        //       leading: Icon(Icons.person),
        //       title: Text("Ver Pacientes"),
        //       trailing: Icon(Icons.arrow_forward_ios),
        //     ),
        //               SizedBox(height: size.height*0.05,),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Container(
        //                     width: size.width*0.8,
        //                     height: size.height*0.06,
        //                     decoration: BoxDecoration(
        //                     color: Color(0xffFFE7AB),
        //                     borderRadius: BorderRadius.circular(10)
        //                     ),
        //                     child: Center(child: Text("Agregar cita",style: TextStyle(color: Color(0xff443B33),fontSize: 18,fontWeight: FontWeight.bold))),
        //                   ),
        //                 ],
        //               )
        //             ],
        //           ),
        //         ),
        //     ),

        //   ],
        // ),
        );
  }

  
}
