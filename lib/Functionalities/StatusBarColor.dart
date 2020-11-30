import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

changeStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.deepOrange,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.deepOrange,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));
}
