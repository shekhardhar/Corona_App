import 'dart:io';

import 'package:flutter/material.dart';

///Contains all the data that are common across the appplication scope
class AppData {
  String username = "1001";
  String otp;
  String newPassword;
  // Role role;
  File image;
  List orderIdList = [];

  int numOfOrders = 0;
  bool isAppNew = true;
  List<String> initialTimeList = [
    TimeOfDay(hour: 09, minute: 00).toString(),
    TimeOfDay(hour: 12, minute: 00).toString(),
    TimeOfDay(hour: 16, minute: 00).toString(),
    TimeOfDay(hour: 20, minute: 00).toString(),
  ];
  List labels = [
    'Time to Wash your Hands',
    'Time to Eat some Citric Fruit',
    'Time to Drink some Water',
  ];

  //
}
