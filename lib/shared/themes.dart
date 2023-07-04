import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradution_project/shared/styles/colors.dart';

ThemeData darktheme = ThemeData(

  splashColor:Colors.grey[800] ,
iconTheme: const IconThemeData(color: Colors.white, ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(10.0),
    ),

    prefixIconColor: Colors.white
  ),
  // primaryColor: Colors.deepOrange,
  primarySwatch: defaultcolor,

  appBarTheme: AppBarTheme(
    titleSpacing: 16.0,
    backgroundColor: Colors.grey[800],
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[800],
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.grey[200],
      size: 30.0,
    ),
  ),
  scaffoldBackgroundColor: Colors.grey[800],
  textTheme:  const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
    bodySmall:TextStyle(
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  fontFamily: 'fonts',
);




ThemeData lighttheme = ThemeData(

  // primaryColor: Colors.deepOrange,
  primarySwatch: defaultcolor,
  appBarTheme:  const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black,weight: 600.0,size: 30.0),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),

  ),
  scaffoldBackgroundColor: Colors.white,

  fontFamily: 'fonts',
);
