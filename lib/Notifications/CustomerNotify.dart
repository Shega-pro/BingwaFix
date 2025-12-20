import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CustomerNotifyPage extends StatefulWidget {
  final String userId;
  const CustomerNotifyPage({super.key, required this.userId});

  @override
  _CustomerNotifyPage createState() => _CustomerNotifyPage();
}

class _CustomerNotifyPage extends State<CustomerNotifyPage> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState () {
    super.initState();
    _fetchNotifications(widget.userId);
  }

  Future<void> _fetchNotifications (String userId) async {
    try {
      final response = await http.get(
        Uri.parse('https://bingwa-fix-backend.vercel.app/api/notifications/$userId'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _notifications = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load notifications");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'))
      );
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      body: _isLoading ?
      const CircularProgressIndicator(color: Colors.green,)
          : _notifications.isEmpty ?
      const Center( child: Text('No available notifications', style: TextStyle(color: Colors.redAccent),),)
          : RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notifications = _notifications[index];
            return _buildNotificationsCard(notifications);
          },
        ),
      )
    );
  }

  Widget _buildNotificationsCard(Map<String, dynamic> notifications) {
    final icon = _getIconForType(notifications['type']);
    final color = (notifications['status'] == 'unread') ? Colors.greenAccent : Colors.white;
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black12,
          ),
          child: Icon(icon, color: color,),
        ),
        title: Text(notifications['title'],style: TextStyle(fontWeight: (notifications['status'] == 'read') ? FontWeight.w400 : FontWeight.w600),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notifications['message']),
            const SizedBox(height: 4),
            // Text(
            //   DateFormat('MMM dd, hh:mm a').format(notifications['timestamp']),
            //   style: const TextStyle(fontSize: 12, color: Colors.grey),
            // ),
          ],
        ),
        trailing: (notifications['status'] == 'read') ? null : Icon(Icons.mail_lock_outlined, color: Colors.black54,),
        onTap: () {
          _handleNotificationTap(notifications['id']);
        },
      ),
      elevation: 3,
      color: Colors.white,
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'job_request':
        return Icons.work_outline;
      case 'job_accepted':
        return Icons.thumb_up;
      case 'payment_received':
        return Icons.attach_money_rounded;
      case 'rating_received':
        return Icons.star;
      case 'system_alert':
        return Icons.warning;
      default:
        return Icons.notifications;
    }
  }

  Future<void> _handleNotificationTap(String _notificationId) async {
    try {
      final response = await http.post(
        Uri.parse('https://bingwa-fix-backend.vercel.app/api/notifications/mark-read/$_notificationId')
      );
      if (response.statusCode == 201) {

      }
    } catch (err) {

    }

    // Handle navigation based on notification type
    // switch (_notifications[]) {
    //   case 'job_request':
    //   // Navigate to job details
    //     break;
    //   case 'job_accepted':
    //   // Navigate to active job
    //     break;
    //   case 'payment_received':
    //   // Navigate to wallet
    //     break;
    //   case 'rating_received':
    //   // Navigate to ratings
    //     break;
    //   default:
    //   // Do nothing for system alerts
    //     break;
    // }
  }

  Future<void> _refreshNotifications() async {
    // This will be replaced with actual database fetch
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

}