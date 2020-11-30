import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Functionalities/StatusBarColor.dart';
import 'Screens/HomeScreen/screen.dart';
import 'Screens/MapScreen/Functionalities/locationPermission.dart';

void main() {
  changeStatusBarColor();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sabbar\'s Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Wolf',
        textTheme: TextTheme(
            headline5: TextStyle(color: Colors.black.withOpacity(.7), fontWeight: FontWeight.bold),
            headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
            bodyText1: TextStyle(color: Colors.black.withOpacity(.7), fontWeight: FontWeight.bold, fontSize: 16),
            bodyText2: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.black.withOpacity(.7), fontSize: 9),
            subtitle2: TextStyle(color: Colors.white, fontSize: 12),
            caption: TextStyle(color: Colors.grey, fontSize: 11)),
      ),
      home: BlocProvider(
        create: (context) => LocationPermissionCubit(),
        child: HomeScreen(),
      ),
    );
  }
}
