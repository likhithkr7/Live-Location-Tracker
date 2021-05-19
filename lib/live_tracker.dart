import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:trackit/Data.dart';
import 'package:trackit/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(new MaterialApp(home: new Scaffold(body: new Page2())));

class Page2 extends StatefulWidget {
  @override
  final Data data;
  Page2({this.data});
  _Page2State createState() => _Page2State(data: data);
}

class _Page2State extends State<Page2> {
  final Data data;
  _Page2State({this.data});
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  static double lat, long;
  final database = FirebaseDatabase.instance.reference();

  void initState() {
    _getThingsOnStart().then((value) {});
    super.initState();
  }

  Future _getThingsOnStart() async {
    await usersRef.once().then((DataSnapshot snapshot) {
      lat = snapshot.value[data.id]["lat"];
      long = snapshot.value[data.id]["lng"];
    });
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(lat, long),
    zoom: 14.46746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updatePin(double lat, double long, Uint8List imageData) {
    LatLng latLng = LatLng(lat, long);
    print("latitude = $lat longitude = $long");
    this.setState(() {
      marker = Marker(
        markerId: MarkerId('home'),
        position: latLng,
        // rotation: 1,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData),
      );
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      // updateMarkerAndCircle(lat, long, imageData);
      // _controller.animateCamera(CameraUpdate.newCameraPosition(
      //     new CameraPosition(
      //         bearing: 192.8334901395799,
      //         target: LatLng(lat, long),
      //         tilt: 0,
      //         zoom: 18.00)));
      double new_lat, new_long;
      // database
      //     .child('trackit-f1692-default-rtdb')
      //     .child('users')
      //     .child('X1K5UZNL6idgrEvpoRLt9XMSing1')
      //     .onValue
      //     .listen((event) {
      //   var snapshot = event.snapshot;
      //   new_lat = snapshot.value["lat"];
      //   new_long = snapshot.value["lng"];
      //   _controller.animateCamera(CameraUpdate.newCameraPosition(
      //       new CameraPosition(
      //           bearing: 192.8334901395799,
      //           target: LatLng(lat, long),
      //           tilt: 0,
      //           zoom: 18.00)));
      //   updateMarkerAndCircle(new_lat, new_long, imageData);
      // });
      while (true) {
        await Future.delayed(Duration(seconds: 5));
        await usersRef.once().then((DataSnapshot snapshot) {
          new_lat = snapshot.value[data.id]["lat"];
          new_long = snapshot.value[data.id]["lng"];
        });
        updatePin(new_lat, new_long, imageData);
        _controller.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(new_lat, new_long),
                tilt: 0,
                zoom: 18.00)));
      }
    } on PlatformException catch (e) {
      debugPrint(e.code);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live tracker'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () {
          getCurrentLocation();
        },
      ),
    );
  }
}
