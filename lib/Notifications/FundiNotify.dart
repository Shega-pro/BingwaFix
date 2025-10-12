import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FundiNotificationsPage extends StatefulWidget {
  final String fundi_id;
  const FundiNotificationsPage({super.key, required this.fundi_id});

  @override
  _FundiNotificationsPageState createState() => _FundiNotificationsPageState();
}

class _FundiNotificationsPageState extends State<FundiNotificationsPage> {
  bool _isloading = true;
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState () {
    super.initState();
    _fetchNotifications(widget.fundi_id);
  }

  Future<void> _fetchNotifications (String fundi_id) async {
    try {
      final response = await http.get(
        Uri.parse('')
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _notifications = List<Map<String, dynamic>>.from(data);
          _isloading = false;
        });
      } else {
        throw Exception('Failed to load motifications');
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
        },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_as_unread),
            onPressed: _markAllAsRead,
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: _isloading ?
      const CircularProgressIndicator(color: Colors.green,)
          : _notifications.isEmpty ?
      const Center(child: Text('No notifications yet', style: TextStyle(color: Colors.red),),)
          : RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return _buildNotificationCard(notification);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final icon = _getIconForType(notification['type']);
    final color = (notification['status'] == 'unread') ? Colors.green : Colors.grey;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          notification['title'],
          style: TextStyle(
            fontWeight: (notification['status'] == 'read') ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification['message']),
            const SizedBox(height: 4),
            Text(
              DateFormat('MMM dd, hh:mm a').format(notification['timestamp']),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: (notification['status'] == 'read') ? null : Icon(Icons.mail_lock_outlined, color: Colors.green,),
        onTap: () => _handleNotificationTap(notification),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'job_request':
        return Icons.work_outline;
      case 'job_accepted':
        return Icons.thumb_up;
      case 'payment_received':
        return Icons.attach_money;
      case 'rating_received':
        return Icons.star;
      case 'system_alert':
        return Icons.warning;
      default:
        return Icons.notifications;
    }
  }

  Future<void> _refreshNotifications() async {
    // This will be replaced with actual database fetch
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['read'] = true;
      }
    });
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    setState(() {
      notification['read'] = true;
    });

    // Handle navigation based on notification type
    switch (notification['type']) {
      case 'job_request':
      // Navigate to job details
        break;
      case 'job_accepted':
      // Navigate to active job
        break;
      case 'payment_received':
      // Navigate to wallet
        break;
      case 'rating_received':
      // Navigate to ratings
        break;
      default:
      // Do nothing for system alerts
        break;
    }
  }


}