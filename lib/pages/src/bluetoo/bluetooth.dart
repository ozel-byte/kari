import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class Bluetooth extends StatefulWidget {
  Map<String, dynamic>? paciente;
   Bluetooth({super.key,this.paciente});

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {

  bool statusConected = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff64B2FC),
        elevation: 0.0,
        title: Text(widget.paciente!["id"]),
      ),
      body: 
      statusConected ? Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff64B2FC),
              Color(0xff2B83FF)
            ],
            begin:Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: size.height*0.15,
              left: size.width*0.25,
              child: Text("Buscando dispositivos..",style: TextStyle(color: Colors.white,fontSize: 18),)),
            ZoomIn(
              duration: Duration(milliseconds: 2000),
              controller: (p0) {
                p0.addStatusListener((status) { 
                  if (status == AnimationStatus.completed) {
                    p0.reverse();
                    
                  }
                  
                   if (status == AnimationStatus.dismissed) {
                    p0.forward();
                  }
                });
              },
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 138, 176, 212),
            
                    borderRadius: BorderRadius.circular(100)
                  ),
                ),
              ),
            ),
            ZoomIn(
              duration: Duration(milliseconds: 3000),
              controller: (p0) {
                p0.addStatusListener((status) { 
                   if (status == AnimationStatus.completed) {
                    p0.reverse();
                    
                  }
                  
                   if (status == AnimationStatus.dismissed) {
                    p0.forward();
                  }
                });
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(139, 142, 193, 240),
            
                    borderRadius: BorderRadius.circular(200)
                  ),
                ),
              ),
            ),
            ZoomIn(
              duration: Duration(milliseconds: 4000),
              controller: (p0) {
                p0.addStatusListener((status) { 
                   if (status == AnimationStatus.completed) {
                    p0.reverse();
                    
                  }
                  
                   if (status == AnimationStatus.dismissed) {
                    p0.forward();
                  }
                });
              },
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(82, 100, 179, 252),
                   
                    borderRadius: BorderRadius.circular(300)
                  ),
                ),
              ),
            ),
            Center(child: Icon(Icons.bluetooth,color: Colors.white,size: 60,))
          ],
        ),
      ):
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image(image: AssetImage("assets/logo.png")),
            Text("Dispositivo conectado"),
            Text("Precione para desconectar",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
            Switch(value: false, onChanged: (value) {
              
            },)
          ],
        ),
      ),
    );
  }
}