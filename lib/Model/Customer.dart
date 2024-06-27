// models/customer.dart
class Customer {
  final String name;
  final String status;

  Customer({required this.name, required this.status});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      status: json['status'],
    );
  }
}
