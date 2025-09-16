import 'package:flutter/material.dart';
import 'package:bingwa_fix/Registration/FundiRegister.dart';
import 'package:bingwa_fix/Registration/LoginPage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              const Center(
                child: Text(
                  'Welcome to BingwaFix',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28, color: Colors.white),
                ),
              ),
              SizedBox(height: 30,),
              const Center(
                child: Text(
                  'Connecting skilled & trustworthy Fundi with customers who need their services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 120),
              _buildServiceCard(
                title: 'I Need Services',
                buttonText: 'Join as Customer',
                context: context,
              ),
              const SizedBox(height:40),
              _buildServiceCard(
                title: 'I Offer Services',
                buttonText: 'Join as Fundi',
                context: context,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String buttonText,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (buttonText == 'Join as Customer') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  } else if (buttonText == 'Join as Fundi') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FundiAuthPortal())
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: Text(buttonText,style: TextStyle(fontSize: 14),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}