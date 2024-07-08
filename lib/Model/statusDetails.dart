class StatusResponse {
  String status;
  StatusData2 data;

  StatusResponse({required this.status, required this.data});

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    return StatusResponse(
      status: json['status'],
      data: StatusData2.fromJson(json['data']),
    );
  }
}

class StatusData2 {
  int count;
  List<Status> statuses;

  StatusData2({required this.count, required this.statuses});

  factory StatusData2.fromJson(Map<String, dynamic> json) {
    var list = json['statuses'] as List;
    List<Status> statusList = list.map((e) => Status.fromJson(e)).toList();

    return StatusData2(
      count: json['count'] ?? 0, // Add null check to avoid type issues
      statuses: statusList,
    );
  }
}

class Status {
  int id;
  int? customerId;
  String statusType;
  String content;
  String scheduleDate;
  String scheduleTime;
  int userId;
  String statusIds;
  int posted;
  int views;

  Status({
    required this.id,
    this.customerId,
    required this.statusType,
    required this.content,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.userId,
    required this.statusIds,
    required this.posted,
    required this.views,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      customerId: json['customer_id'] ?? 0,
      statusType: json['status_type'],
      content: json['content'],
      scheduleDate: json['schedule_date'],
      scheduleTime: json['schedule_time'],
      userId: json['user_id'],
      statusIds: json['status_ids'] ?? '',
      posted: json['posted'],
      views: (json['views'] is List) ? json['views'].length : json['views'] ?? 0,
    );
  }
}

