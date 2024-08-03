class AttendanceModel {
  final String id;
  final String locationId;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  AttendanceModel(
      {required this.id,
      required this.locationId,
      required this.latitude,
      required this.longitude,
      required this.timestamp});
}
