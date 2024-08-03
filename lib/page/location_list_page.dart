// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data_dummy.dart';
import '../cubit/location_cubit.dart';
import '../models/location_models.dart';
import 'location_map_page.dart';

// class LocationListScreen extends StatelessWidget {
//   const LocationListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pilih Lokasi Kantor'),
//       ),
//       body: BlocConsumer<LocationCubit, LocationState>(
//         listener: (context, state) {
//           if (state.permission == LocationPermission.denied) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                   content: Text('Izin lokasi diperlukan untuk aplikasi ini.')),
//             );
//           }
//         },
//         builder: (context, state) {
//           return ListView.builder(
//             itemCount: DummyData.locations.length,
//             itemBuilder: (context, index) {
//               LocationModel location = DummyData.locations[index];
//               return ListTile(
//                 trailing: ElevatedButton(
//                     onPressed: () async {
//                       Position userPosition =
//                           await Geolocator.getCurrentPosition(
//                               desiredAccuracy: LocationAccuracy.high);
//                       double distanceInMeters = Geolocator.distanceBetween(
//                         userPosition.latitude,
//                         userPosition.longitude,
//                         location.latitude,
//                         location.longitude,
//                       );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LocationMapScreen(
//                             location: location,
//                             userPosition: LatLng(
//                                 userPosition.latitude, userPosition.longitude),
//                             distance: distanceInMeters,
//                           ),
//                         ),
//                       );
//                     },
//                     child: const Text('Pilih Lokasi')),
//                 title: Text(location.name),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class LocationListScreen extends StatefulWidget {
  const LocationListScreen({super.key});

  @override
  State<LocationListScreen> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  late LocationCubit cubit;

  @override
  void initState() {
    cubit = context.read<LocationCubit>();
    cubit.loadLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Lokasi Kantor'),
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state.permission == LocationPermission.denied) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Izin lokasi diperlukan untuk aplikasi ini.')),
            );
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Menampilkan list lokasi
          return ListView.builder(
            itemCount: DummyData.locations.length,
            itemBuilder: (context, index) {
              LocationModel location = DummyData.locations[index];
              return ListTile(
                trailing: ElevatedButton(
                    onPressed: () async {
                      Position userPosition =
                          await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);
                      double distanceInMeters = Geolocator.distanceBetween(
                        userPosition.latitude,
                        userPosition.longitude,
                        location.latitude,
                        location.longitude,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationMapScreen(
                            location: location,
                            userPosition: LatLng(
                                userPosition.latitude, userPosition.longitude),
                            distance: distanceInMeters,
                          ),
                        ),
                      );
                    },
                    child: const Text('Pilih Lokasi')),
                title: Text(location.name),
              );
            },
          );
        },
      ),
    );
  }
}
