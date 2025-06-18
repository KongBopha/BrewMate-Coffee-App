import 'package:flutter/material.dart';
import 'package:brewmate_coffee_app/models/appuser.dart';

class UserProvider extends ChangeNotifier{

  AppUser? _user;
  AppUser? get user => _user;

  void setUser(AppUser? user) {
    _user = user;
    notifyListeners();
  }
  void clearUser() {
    _user = null;
    notifyListeners();
  }
}