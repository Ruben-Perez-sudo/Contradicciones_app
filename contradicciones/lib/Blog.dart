import 'package:contradicciones/models/Chat.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Blog extends StatefulWidget {
  @override
  pantalla_chat createState() => new pantalla_chat();
}

class pantalla_chat extends State<Blog> {
  @override
  Widget build(BuildContext context) {
   FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () => Blog(),
      child: const Icon(Icons.textsms_outlined, color: Colors.redAccent),
    );
    Widget notificationCircle(value) {
      return new Container(
        child: Center(
            child: new Text(
              value.toString(),
              style: TextStyle(color: Colors.white),
            )),
        width: 20.0,
        height: 20.0,
        decoration: new BoxDecoration(
          color: Theme
              .of(context)
              .accentColor,
          shape: BoxShape.rectangle,
        ),
      );
    }
    return new ListView.builder(
      itemCount: temporalData.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 5.0,
          ),
          new ListTile(
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: new NetworkImage(temporalData[i].avatar),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  temporalData[i].nombre,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  temporalData[i].hora,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: new Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      temporalData[i].mensaje,
                      style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
