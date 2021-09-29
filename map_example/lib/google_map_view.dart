import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({ Key? key }) : super(key: key);

  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {

  final Completer _controller = Completer();
  final CameraPosition _cameraPosition = const CameraPosition(
          target: LatLng(35.62833671313469, 139.74059638686083),
          zoom: 17.0);
  
  static int _markerId = 0;
  static final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("marker_" + _markerId.toString()),
      position: const LatLng(35.62833671313469, 139.74059638686083)),
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.terrain,
          markers: _markers,
          initialCameraPosition: _cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: true,
          onTap: _addMarker,
        ),
      ),
    );
  }

  void _addMarker(LatLng pos) {
    setState(() {
      _markerId++;
      _markers.add(
        Marker(
          markerId: MarkerId("marker_" + _markerId.toString()),
          position: pos)
      );
    });
  }
}