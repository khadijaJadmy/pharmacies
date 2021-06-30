



// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MyMapPage extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MyMapPage> {
//   static const _initialCameraPosition = CameraPosition(
//     target: LatLng(37.773972, -122.431297),
//     zoom: 11.5,
//   );

//   GoogleMapController _googleMapController;
//   Marker _origin;
//   Marker _destination;
//   Directions _info;

//   @override
//   void dispose() {
//     _googleMapController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: const Text('Google Maps'),
//         actions: [
//           if (_origin != null)
//             TextButton(
//               onPressed: () => _googleMapController.animateCamera(
//                 CameraUpdate.newCameraPosition(
//                   CameraPosition(
//                     target: _origin.position,
//                     zoom: 14.5,
//                     tilt: 50.0,
//                   ),
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 primary: Colors.green,
//                 textStyle: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               child: const Text('ORIGIN'),
//             ),
//           if (_destination != null)
//             TextButton(
//               onPressed: () => _googleMapController.animateCamera(
//                 CameraUpdate.newCameraPosition(
//                   CameraPosition(
//                     target: _destination.position,
//                     zoom: 14.5,
//                     tilt: 50.0,
//                   ),
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 primary: Colors.blue,
//                 textStyle: const TextStyle(fontWeight: FontWeight.w600),
//               ),
//               child: const Text('DEST'),
//             )
//         ],
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           GoogleMap(
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: false,
//             initialCameraPosition: _initialCameraPosition,
//             onMapCreated: (controller) => _googleMapController = controller,
//             markers: {
//               if (_origin != null) _origin,
//               if (_destination != null) _destination
//             },
//             polylines: {
//               if (_info != null)
//                 Polyline(
//                   polylineId:  PolylineId('overview_polyline'),
//                   color: Colors.red,
//                   width: 5,
//                   points: _info.polylinePoints
//                       .map((e) => LatLng(e.latitude, e.longitude))
//                       .toList(),
//                 ),
//             },
//             onLongPress: _addMarker,
//           ),
//           if (_info != null)
//             Positioned(
//               top: 20.0,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 6.0,
//                   horizontal: 12.0,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.yellowAccent,
//                   borderRadius: BorderRadius.circular(20.0),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       offset: Offset(0, 2),
//                       blurRadius: 6.0,
//                     )
//                   ],
//                 ),
//                 child: Text(
//                   '${_info.totalDistance}, ${_info.totalDuration}',
//                   style: const TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.black,
//         onPressed: () => _googleMapController.animateCamera(
//           _info != null
//               ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
//               : CameraUpdate.newCameraPosition(_initialCameraPosition),
//         ),
//         child: const Icon(Icons.center_focus_strong),
//       ),
//     );
//   }

//   void _addMarker(LatLng pos) async {
//     if (_origin == null || (_origin != null && _destination != null)) {
//       // Origin is not set OR Origin/Destination are both set
//       // Set origin
//       setState(() {
//         _origin = Marker(
//           markerId:  MarkerId('origin'),
//           infoWindow: const InfoWindow(title: 'Origin'),
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//           position: pos,
//         );
//         // Reset destination
//         _destination = null;

//         // Reset info
//         _info = null;
//       });
//     } else {
//       // Origin is already set
//       // Set destination
//       setState(() {
//         _destination = Marker(
//           markerId:  MarkerId('destination'),
//           infoWindow: const InfoWindow(title: 'Destination'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//           position: pos,
//         );
//       });

//       // Get directions
//       final directions = await DirectionsRepository()
//           .getDirections(origin: _origin.position, destination: pos);
//       setState(() => _info = directions);
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';

// void main() {
//   runApp(MyApp());
// }

class MyPolyMapPage extends StatefulWidget {
  @override
  _TestMapPolylineState createState() => _TestMapPolylineState();
}

class _TestMapPolylineState extends State<MyPolyMapPage> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  GoogleMapController controller;

  List<LatLng> latlngSegment1 = List();
  List<LatLng> latlngSegment2 = List();
  static LatLng _lat1 = LatLng(13.035606, 77.562381);
  static LatLng _lat2 = LatLng(13.070632, 77.693071);
  // static LatLng _lat3 = LatLng(12.970387, 77.693621);
  // static LatLng _lat4 = LatLng(12.858433, 77.575691);
  // static LatLng _lat5 = LatLng(12.948029, 77.472936);
  // static LatLng _lat6 = LatLng(13.069280, 77.455844);
  LatLng _lastMapPosition = _lat1;

  @override
  void initState() {
    super.initState();
    //line segment 1
    latlngSegment1.add(_lat1);
    latlngSegment1.add(_lat2);
    // latlngSegment1.add(_lat3);
    // latlngSegment1.add(_lat4);

    //line segment 2
    // latlngSegment2.add(_lat4);
    // latlngSegment2.add(_lat5);
    // latlngSegment2.add(_lat6);
    latlngSegment2.add(_lat1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        //that needs a list<Polyline>
        polylines: _polyline,
        markers: _markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _lastMapPosition,
          zoom: 11.0,
        ),
        mapType: MapType.normal,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Awesome Polyline tutorial',
          snippet: 'This is a snippet',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment1,
        width: 2,
        color: Colors.blue,
      ));

      //different sections of polyline can have different colors
      _polyline.add(Polyline(
        polylineId: PolylineId('line2'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment2,
        width: 2,
        color: Colors.red,
      ));
    });
  }
}
// final Set<Polyline> polyline = {};

//   GoogleMapController _controller;
//   List<LatLng> routeCoords;
//   GoogleMapPolyline googleMapPolyline =
//       new GoogleMapPolyline(apiKey: "AIzaSyC3HH0n74KrqOLAvZTv_SvxIs_1VL6xYgo");

//   getsomePoints() async {
//     var permissions =
//         await Permission.getPermissionsStatus([PermissionName.Location]);
//     if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
//       var askpermissions =
//           await Permission.requestPermissions([PermissionName.Location]);
//     } else {
//       routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
//           origin: LatLng(40.6782, -73.9442),
//           destination: LatLng(40.6944, -73.9212),
//           mode: RouteMode.driving);
//     }
//   }

//   getaddressPoints() async {
//     routeCoords = await googleMapPolyline.getPolylineCoordinatesWithAddress(
//             origin: '55 Kingston Ave, Brooklyn, NY 11213, USA',
//             destination: '178 Broadway, Brooklyn, NY 11211, USA',
//             mode: RouteMode.driving);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getaddressPoints();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GoogleMap(
//       onMapCreated: onMapCreated,
//       polylines: polyline,
//       initialCameraPosition:
//           CameraPosition(target: LatLng(40.6782, -73.9442), zoom: 14.0),
//       mapType: MapType.normal,
//     ));
//   }

//   void onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _controller = controller;

//       polyline.add(Polyline(
//           polylineId: PolylineId('route1'),
//           visible: true,
//           points: routeCoords,
//           width: 4,
//           color: Colors.blue,
//           startCap: Cap.roundCap,
//           endCap: Cap.buttCap));
//     });
//   }
// }
