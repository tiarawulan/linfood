import 'package:flutter/material.dart';

class UMKMModel extends ChangeNotifier {
  String _name = "Toko Makanan Lezat";
  String _email = "umkm@gmail.com";
  String _phone = "081234567890";

  String get name => _name;
  String get email => _email;
  String get phone => _phone;

  void updateUMKM(String name, String email, String phone) {
    _name = name;
    _email = email;
    _phone = phone;
    notifyListeners();
  }
}

