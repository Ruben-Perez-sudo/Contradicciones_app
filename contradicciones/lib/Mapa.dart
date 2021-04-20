import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mapa extends StatefulWidget {
  @override
  _Mapa createState() => _Mapa();
}

class _Mapa extends State<Mapa> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }
  double zoomVal=5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(child:Text("Barcelona")
          ,),

        actions: <Widget>[
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {

    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus,color:Colors.redAccent),
          onPressed: () {
            zoomVal--;
            _menos_zoom( zoomVal);
          }),
    );
  }
  Widget _zoomplusfunction() {

    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus,color:Colors.redAccent),
          onPressed: () {
            zoomVal++;
            _mas_zoom(zoomVal);
          }),
    );
  }

  Future<void> _menos_zoom(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(41.397380, 2.138026), zoom: zoomVal)));
  }
  Future<void> _mas_zoom(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(41.397380, 2.138026), zoom: zoomVal)));
  }


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?panoid=vxdiw92RO2C8GYrGY4l5gg&cb_client=search.gws-prod.gps&w=408&h=240&yaw=142.92526&pitch=0&thumbfov=100",
                  41.400531, 2.143535,"FEFOC"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipP0xOB5gLAQTg5_eoN1GnY41M9YUDnaAoLjVqc3=w234-h144-p-k-no",
                  41.394759, 2.122142,"Azul Desintoxicación"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?panoid=mCXYQcRnsIPxZu8gYusM_Q&cb_client=search.gws-prod.gps&w=408&h=240&yaw=301.36264&pitch=0&thumbfov=100",
                  41.393431, 2.126682,"DESPIERTA - Centro de desintoxicación"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipP6mnNFtIA0EgcIEacec7OwJT2bMudiGEu0CY8x=w408-h272-k-no",
                  41.387573, 2.143933,"TAVAD - CENTRO DE DESINTOXICACIÓN"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipPcGYwJLY8iXu2xc5bUMY1y4VN5CntQU7LEBSgW=w408-h306-k-no",
                  41.384402, 2.152955,"ORBIUM. Centro de tratamiento de adicciones"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMmDoOckSQ45sZNW-t_l4txf-bMBmo4bi8fXVN8=w408-h306-k-no",
                  41.385775, 2.141589,"FSYC"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipPnhjMoxr6ThsnsJKScEndVvE8HR_BgoyxOiewP=w532-h240-k-no",
                  41.387014, 2.156146,"Centro Aroboros"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String centro) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(centro),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String centro) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(centro,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.5",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStarHalf,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(946)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "C.Desintoxicació \u00B7 \u0024\u0024 \u00B7 1.8 km",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Cierra a las \u00B7 abre 17:00 Lun",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(41.397380, 2.138026), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          bcn1Marker,bcn2Marker,bcn3Marker,bcn4Marker,bcn5Marker,gramercyMarker,bernardinMarker,blueMarker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}

Marker gramercyMarker = Marker(
  markerId: MarkerId('FEFOC'),
  position: LatLng(41.400531, 2.143535),
  infoWindow: InfoWindow(title: 'FEFOC'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('Azul Desintoxicación'),
  position: LatLng(41.394759, 2.122142),
  infoWindow: InfoWindow(title: 'Azul Desintoxicación'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('Despierta'),
  position: LatLng(41.393431, 2.126682),
  infoWindow: InfoWindow(title: 'DESPIERTA'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);

//New York Marker

Marker bcn1Marker = Marker(
  markerId: MarkerId('tavad'),
  position: LatLng(41.387573, 2.143933),
  infoWindow: InfoWindow(title: 'TAVAD'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
Marker bcn2Marker = Marker(
  markerId: MarkerId('orvium'),
  position: LatLng(41.384402, 2.152955),
  infoWindow: InfoWindow(title: 'ORVIUM'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
Marker bcn3Marker = Marker(
  markerId: MarkerId('Ana Sabaté'),
  position: LatLng(41.382434, 2.151186),
  infoWindow: InfoWindow(title: 'Ana Sabaté'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),

);
Marker bcn4Marker = Marker(
markerId: MarkerId('FSYC'),
position: LatLng(41.385775, 2.141589),
infoWindow: InfoWindow(title: 'FSYC'),
icon: BitmapDescriptor.defaultMarkerWithHue(
BitmapDescriptor.hueRed,
),
);
Marker bcn5Marker = Marker(
  markerId: MarkerId('C.Arobros'),
  position: LatLng(41.387014, 2.156146),
  infoWindow: InfoWindow(title: 'Arobros'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);