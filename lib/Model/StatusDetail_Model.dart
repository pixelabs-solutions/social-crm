// models/status_history_model.dart
class StatusHistoryModel {
  final String iconPath;
  final String views;
  final String time;
  final String rightIconPath;

  StatusHistoryModel({
    required this.iconPath,
    required this.views,
    required this.time,
    required this.rightIconPath,
  });

  factory StatusHistoryModel.fromJson(Map<String, dynamic> json) {
    return StatusHistoryModel(
      iconPath: 'assets/viewIcon.svg',
      views: json['views'],
      time: json['time'],
      rightIconPath:  'assets/e6.png',
    );
  }
}
