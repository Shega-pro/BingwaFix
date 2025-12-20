import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerProfile extends StatefulWidget {
  final String userId;
  const CustomerProfile({super.key, required this.userId});

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  bool _isLoading = true;
  String _name = 'John Doe';
  int _contacts = 255-784-000-000;
  File? imageUrl;

  @override
  void initState () {
    super.initState();
    _fetchProfile(widget.userId);
}

  Future<void> _fetchProfile(String userId) async {

    final String apiUrl = '';

    try {
      final response = await http.get(
        Uri.parse(apiUrl)
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _name = data['full_name'];
          _contacts = data['phone_number'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load profile');
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading ?
      const CircularProgressIndicator(color: Colors.lightBlue,)
          : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: imageUrl != null ? FileImage(imageUrl!) : null, child: imageUrl == null ? const Icon(Icons.person) : null),
            SizedBox(height: 20,),
            Text(_name, style: TextStyle(fontWeight: FontWeight.bold,)),
            SizedBox(height: 20,),
            Text(_contacts as String),
          ],
        ),
      )
    );
  }
}