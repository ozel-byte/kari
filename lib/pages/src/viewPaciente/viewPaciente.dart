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
        title: Text("Pacientes"),
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
             if (snapshot.hasData) {
               return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    leading: Icon(Icons.person),
                    title: Text(snapshot.data!.docs[index].get("nombre")),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            SizedBox(height: 20,),
                              Text("Edad: ${snapshot.data!.docs[index].get("edad")}"),
                              Text("Actividad Fisica: ${snapshot.data!.docs[index].get("fisica")}"),
                              Text("Antecedentes Heredofamiliares: ${snapshot.data!.docs[index].get("antecedentes")}"),
                              Text("Antecedentes personales Patologicos: ${snapshot.data!.docs[index].get("app")}"),

                              Text("Peso: ${snapshot.data!.docs[index].get("peso")}"),
                              Text("Profesion: ${snapshot.data!.docs[index].get("profesion")}"),
                              Text("Padecimiento Actual: ${snapshot.data!.docs[index].get("pa")}"),
                            SizedBox(height: 20,),
                          
                         
                        ],
                      )
                    ],
                  );
                },
               );
             }else{
              return Center(
                child: CircularProgressIndicator(

                ),
              );
             }
           },
      ),
    );
  }
}