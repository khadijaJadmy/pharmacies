import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'DistanceMatrix.dart';

class MapTwo extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// Starting point latitude
double _originLatitude = 6.5212402;
// Starting point longitude
double _originLongitude = 3.3679965;
// Destination latitude
double _destLatitude = 6.849660;
// Destination Longitude
double _destLongitude = 3.648190;
// Markers to show points on the map
Map<MarkerId, Marker> markers = {};

PolylinePoints polylinePoints = PolylinePoints();
Map<PolylineId, Polyline> polylines = {};

  GoogleMapController mapController;
  String adress_livreur;
  String adress_client;
  final Geolocator _geolocator = Geolocator();

  Position _currentPosition;
  String _currentAddress;
  bool isCalculated=false;

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  String _startAddress = '';
  String _destinationAddress = 'Ain sbaa casablanca';
  String _placeDistance;
  String _duree;

class _MyAppState extends State<MapTwo> {
  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();
  // Configure map position and zoom
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 9.4746,
  );

Widget _textField({
    TextEditingController controller,
    String label,
    String hint,
    String initialValue,
    double width,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextFormField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        // initialValue: initialValue,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey[400],
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue[300],
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }
  _getCurrentLocation() async {
    await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
      _getUserLocation();
    } catch (e) {
      print(e);
    }
  }
  void _getUserLocation() async {
    print("YOU ARE INSIDE GET CURRENT LOCATION");
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
// Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
var addresses = await Geocoder.local.findAddressesFromQuery(destinationAddressController.text);
Coordinates destinationCoordinates = addresses.first.coordinates;
Position startCoordinates=position;
    // print(position.latitude);print(position.longitude );
  
    var positionLat = startCoordinates.latitude;
    var positionLong = startCoordinates.longitude;

    var firstLat = destinationCoordinates.latitude;
    var firstLong = destinationCoordinates.longitude;
      print(positionLat); print(positionLong); print(firstLat); print(firstLong);

    setState(() {
       _originLatitude = startCoordinates.latitude;
// Starting point longitude
 _originLongitude =  startCoordinates.longitude;
// Destination latitude
 _destLatitude =  destinationCoordinates.latitude;
// Destination Longitude
 _destLongitude = destinationCoordinates.longitude;
    });
    List<dynamic> dataLogin = new List<dynamic>();  //AIzaSyBaZHYeXE_Bb8_sv7edLHQL_qVHQU-bhDk
    Dio dio = new Dio();
    Response response = await dio.get(
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&&origins=$positionLat,$positionLong&destinations=$firstLat,$firstLong&key=AIzaSyBaZHYeXE_Bb8_sv7edLHQL_qVHQU-bhDk");
    print(response.data);
    print(response.statusCode);
    var _jsonEncode = json.encode(response.data);
    var _jsonDecode = json.decode(_jsonEncode);
    DistanceMatrix distanceMatrix;
    distanceMatrix = new DistanceMatrix.fromJson(json.decode(_jsonEncode));
    print(distanceMatrix.elements[0].duration.text);
    print("THIS IS THE RESULT");
    setState(() {
      _placeDistance = distanceMatrix.elements[0].distance.text;
      _duree=distanceMatrix.elements[0].duration.text;
      isCalculated=true;
    });
       _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();
  }
    getInfoOfLocations() async {
    String livreurUid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('Commande')
        .where('clientUid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          livreurUid = result.data()['livreurUID'];
          adress_client = result.data()['adressePickup'];
          startAddressController.text=adress_client;
        });
      });
    });
    await firestore
        .collection('Livreur')
        .where('id', isEqualTo: livreurUid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
          adress_livreur = result.data()['adress'];
          destinationAddressController.text=adress_livreur;
        });
      });
    });
  }
  @override
  void initState() {
    /// add origin marker origin marker
  // _getCurrentLocation();
  _getUserLocation();
 getInfoOfLocations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
   width: width,
   height: height,
    
      child: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            polylines: Set<Polyline>.of(polylines.values),
            markers: Set<Marker>.of(markers.values),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Places',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Start',
                              hint: 'Choose starting point',
                              initialValue: _currentAddress,
                              prefixIcon: Icon(Icons.looks_one),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {
                                  startAddressController.text = _currentAddress;
                                  _startAddress = _currentAddress;
                                },
                              ),
                              controller: startAddressController,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  _startAddress = value;
                                });
                              }),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Destination',
                              hint: 'Choose destination',
                              initialValue: '',
                              prefixIcon: Icon(Icons.looks_two),
                              controller: destinationAddressController,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  _destinationAddress = value;
                                });
                              }),
                          SizedBox(height: 10),
                          Visibility(
                            visible: _placeDistance == null ? false : true,
                            child: Text(
                              'DISTANCE: $_placeDistance km\nDUREE: $_duree',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          RaisedButton(
           
                            onPressed: (){},
                              // _startAddress != '' &&
                              //       _destinationAddress != '')
                              //   ? () async {
                              //       setState(() {
                              //         if (markers.isNotEmpty) markers.clear();
                              //         if (polylines.isNotEmpty)
                              //           polylines.clear();
                              //         if (polylineCoordinates.isNotEmpty)
                              //           polylineCoordinates.clear();
                              //         _placeDistance = null;
                              //       });

                              //       _calculateDistance().then((isCalculated) {
                              //         if (isCalculated) {
                              //           _scaffoldKey.currentState.showSnackBar(
                              //             SnackBar(
                              //               content: Text(
                              //                   'Distance Calculated Sucessfully'),
                              //               backgroundColor: Colors.green,
                              //             ),
                              //           );
                              //         } else {
                              //           _scaffoldKey.currentState.showSnackBar(
                              //             SnackBar(
                              //               content: Text(
                              //                   'Error Calculating Distance'),
                              //               backgroundColor: Colors.red,
                              //             ),
                              //           );
                              //         }
                              //       });
                              //     }
                              //   : null,
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Show Route'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
            ),
             SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange[100], // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBaZHYeXE_Bb8_sv7edLHQL_qVHQU-bhDk",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
