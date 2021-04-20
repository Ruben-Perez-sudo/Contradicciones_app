import 'package:flutter/material.dart';
import 'package:contradicciones/Perfil.dart';
import 'package:contradicciones/models/Qr.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List items;

  @override
  void initState() {
    super.initState();
    items = [
      {
        'icon': Icons.person,
        'title': 'Perfil',
        'function': () => _pushPage(Perfil()),
      },
      {
        'icon': Icons.qr_code,
        'title': 'QR',
        'function': () => _pushPage(QR()),
      },
      {
        'icon': Icons.admin_panel_settings,
        'title': 'Terminos y Condiciones',
        'function': () => (showAbout()),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: items[index]['function'],
            leading: Icon(
              items[index]['icon'],
            ),
            title: Text(
              items[index]['title'],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
  _pushPage(Widget page) {
    MyRouter.pushPage(context, page);
  }
  showAbout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'Contradicciones.S.A',
          ),
          content: Text(
            'Cuando empieces a vender productos o a prestar servicios por internet, deberás informar a tus clientes de tus condiciones generales de uso. Debe constar en tu página web, las reglas que van a regular la relación con los usuarios que deben conocer cuáles son tus responsabilidades como empresario y cuáles son sus derechos y obligaciones por acceder a los contenidos y utilizar los servicios que ofrece la web.',
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.red,
              onPressed: () =>  {
               Navigator.of(context).pop()},
              child: Text(
                'Cerrar',
              ),
            ),
          ],
        );
      },
    );
  }
}
class MyRouter {
  static Future pushPage(BuildContext context, Widget page) {
    var val = Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
    return val;
  }
}

