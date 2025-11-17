import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

<<<<<<< HEAD
  Future<void> _updateOrderStatus(
      String orderId,
      String newStatus,
      String userId,
      String orderSummary,
      ) async {
=======
  Future<void> _updateOrderStatus(String orderId, String newStatus, String userId) async {
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': newStatus,
      });

      await _firestore.collection('notifications').add({
        'userId': userId,
        'title': 'Order Status Updated',
<<<<<<< HEAD
        'body': 'Your order for $orderSummary is now "$newStatus".',
=======
        'body': 'Your order ($orderId) has been updated to "$newStatus".',
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
        'orderId': orderId,
        'createdAt': FieldValue.serverTimestamp(),
        'isRead': false,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order status updated!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update status: $e')),
        );
      }
    }
  }

<<<<<<< HEAD
  void _showStatusDialog(String orderId, String currentStatus, String userId, String orderSummary) {
=======
  void _showStatusDialog(String orderId, String currentStatus, String userId) {
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
    showDialog(
      context: context,
      builder: (dialogContext) {
        const statuses = ['Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'];

        return AlertDialog(
          title: const Text('Update Order Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: statuses.map((status) {
              return ListTile(
                title: Text(status),
                trailing: currentStatus == status ? const Icon(Icons.check) : null,
                onTap: () {
<<<<<<< HEAD
                  _updateOrderStatus(orderId, status, userId, orderSummary);
=======
                  _updateOrderStatus(orderId, status, userId);
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
                  Navigator.of(dialogContext).pop();
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            )
          ],
        );
      },
    );
  }

<<<<<<< HEAD
  String _buildOrderSummary(List<dynamic>? items) {
    final parsedItems = items ?? [];
    if (parsedItems.isEmpty) {
      return 'your items';
    }

    final firstItemRaw = parsedItems.first;
    final firstItem = firstItemRaw is Map<String, dynamic> ? firstItemRaw : <String, dynamic>{};
    final String firstName = (firstItem['name'] as String?)?.trim().isNotEmpty == true
        ? firstItem['name']
        : 'your item';
    final int firstQty = (firstItem['quantity'] as int?) ?? 1;

    if (parsedItems.length == 1) {
      return firstQty > 1 ? '$firstQty x $firstName' : firstName;
    }

    final int remainingCount = parsedItems.length - 1;
    return '$firstName and $remainingCount other item${remainingCount > 1 ? 's' : ''}';
  }

=======
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('orders')
            .orderBy('createdAt', descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderData = order.data() as Map<String, dynamic>;

              final Timestamp? timestamp = orderData['createdAt'] as Timestamp?;
              final String formattedDate = timestamp != null
                  ? DateFormat('MM/dd/yyyy hh:mm a').format(timestamp.toDate())
                  : 'No date';

              final String status = orderData['status'] ?? 'Unknown';
              final double totalPrice = (orderData['totalPrice'] as num? ?? 0.0).toDouble();
              final String formattedTotal = '₱${totalPrice.toStringAsFixed(2)}';
              final String userId = orderData['userId'] ?? 'Unknown User';
<<<<<<< HEAD
              final items = orderData['items'] as List<dynamic>?;
              final orderSummary = _buildOrderSummary(items);
=======
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    'Order ID: ${order.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  subtitle: Text(
                      'User: $userId\n'
                          'Total: $formattedTotal | Date: $formattedDate'
                  ),
                  isThreeLine: true,

                  trailing: Chip(
                    label: Text(
                      status,
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor:
                    status == 'Pending' ? Colors.orange :
                    status == 'Processing' ? Colors.blue :
                    status == 'Shipped' ? Colors.deepPurple :
                    status == 'Delivered' ? Colors.green : Colors.red,
                  ),

                  onTap: () {
<<<<<<< HEAD
                    _showStatusDialog(order.id, status, userId, orderSummary);
=======
                    _showStatusDialog(order.id, status, userId);
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}