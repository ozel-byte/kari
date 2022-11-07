import 'package:bioappmikary/pages/src/menu/menu.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() {
      return Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Menu();
      },));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenidos",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            Text("Care muscle",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red[300])),
            SizedBox(height: 30,),
            CircularProgressIndicator(color: Colors.red,)
          ],
        ),
      ),
    );
  }
}