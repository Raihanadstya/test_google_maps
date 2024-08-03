import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../data_dummy.dart';
import '../models/attendance_models.dart';
import '../models/location_models.dart';

class LocationState {
  final LocationPermission? permission;
  final bool loading;
  final Position? userposisi;
  final List<LocationModel>? locations;
  final double? distanceMeter;

  LocationState({
    this.userposisi,
    this.distanceMeter,
    this.permission,
    this.loading = false,
    this.locations,
  });
}

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationState());

  Position? userposisi;
  double? distanceinMeters;

  Future<void> checkPermission() async {
    emit(LocationState(loading: true));

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    emit(LocationState(permission: permission, loading: false));
  }

  void loadLocations() {
    emit(LocationState(loading: true));
    Future.delayed(const Duration(seconds: 0), () {
      List<LocationModel> loadedLocations = DummyData.locations;
      print('berhasil');
      emit(LocationState(
          permission: state.permission,
          loading: false,
          locations: loadedLocations));
    });
  }

  // Future<void> selectMap({LocationModel? location}) async {
  //   emit(LocationState(loading: true));
  //   userposisi = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   double distance = Geolocator.distanceBetween(
  //     userposisi?.latitude ?? 0,
  //     userposisi?.longitude ?? 0,
  //     location?.latitude ?? 0,
  //     location?.longitude ?? 0,
  //   );

  //   emit(LocationState(
  //       loading: false,
  //       userposisi: userposisi,
  //       distanceMeter: distance,
  //       locations: location));
  // }
}
