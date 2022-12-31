import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class HomeGrafic extends StatefulWidget {
  String? id;
  HomeGrafic({super.key, this.id});

  @override
  State<HomeGrafic> createState() => _HomeGraficState();
}

class _HomeGraficState extends State<HomeGrafic> {
  List<Map<String, dynamic>> listaCitasDiametro = [];
  List<Map<String, dynamic>> listaCitasEscala = [];
  List<Map<String, dynamic>> listaCitasROM = [];
  final ref_cita = FirebaseFirestore.instance.collection("Cita");

  @override
  void initState() {
    super.initState();
  }

  getCitas() {
    ref_cita.get().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            if (widget.id == element.data()["id"]) {
              print(element.get("fecha").toString().split("/")[0]);
              listaCitasDiametro.add({
                "domain": element.get("fecha").toString().split("/")[0],
                "measure": element.get("diametro")
              });
              listaCitasEscala.add(element.get("escala"));
              listaCitasROM.add(element.get("rom"));
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Graficas de citas"),
      ),
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.3,
            child: Column(
              children: [
                Text("Diametro"),
                Expanded(
                    child: StreamBuilder(
                  stream: ref_cita.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      snapshot.data!.docs.forEach((element) {
                        if (widget.id == element.get("id").toString()) {
                          listaCitasDiametro.add({
                            'domain':
                                int.parse(element.get("fecha").toString().split("-")[2]),
                            'measure': int.parse(element.get("diametro"))
                          });
                        }
                      });
                      print(listaCitasDiametro);
                      return DChartLine(
                        data: [
                          {'id': 'Line', 'data': listaCitasDiametro},
                        ],
                        lineColor: (lineData, index, id) => Colors.amber,
                        
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
                ),
              ],
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.3,
            child: Column(
              children: [
                Text("Escala"),
                Expanded(
                  child: StreamBuilder(
                  stream: ref_cita.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      snapshot.data!.docs.forEach((element) {
                        if (widget.id == element.get("id").toString()) {
                          listaCitasEscala.add({
                            'domain':
                                int.parse(element.get("fecha").toString().split("-")[2]),
                            'measure': int.parse(element.get("escala"))
                          });
                        }
                      });
                      return DChartLine(
                        data: [
                          {'id': 'Line', 'data': listaCitasEscala},
                        ],
                        lineColor: (lineData, index, id) => Colors.orange,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
                ),
              ],
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.295,
            child: Column(
              children: [
                Text("ROM"),
                Expanded(
                  child: StreamBuilder(
                  stream: ref_cita.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      snapshot.data!.docs.forEach((element) {
                        if (widget.id == element.get("id").toString()) {
                          listaCitasROM.add({
                            'domain':
                                int.parse(element.get("fecha").toString().split("-")[2]),
                            'measure': int.parse(element.get("rom"))
                          });
                        }
                      });
                      return DChartLine(
                        data: [
                          {'id': 'Line', 'data': listaCitasROM},
                        ],
                        lineColor: (lineData, index, id) => Colors.pink,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
