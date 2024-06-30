class StatusData {
  final String? text;
  final String? backgroundColorHex;
  final List<String>? imagePaths;
  final String? videoPath;
  final DateTime? selectedDate;
  DateTime? selectedTime;

  StatusData(
      {this.text,
      this.backgroundColorHex,
      this.imagePaths,
      this.selectedDate,
      this.selectedTime,
      this.videoPath});
}


class StatusDetails {
  final String highestViewers;
  final String nextStatusTime;
  final String nextStatusDate;
  final int pendingAds;
  final int clients;


  StatusDetails({
    required this.highestViewers,
    required this.nextStatusTime,
    required this.nextStatusDate,
    required this.pendingAds,
    required this.clients,
  });

  factory StatusDetails.fromJson(Map<String, dynamic> json) {
    return StatusDetails(
      highestViewers: json['highest_viewers'] ?? '',
      nextStatusTime: json['schedule_time'] ?? '',
      nextStatusDate: json['schedule_date'] ?? '',
      pendingAds: json['count'] ?? 0,
      clients: json['clients'] ?? 0,
    );
  }
}


