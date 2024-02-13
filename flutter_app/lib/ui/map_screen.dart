import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MapScreen extends StatefulWidget {
  final bool isSelecting;
  final Function(PlaceLocation)? onSelectLocation;

  MapScreen({required this.isSelecting, required this.onSelectLocation});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  LatLng? _currentLocation;
  String? _pickedLocationAddress;
  Set<Marker> _markers = {};
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () async {
                if (_selectedLocation != null) {
                  await _getAddressFromLatLng(
                    _selectedLocation!.latitude,
                    _selectedLocation!.longitude,
                  );
                  PlaceLocation selectedPlace = PlaceLocation(
                    latitude: _selectedLocation!.latitude,
                    longitude: _selectedLocation!.longitude,
                    address: _pickedLocationAddress ?? '',
                  );

                  // Return the selected place when the map screen is popped
                  Navigator.of(context).pop(selectedPlace);
                }
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) async {
              _mapController = controller;
              // Additional initialization if needed
            },
            initialCameraPosition: CameraPosition(
              target: _currentLocation ?? LatLng(41.6086, 21.7453),
              zoom: 14.0,
            ),
            onTap: widget.isSelecting ? _updateSelectedLocation : null,
            markers: _markers,
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Text(
              _pickedLocationAddress ?? '',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _updateSelectedLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selected-location'),
          position: location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      PermissionStatus _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      LocationData currentLocation = await _location.getLocation();
      LatLng currentLatLng = LatLng(
        currentLocation.latitude ?? 0.0,
        currentLocation.longitude ?? 0.0,
      );
      _updateCurrentLocation(currentLatLng);
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  void _updateCurrentLocation(LatLng location) {
    setState(() {
      _currentLocation = location;
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(location, 14.0),
      );
    });
  }
  //String api = apiKeys().android_api_key;
  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    //todo: REPLACE ANDROID API KEY HERE
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=ANDROID_API_KEY_HERE');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final results = resData['results'];
    if (results != null && results.isNotEmpty) {
      setState(() {
        _pickedLocationAddress = results[0]['formatted_address'];

        // Print the coordinates along with the address
        print('Coordinates: $latitude, $longitude');
      });
    }
  }
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  String toString() {
    return 'PlaceLocation{latitude: $latitude, longitude: $longitude, address: $address}';
  }
}
