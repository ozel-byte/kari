import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchCita extends StatefulWidget {
  const SearchCita({super.key});

  @override
  State<SearchCita> createState() => _SearchCitaState();
}

class _SearchCitaState extends State<SearchCita> {
  String name = "";
  final ref_cita = FirebaseFirestore.instance.collection("Cita");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: TextField(
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
          decoration: InputDecoration(
            hintText: "Buscar cita",
            border: InputBorder.none
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Cita").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : lista(snapshot);
        },
      ),
    );
  }

  ListView lista(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> paciente = {
          "id": snapshot.data!.docs[index].id,
          "data": snapshot.data!.docs[index].data() as Map<String, dynamic>
        };
        if (name.isEmpty) {
          return ListTile(
            onTap: () {
              print(paciente);
            },
            leading: Icon(Icons.person),
            title: Text(paciente["data"]["nombre"]),
            subtitle: Text(paciente["data"]["fecha"]),
            trailing: IconButton(
              onPressed: (){
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
                                ref_cita.doc(snapshot.data!.docs[index].id)
                                .delete()
                                .then((value) => {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se elimino el paciente"))),
                                  Navigator.pop(context)
                                });
                              }, child: Text("Eliminar",style: TextStyle(color: Colors.white),))
                          ],
                        )),

                        );
              }, 
              icon: Icon(Icons.delete)),
          );
        }
        // print(data["nombre"].toString().contains(name.toLowerCase()));
        print(name);
        if (paciente["data"]["nombre"]
            .toString()
            .toLowerCase()
            .contains(name)) {
          return ListTile(
            onTap: () {
              print(paciente);
            },
            leading: const Icon(Icons.person),
            title: Text(paciente["data"]["nombre"]),
            subtitle: Text(paciente["data"]["fecha"]),
            
          );
        }
        return Container();
      },
    );
  }
}
