import 'package:bioappmikary/pages/src/deletePaciente/deletePaciente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class SearchPaciente extends StatefulWidget {
  const SearchPaciente({super.key});

  @override
  State<SearchPaciente> createState() => _SearchPacienteState();
}

class _SearchPacienteState extends State<SearchPaciente> {
   final ref = FirebaseFirestore.instance.collection("Paciente");
   String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
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
                    
                     leading: Icon(Icons.person),
                    title: Text(paciente["data"]["nombre"]),
                    trailing: IconButton(onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Desea eliminar este paciente?"),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red)
                              ),
                              onPressed: (){
                                ref.doc(paciente["id"])
                                .delete()
                                .then((value) => {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se elimino el paciente"))),
                                  Navigator.pop(context)
                                });
                              }, child: Text("Eliminar",style: TextStyle(color: Colors.white),))
                          ],
                        )),

                        );
                    },icon: Icon(Icons.restore_from_trash)),
                  );

                }
                // print(data["nombre"].toString().contains(name.toLowerCase()));
                print(name);
                if (paciente["data"]["nombre"].toString().toLowerCase().contains(name)) {
                   return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(paciente["data"]["nombre"]),
                    trailing: IconButton(onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Desea eliminar este paciente?"),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red)
                              ),
                              onPressed: (){
                                ref.doc(paciente["id"])
                                .delete()
                                .then((value) => {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se elimino el paciente"))),
                                  Navigator.pop(context)
                                });
                              }, child: Text("Eliminar",style: TextStyle(color: Colors.white),))
                          ],
                        )),

                        );
                    }, icon: Icon(Icons.restore_from_trash)),
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