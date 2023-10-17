import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveAndGetAccountID extends ChangeNotifier {
  void saveAccountId(int accountId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("account_id", accountId);
  }

  Future<int?> getAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accountId = prefs.getInt("account_id");
    return accountId;
  }
}
