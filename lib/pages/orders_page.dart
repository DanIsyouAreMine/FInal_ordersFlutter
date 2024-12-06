// lib/pages/orders_page.dart
import 'package:flutter/material.dart';
import '../order.dart';
import '../services/api_service.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = ApiService().fetchOrders();
  }

  void _editOrder(Order order) {}

  void _deleteOrder(Order order) async {
    try {
      await ApiService().deleteOrder(order.id);
      setState(() {
        futureOrders = ApiService().fetchOrders();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: FutureBuilder<List<Order>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders available'));
          } else {
            List<Order> orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return OrderCard(
                  order: orders[index],
                  onEdit: _editOrder,
                  onDelete: _deleteOrder,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final void Function(Order) onEdit;
  final void Function(Order) onDelete;

  OrderCard({
    required this.order,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(order.imageUrl),
        title: Text(order.product),
        subtitle: Text('Qty: ${order.quantity}, Price: \$${order.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => onEdit(order),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete(order),
            ),
          ],
        ),
      ),
    );
  }
}
