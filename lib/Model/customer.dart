class Customer {
  String? status;
  List<CustomerData>? data;

  Customer({this.status, this.data});

  Customer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CustomerData>[];
      json['data'].forEach((v) {
        data!.add(CustomerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerData {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? occupation;
  int? userId;
  int active=0;

  CustomerData({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.occupation,
    this.userId,
    required this.active,
  });

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    occupation = json['occupation'];
    userId = json['user_id'];
    active = json ['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['occupation'] = occupation;
    data['user_id'] = userId;
    data['active'] = active;
    return data;
  }
}
