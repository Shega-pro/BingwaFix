import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class FundiProfile extends StatefulWidget {
  final String fundi_id;
  const FundiProfile({super.key, required this.fundi_id});


  @override
  _FundiProfileState createState() => _FundiProfileState();
}

class _FundiProfileState extends State<FundiProfile> {
  bool _isLoading = true;
  File? _imageUrl;
  String _name1 = 'John';
  String _name2 = 'Doe';
  String _location = 'Dar';
  int _contacts = 0784-234-000;

  void initState () {
    super.initState();
    _fetchProfile(widget.fundi_id);
  }

  Future<void> _fetchProfile(String fundi_id) async {
    try {

      final String apiUrl = '';

      final response = await http.get(
        Uri.parse(apiUrl)
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _name1 = data['fname'];
          _name2 = data['lname'];
          _location = data['location'];
          _contacts = data['phone_number'];
          _isLoading = false;
        });

      } else {
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'),
          backgroundColor: Colors.black38,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          shape:
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: Duration(seconds: 2),
          dismissDirection: DismissDirection.horizontal,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontSize: 14.0)),
        centerTitle: true,
        backgroundColor: Colors.white24,
        automaticallyImplyLeading: false,
      ),

      body: _isLoading ?
       const CircularProgressIndicator(color: Colors.lightBlue,)
          : Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundImage: _imageUrl != null ? FileImage(_imageUrl!) : null,
                child: _imageUrl == null ? const Icon(Icons.person) : null
            ),

            SizedBox(height: 10.0,),
            Text(_name1 + _name2, style: TextStyle(fontSize: 15.0),),

            SizedBox(height: 10.0,),
            Text(_location, style: TextStyle(fontSize: 15.0),),

            SizedBox(height: 10.0,),
            Text(_contacts.toString(), style: TextStyle(fontSize: 15.0),),

          ],
        ),
      )
    );
  }
}