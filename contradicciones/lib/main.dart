import 'dart:convert';
import 'package:contradicciones/Log_in.dart';
import 'package:contradicciones/Menu_principal.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:http/http.dart' as http;
import 'package:contradicciones/models/API.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Future<List<Usuarios>> _listadoUsuarios;
  Future<List<Usuarios>> _getUsuarios() async{
    final respuesta = await http.get("http://contradicciones.gearhostpreview.com/api/usuarios");
    List<Usuarios> usuarios = [];

    if(respuesta.statusCode == 200){
      final jsonData = jsonDecode(respuesta.body);

      usuarios = jsonData.map((item)=>Usuarios.fromJson(item)).toList().cast<Usuarios>();
      for(var item in usuarios){
        debugPrint (item.Usuario +"-----" + item.Contrasena);
      }

      return usuarios;
    }else{
      throw Exception("Fallo de conexión");
    }
  }
  @override
  initState(){
    super.initState();
    _listadoUsuarios = _getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    Widget example2 = SplashScreenView(
      home: login(),
      duration: 5000,
      imageSize: 300,
      imageSrc: 'assets/Contradicc.png',
      text: "CONTRADICCIONES",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.red,
        Colors.white,
      ],
      backgroundColor: Colors.white,
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Splash screen Demo',
        home: example2,
    );
  }
}

