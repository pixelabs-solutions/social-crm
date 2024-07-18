class StatusList {
  String? status;
  Data? data;

  StatusList({this.status, this.data});

  StatusList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  List<Statuses>? statuses;

  Data({this.count, this.statuses});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['statuses'] != null) {
      statuses = <Statuses>[];
      json['statuses'].forEach((v) {
        statuses!.add(Statuses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (statuses != null) {
      data['statuses'] = statuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statuses {
  int? id;
  int? customerId;
  String? statusType;
  String? content;
  String? scheduleDate;
  String? scheduleTime;
  int? userId;
  String? statusIds;
  int? posted;
  int? views;


  Statuses(
      {this.id,
      this.customerId,
      this.statusType,
      this.content,
      this.scheduleDate,
      this.scheduleTime,
      this.userId,
      this.statusIds,
        this.views,
      this.posted});

  Statuses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    statusType = json['status_type'];
    content = json['content'];
    scheduleDate = json['schedule_date'];
    scheduleTime = json['schedule_time'];
    userId = json['user_id'];
    statusIds = json['status_ids'];
    posted = json['posted'];
    views = json['views'] is Map
        ? json['views']['number_of_views'] ?? 0
        : (json['views'] is List
        ? json['views'].length
        : (json['views'] is int ? json['views'] : 0));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['status_type'] = statusType;
    data['content'] = content;
    data['schedule_date'] = scheduleDate;
    data['schedule_time'] = scheduleTime;
    data['user_id'] = userId;
    data['status_ids'] = statusIds;
    data['posted'] = posted;
    return data;
  }
}
