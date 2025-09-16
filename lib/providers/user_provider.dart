import 'package:flutter/material.dart';
import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user; //Holds the logged -in user

  User? get user => _user; // expose user
  bool get isAuthenticated => _user != null; //quick check

//   Simulate log in
  void login(String Id, String fname, String lname) {
    _user = User(Id: Id, fname: fname, lname: lname);
    notifyListeners(); //Notify UI that the user has changed

  }

  // logout
  void logout() {
    _user = null;
    notifyListeners();
  }
}