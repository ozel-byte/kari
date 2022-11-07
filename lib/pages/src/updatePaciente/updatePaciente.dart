import 'package:bioappmikary/pages/src/updatePaciente/viewUpdate.dart';
import 'package:bioappmikary/pages/src/viewPaciente/viewPaciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




class UpdatePaciente extends StatefulWidget {
  const UpdatePaciente({super.key});

  @override
  State<UpdatePaciente> createState() => _UpdatePacienteState();
}

class _UpdatePacienteState extends State<UpdatePaciente> {
  
  final ref = FirebaseFirestore.instance.collection("Paciente");
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search..."
            ),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Paciente").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting) ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String,dynamic> paciente = {
                  "id": snapshot.data!.docs[index].id,
                  "data": snapshot.data!.docs[index].data() as Map<String,dynamic>
                };
                if (name.isEmpty) {
                  return ListTile(
                     onTap: () {
                      print(paciente);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ViewUpdate(paciente: paciente,);
                      },));
                    },
                    leading: Icon(Icons.person),
                    title: Text(paciente["data"]["nombre"]),
                  );

                }
                // print(data["nombre"].toString().contains(name.toLowerCase()));
                print(name);
                if (paciente["data"]["nombre"].toString().toLowerCase().contains(name)) {
                   return ListTile(
                    onTap: () {
                      print(paciente);
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ViewUpdate(paciente: paciente,);
                      },));
                    },
                    title: Text(paciente["data"]["nombre"]),
                  );
                }
                return Container();
              },
              
            );
          
        },
      ),
    );
  }
}