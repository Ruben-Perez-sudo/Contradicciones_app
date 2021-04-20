import 'package:contradicciones/models/Qr.dart';
import 'package:flutter/material.dart';
import 'package:contradicciones/Log_in.dart';

class Perfil extends StatefulWidget{
  @override
  _Perfil createState()=> new _Perfil();
}

class _Perfil extends State<Perfil>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          ClipPath(
            child:Container(
              color: Colors.red.withOpacity(0.8)
            ),
            clipper:getClipper(),
          ),
          Positioned(
            width:360.0,
            top: MediaQuery.of(context).size.height/5,
            child: Column(
              children: <Widget>[
                Container(
                  width: 175.0,
                  height: 170.0,
                  decoration: BoxDecoration(
                    color:Colors.red,
                    image: DecorationImage(//IMAGEN DE API
                      image: NetworkImage('https://cdn.pixabay.com/photo/2018/05/01/16/19/young-man-3366016_960_720.jpg'),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(75.0)
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 7.0, color: Colors.black)
                    ]
                  ),
                ),
                SizedBox(height:80.0),
                Text(
                  'Ruben@gmail.com',//TEXTO API
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    color: Colors.red
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Paleta, Barcelona/Cataluña',//TEXTO API
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      color: Colors.black
                ),
                ),
                SizedBox(height: 25.0),
                Container(
                    height: 30.0,
                    width:95.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.transparent
                      ,
                      color: Colors.redAccent,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: (){Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => login() ));
                        },
                        child: Center(
                          child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),

                          ),
                        ),
                      ),
                    )
                )
              ],
            )
          )
        ]
      )
    );
  }
}
class getClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = new Path();
    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125,0.0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return true;
  }
}