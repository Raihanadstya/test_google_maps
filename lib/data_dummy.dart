import 'models/location_models.dart';

class DummyData {
  static final LocationModel officeLocation = LocationModel(
    id: '1',
    name: 'Kantor Pusat',
    latitude: -7.250445,
    longitude: 112.768845,
  );
  static List<LocationModel> locations = [
    LocationModel(
        id: '1',
        name: 'Kantor Pusat Hash Micro',
        latitude: -6.1707872587644506,
        longitude: 106.81331237763696),
    LocationModel(
        id: '2',
        name: 'Kantor Hash Micro A ',
        latitude: -6.17597567911982, 
        longitude: 106.82690466163358),
    LocationModel(
        id: '3',
        name: 'Kantor Hash Micro B',
        latitude: -7.252000,
        longitude: 222.12313),
           LocationModel(
        id: '3',
        name: 'Kantor Hash Micro C',
        latitude: -6.1990046536783625,
        longitude: 106.93953189309481),
        
  ];
}
