import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    this.isSelecting = true,
    required this.onSelectLocation,
  }) : super(key: key);

  final bool isSelecting;
  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  String? _pickedLocationAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting
            ? 'Pick your location'
            : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () async {
                if (_pickedLocation != null) {
                  await _getAddressFromLatLng(
                      _pickedLocation!.latitude, _pickedLocation!.longitude);
                  if (_pickedLocationAddress != null) {
                    widget.onSelectLocation(PlaceLocation(
                      latitude: _pickedLocation!.latitude,
                      longitude: _pickedLocation!.longitude,
                      address: _pickedLocationAddress!,
                    ));
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting
            ? (position) {
          setState(() {
            _pickedLocation = position;
          });
        }
            : null,
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            37.42, // Initial latitude
            -122.084, // Initial longitude
          ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
          Marker(
            markerId: const MarkerId('m1'),
            position: _pickedLocation ??
                const LatLng(
                  37.42, // Default latitude
                  -122.084, // Default longitude
                ),
          ),
        },
      ),
    );
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=YOUR API KEY HERE');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final results = resData['results'];
    if (results != null && results.isNotEmpty) {
      setState(() {
        _pickedLocationAddress = results[0]['formatted_address'];
      });
    }
  }
}
