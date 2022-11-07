import 'package:bioappmikary/pages/src/agregarPaciente/agregarPaciente.dart';
import 'package:bioappmikary/pages/src/deletePaciente/searchPaciente.dart';
import 'package:bioappmikary/pages/src/updatePaciente/updatePaciente.dart';
import 'package:bioappmikary/pages/src/viewPaciente/viewPaciente.dart';
import 'package:flutter/material.dart';




class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  double sizeBottomModal = 400;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Menu"),
        centerTitle: true,
        leading: Icon(Icons.local_hospital),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AgregarPaciente();
                },
                )
                );
            },
            leading: Icon(Icons.person_add),
            title: Text("Agregar Paciente"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPaciente();
              },));
            },
            leading: Icon(Icons.delete),
            title: Text("Eliminar Paciente"),
            trailing: Icon(Icons.arrow_forward_ios),

          ),
          ListTile(
            onTap: () {
              
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdatePaciente();
              },));
            },
            leading: Icon(Icons.update),
            title: Text("Modificar datos del paciente"),
            trailing: Icon(Icons.arrow_forward_ios),

          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ViewPaciente();
              },));
            },
            leading: Icon(Icons.person),
            title: Text("Ver Pacientes"),
            trailing: Icon(Icons.arrow_forward_ios),

          )
        ],
      ),
    );
  }
}