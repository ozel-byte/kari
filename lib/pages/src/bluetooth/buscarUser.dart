import 'package:bioappmikary/pages/src/bluetoo/bluetooth.dart';
import 'package:bioappmikary/pages/src/bluetooth/bluetoothv2.dart';
import 'package:bioappmikary/pages/src/updatePaciente/viewUpdate.dart';
import 'package:bioappmikary/pages/src/viewPaciente/viewPaciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';




class BuscarUser extends StatefulWidget {
  const BuscarUser({super.key});

  @override
  State<BuscarUser> createState() => _BuscarUserState();
}

class _BuscarUserState extends State<BuscarUser> {
  
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
                        return BluetoothExistUser(
                          user: paciente,
                        );
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
                        return BluetoothExistUser(
                          user: paciente,
                        );
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