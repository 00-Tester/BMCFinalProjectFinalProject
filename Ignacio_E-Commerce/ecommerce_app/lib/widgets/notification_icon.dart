import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/notifications_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const SizedBox();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .where('userId', isEqualTo: user.uid)
<<<<<<< HEAD
          .snapshots(),

      builder: (context, snapshot) {
        final unreadDocs = snapshot.data?.docs
                .where((doc) => (doc['isRead'] as bool? ?? false) == false)
                .toList() ??
            [];
        final unreadCount = unreadDocs.length;
        final bool hasUnread = unreadCount > 0;

        return Badge(
          isLabelVisible: hasUnread,
          label: hasUnread ? Text(unreadCount.toString()) : null,
=======
          .where('isRead', isEqualTo: false)
          .snapshots(),

      builder: (context, snapshot) {
        bool hasUnread = snapshot.hasData && snapshot.data!.docs.isNotEmpty;

        return Badge(
          isLabelVisible: hasUnread,
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notifications',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}