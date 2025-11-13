import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _markAsReadRequested = false;

  void _markNotificationsAsRead(List<QueryDocumentSnapshot> docs) {
    if (!mounted) return;

    final batch = _firestore.batch();

    final unreadDocs = docs.where((doc) => doc['isRead'] == false).toList();

    if (unreadDocs.isEmpty) {
      _markAsReadRequested = false;
      return;
    }

    _markAsReadRequested = true;

    for (var doc in unreadDocs) {
      batch.update(doc.reference, {'isRead': true});
    }

    batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: currentUserId == null
          ? const Center(child: Text('Please log in.'))
          : StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('notifications')
            .where('userId', isEqualTo: currentUserId)
            .orderBy('createdAt', descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs;

          if (docs == null || docs.isEmpty) {
            return const Center(child: Text('You have no notifications.'));
          }

          if (!_markAsReadRequested) {
            _markNotificationsAsRead(docs);
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              final timestamp = (data['createdAt'] as Timestamp?);
              final formattedDate = timestamp != null
                  ? DateFormat('MM/dd/yy hh:mm a').format(timestamp.toDate())
                  : 'No Date';

              final bool wasUnread = data['isRead'] == false;

              return ListTile(
                leading: wasUnread
                    ? const Icon(Icons.circle, color: Colors.deepPurple, size: 12)
                    : const Icon(Icons.circle_outlined, color: Colors.grey, size: 12),
                title: Text(
                  data['title'] ?? 'No Title',
                  style: TextStyle(
                    fontWeight: wasUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  '${data['body'] ?? ''}\n$formattedDate',
                ),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}