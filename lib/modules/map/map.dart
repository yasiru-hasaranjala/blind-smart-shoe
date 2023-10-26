import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final databaseReference = FirebaseDatabase.instance.ref('Location/Latitude');
  final ref = FirebaseDatabase.instance.ref();
  Set<Marker> markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.927079, 79.861244),
    // zoom: 19.8746,
  );

  var marker = const Marker(
    markerId: MarkerId('1'),
    position: LatLng(6.927079, 79.861244),
  );

  final _auth = FirebaseAuth.instance;
  late User loggedinUser;
  bool doorLock = false;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder(
        stream: ref.child('Location').onValue,
        builder: (context, snap) {
          if (snap.hasError) {
            return Text('Something went wrong');
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          double lat = double.parse(snap.data!.snapshot.child("Latitude").value.toString());
          double long = double.parse(snap.data!.snapshot.child("Longitude").value.toString());

          final latLng = LatLng(double.parse(snap.data!.snapshot.child("Latitude").value.toString()), double.parse(snap.data!.snapshot.child("Longitude").value.toString()));

          // Add new marker with markerId.
          markers.add(Marker(markerId: const MarkerId("Location"), position: latLng));

          // If google map is already created then update camera position with animation
          // final GoogleMapController mapController = await _controller.future;
          // mapController.animateCamera(CameraUpdate.newCameraPosition(
          //   CameraPosition(
          //     target: latLng,
          //     zoom: 15.8746,
          //   ),
          // ));

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 19.8746,
            ),

            // Markers to be pointed
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              // Assign the controller value to use it later
              _controller.complete(controller);
            },
          );
        },
      ),
      // floatingActionButton: StreamBuilder(
      //   stream: ref.child('door_rfid_pir_state').onValue,
      //   builder: (context, snap) {
      //     if (snap.hasError) {
      //       return const Text('Something went wrong');
      //     }
      //     if (snap.connectionState == ConnectionState.waiting) {
      //       return const Text("Loading");
      //     }
      //
      //     String door = snap.data!.snapshot.child("door").value.toString();
      //
      //     return Padding(
      //       padding: const EdgeInsets.only(right: 39.0),
      //       child: FloatingActionButton.extended(
      //         backgroundColor: Colors.indigo,
      //         onPressed: (){
      //             ref.child('door_rfid_pir_state').update(
      //               door=='0' ? {"door": 1} : {"door": 0}
      //             );
      //         },
      //         label: door=='0' ? const Text('Door Lock') : const Text('Door Unlock'),
      //         icon: const Icon(Icons.sensor_door_outlined),
      //       ),
      //     );
      //   }
      // ),
      floatingActionButton: StreamBuilder(
        stream: ref.child('battery').onValue,
        builder: (context, snap) {
          if (snap.hasError) {
            return const Text('Something went wrong');
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          double bat = double.parse(snap.data!.snapshot.value.toString());

          return Padding(
            padding: const EdgeInsets.only(right: 55, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text('Battery Level',),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: LinearProgressIndicator(
                        value: bat,
                        color: Colors.green,
                        backgroundColor: Colors.greenAccent,
                      ),
                    ),
                    Container(
                      height: 15,
                      width: 6,
                      color: Colors.greenAccent,
                    )
                  ],
                ),
              ],
            ),
          );
        }
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
              
            ),
          ),
          onPressed: () {
            _auth.signOut();
            Navigator.pop(context);
          },
        ),
        title: const Text('Blind Smart Shoe'),
      ),
    );
  }
}