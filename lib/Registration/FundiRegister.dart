import 'package:bingwa_fix/Registration/FundiLogin.dart';
import 'package:flutter/material.dart';

class FundiAuthPortal extends StatelessWidget {
  const FundiAuthPortal({super.key});


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Contact BingwaFix Offices for Registration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),),
              SizedBox(height: 04,),
              Text('+255 629 763 121', style: TextStyle(fontSize: 14, color: Colors.black),),
              SizedBox(height: 04,),
              Text('+255 628 729 335', style: TextStyle(fontSize: 14, color: Colors.black),),
              SizedBox(height: 04,),
              Text('fixflowinnovators@gmail.com', style: TextStyle(fontSize: 14, color: Colors.blue),),
              SizedBox(height: 40,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FundiLoginPage()));
                  },
                child: const Text('Sign In',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white60, width: 1),
                  ),
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
}