
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Map<int, Color> color =
{
  50:Color.fromRGBO(38,99,227, .1),
  100:Color.fromRGBO(38,99,227, .2),
  200:Color.fromRGBO(38,99,227, .3),
  300:Color.fromRGBO(38,99,227, .4),
  400:Color.fromRGBO(38,99,227, .5),
  500:Color.fromRGBO(38,99,227, .6),
  600:Color.fromRGBO(38,99,227, .7),
  700:Color.fromRGBO(38,99,227, .8),
  800:Color.fromRGBO(38,99,227, .9),
  900:Color.fromRGBO(38,99,227, 1),
};

ThemeData lightMode = ThemeData(
  //0xff1E2336
  //0xff171D2D
  //0xff26272c
  //0xff292c35
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto',
  primarySwatch: MaterialColor(0xff255ed6,color),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.grey,
    labelColor: Colors.black,
    indicatorSize: TabBarIndicatorSize.label,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(fontSize: 25,color: Colors.black,fontFamily: 'Roboto'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  //primaryColor: Colors.grey[100],
  backgroundColor: Colors.grey[100],
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      height: 1.3,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  //0xff1E2336
  //0xff171D2D
  //0xff26272c
  //0xff292c35
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: Color(0xff171D2D),
  primarySwatch: Colors.blue,
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: Colors.grey,
    labelColor: Colors.white,
    indicatorSize: TabBarIndicatorSize.label,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(fontSize: 25,color: Colors.black,fontFamily: 'Roboto'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff171D2D),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color(0xff171D2D),
    elevation: 0,
  ),
  //primaryColor: Color(0xff1E2336),
  backgroundColor: Color(0xff1E2336),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      height: 1.3,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
);
