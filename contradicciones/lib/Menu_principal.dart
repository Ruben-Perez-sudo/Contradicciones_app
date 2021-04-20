import 'dart:math';
import 'package:contradicciones/Blog.dart';
import 'package:contradicciones/Log_in.dart';
import 'package:contradicciones/Mapa.dart';
import 'package:contradicciones/Perfil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contradicciones/Ajustes.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:contradicciones/models/Network.dart';
import 'package:flutter/widgets.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webfeed/webfeed.dart';


class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}
class _MenuState extends State<Menu>{
  int _indexactual = 0;

  final List<Widget> _children = [
    Perfil(),
    Blog(),
    Menu_Principal(),
    Mapa(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:_children[_indexactual],
        bottomNavigationBar: ConvexAppBar(
          color: Colors.white,
          backgroundColor: Colors.red,
          items: [
            TabItem(icon: Icons.person_outlined, title: 'Perfil'),
            TabItem(icon: Icons.message, title: 'Blog'),
            TabItem(icon: Icons.home, title: 'Menú'),
            TabItem(icon: Icons.map, title: 'Mapa'),
            TabItem(icon: Icons.settings, title: 'Ajustes'),
          ],

          initialActiveIndex: 0,//optional, default as 0
          onTap: onTabTapped,
        ),

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("CONTRADICCIONES"),
        centerTitle: true,
        actions: <Widget>[
          Image.asset(
              "assets/Contradicc.png"
          ),
        ],
      ),
    );
  }
  void onTabTapped(int index){
    setState(() {
    _indexactual = index;
  });
  }
}


class Fondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/fondo.jpg"), fit: BoxFit.cover),
      ),
      child: Center(child: Image.asset("assets/Contradicc.png")),
    );
  }
}



const swatch_6 = Color(0xff09090a);
const swatch_7 = Color(0xff25255b);


class Menu_Principal extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case '/':
            builder =
                (BuildContext context) => MyHomePage();
            break;
          case '/show':
            var args = settings.arguments;
            if (args is RssItem) {
              builder = (BuildContext context) =>
                  ShowPage(
                    title: args.title,
                    content: args.content.value,
                  );
            }
            break;
        }

        return MaterialPageRoute(
            builder: builder,
            settings: settings
        );
      },
    );
  }
}

class ShowPage extends StatefulWidget {
  final String title;
  final String content;

  const ShowPage({Key key, this.title, this.content}) : super(key: key);

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.red.withOpacity(0.5),
        elevation: 0.0,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(widget.title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    var style = "<style>* { font-size: 15px !important;} img { width: 100% !important; height: auto !important;}</style>";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: WebView(
        initialUrl: Uri.dataFromString(
            style + widget.content, parameters: { 'charset': 'utf-8'},
            mimeType: 'text/html')
            .toString(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  ScrollController _controller;
  double backgroundHeight = 180.0;
  Future<RssFeed> future;

  @override
  void initState() {
    super.initState();

    future = getNews();

    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        backgroundHeight = max(
            0,
            180.0 - _controller.offset
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.5),
        elevation: 0.0,
        centerTitle: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 32.0),
          )
        ],
      ),

      body: _body(),

    );

  }

  Widget _body() {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<RssFeed> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');

            return Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: backgroundHeight,
                  color: Colors.red.withOpacity(0.5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: snapshot.data.items.length + 2,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                        );
                      }
                      if (index == 1) {
                        return _bigItem();
                      }

                      return _item(snapshot.data.items[index - 2]);
                    },
                  ),
                ),
              ],
            );
        }
        return null;
      },
    );
  }

  Widget _bigItem() {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Stack(

      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: (screenWidth - 64) * 3 / 5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Contradicc.png'),
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Icon(Icons.play_arrow,
            size: 40.0,
            color: swatch_7,
          ),
        )
      ],
    );
  }

  Widget _item(RssItem item) {
    var mediaUrl = _extractImage(item.content.value);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/show', arguments: item);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 42.0,
                          height: 42.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21.0),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(item.categories.first.value[0],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(item.categories.first.value,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(item.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(item.dc.creator,
                      style: TextStyle(
                        color: swatch_6,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              mediaUrl != null ? Container(
                width: 120,
                height: 120,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/Contradicc.jpg',
                  image: mediaUrl,
                  fit: BoxFit.cover,
                ),
              ) : SizedBox(width: 0.0)
            ],
          ),
        ),
      ),
    );
  }

  String _extractImage(String content) {
    RegExp regexp = RegExp('<img[^>]+src="([^">]+)"');

    Iterable<Match> matches = regexp.allMatches(content);

    if (matches.length > 0) {
      return matches.first.group(1);
    }

    return null;
  }
}
