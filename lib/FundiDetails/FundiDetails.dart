import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FundiDetails extends StatefulWidget {
  final String fundi_id;
  const FundiDetails({super.key, required this.fundi_id});

  @override
  _FundiDetailsPage createState() => _FundiDetailsPage();
}

class _FundiDetailsPage extends State<FundiDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        
      ),
    );
  }
}