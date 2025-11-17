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
<<<<<<< HEAD
  bool _isMarkingAll = false;

  Future<void> _markAllAsRead(List<QueryDocumentSnapshot> docs) async {
    final unreadDocs =
        docs.where((doc) => (doc['isRead'] as bool? ?? false) == false).toList();

    if (unreadDocs.isEmpty) return;

    setState(() {
      _isMarkingAll = true;
    });

    final batch = _firestore.batch();
    for (final doc in unreadDocs) {
      batch.update(doc.reference, {'isRead': true});
    }

    try {
      await batch.commit();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to mark notifications as read: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isMarkingAll = false;
        });
      }
    }
=======

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
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
  }

  @override
  Widget build(BuildContext context) {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

<<<<<<< HEAD
    if (currentUserId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
        ),
        body: const Center(child: Text('Please log in.')),
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('notifications')
          .where('userId', isEqualTo: currentUserId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notifications'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notifications'),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final docs = snapshot.data?.docs ?? [];
        docs.sort((a, b) {
          final Timestamp? tsA = a['createdAt'] as Timestamp?;
          final Timestamp? tsB = b['createdAt'] as Timestamp?;
          final dateA = tsA?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);
          final dateB = tsB?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);
          return dateB.compareTo(dateA);
        });
        final hasUnread = docs.any((doc) => (doc['isRead'] as bool? ?? false) == false);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Notifications'),
            actions: [
              if (_isMarkingAll)
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                IconButton(
                  icon: const Icon(Icons.done_all),
                  tooltip: 'Mark all as read',
                  onPressed: hasUnread ? () => _markAllAsRead(docs) : null,
                ),
            ],
          ),
          body: docs.isEmpty
              ? const Center(child: Text('You have no notifications.'))
              : ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;

                    final timestamp = (data['createdAt'] as Timestamp?);
                    final formattedDate = timestamp != null
                        ? DateFormat('MM/dd/yy hh:mm a').format(timestamp.toDate())
                        : 'No Date';

                    final bool isUnread = (data['isRead'] as bool? ?? false) == false;

                    return ListTile(
                      leading: isUnread
                          ? const Icon(Icons.circle, color: Color(0xFFFF10F0), size: 12)
                          : const Icon(Icons.circle_outlined, color: Colors.grey, size: 12),
                      title: Text(
                        data['title'] ?? 'No Title',
                        style: TextStyle(
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        '${data['body'] ?? ''}\n$formattedDate',
                      ),
                      isThreeLine: true,
                    );
                  },
                ),
        );
      },
=======
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
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
    );
  }
}