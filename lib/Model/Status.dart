class StatusData {
  final String? text;
  final String? backgroundColorHex;
  final List<String>? imagePaths;
  final String? videoPath;
  final DateTime? selectedDate;
  DateTime? selectedTime;

  StatusData({
    this.text,
    this.backgroundColorHex,
    this.imagePaths,
    this.selectedDate,
    this.selectedTime,
    this.videoPath});
}
