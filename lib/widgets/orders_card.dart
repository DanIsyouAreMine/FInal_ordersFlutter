class Order {
  final int id;
  final String customerName;
  final String orderDetails;

  Order(
      {required this.id,
      required this.customerName,
      required this.orderDetails});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerName: json['customer_name'],
      orderDetails: json['order_details'],
    );
  }
}
