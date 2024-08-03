import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/location_models.dart';

class LocationMapScreen extends StatefulWidget {
  final LocationModel location;
  final LatLng userPosition;
  final double distance;

  const LocationMapScreen(
      {super.key,
      required this.location,
      required this.distance,
      required this.userPosition});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Lokasi'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            circles: {
              Circle(
                circleId: CircleId(widget.location.id),
                center:
                    LatLng(widget.location.latitude, widget.location.longitude),
                radius: 50,
                fillColor: Colors.blue.withOpacity(0.3),
                strokeColor: Colors.blue,
                strokeWidth: 1,
              )
            },
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              _controller.animateCamera(CameraUpdate.newLatLng(
                  LatLng(widget.location.latitude, widget.location.longitude)));
            },
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(widget.location.latitude, widget.location.longitude),
              zoom: 17,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('user_location'),
                position: widget.userPosition,
                infoWindow: const InfoWindow(title: 'Lokasi Anda'),
              ),
              Marker(
                  icon: BitmapDescriptor.defaultMarker,
                  markerId: MarkerId(widget.location.id),
                  position: LatLng(
                      widget.location.latitude, widget.location.longitude),
                  infoWindow: InfoWindow(title: widget.location.name))
            },
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: _goToMyLocation,
                        tooltip: 'Get My Location',
                        child: const Icon(Icons.my_location),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: widget.distance <= 50
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                        content: Text('Kehadiran diterima!')));
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              const Size(double.infinity, 50), // Ukuran tombol
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Absen Sekarang'),
                      ),
                      if (widget.distance > 50)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Anda berada di luar radius 50 meter dan tidak dapat absen.',
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _goToMyLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng latLng = LatLng(position.latitude, position.longitude);
      _controller.animateCamera(CameraUpdate.newLatLng(latLng));

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mendapatkan lokasi: $e')));
    }
  }
}
