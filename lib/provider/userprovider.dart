import 'package:flutter/material.dart';
import 'package:brewmate_coffee_app/models/appuser.dart';

class UserProvider extends ChangeNotifier {
  AppUser? _user;
  AppUser? get user => _user;

  void setUser(AppUser? user) {
    _user = user;
    notifyListeners();
  }

  void updateProfileImage(String url) {
    if (_user != null) {
      _user = AppUser(
        id: _user!.id,
        name: _user!.name,
        email: _user!.email,
        phoneNumber: _user!.phoneNumber,
        address: _user!.address,
        profileImageUrl: url,
      );
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
