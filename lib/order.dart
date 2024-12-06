class Order {
  final String id;
  final String customerName;
  final String product;
  final int quantity;
  final double price;
  final String imageUrl;

  Order({
    required this.id,
    required this.customerName,
    required this.product,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  // Method to parse JSON into an Order object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(), // Ensure 'id' is always a string
      customerName: json['customerName'] ?? 'Unknown', // Default value if null
      product: json['product'] ?? 'Unknown Product',
      quantity: json['quantity'] ?? 0, // Default to 0 if missing
      price: (json['price'] ?? 0.0).toDouble(), // Default to 0 if missing
      imageUrl: json['imageUrl'] ?? 'assets/images/ad.jpg',
    );
  }

  // Method to convert Order object back into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'product': product,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
