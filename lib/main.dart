import 'package:flutter/material.dart';
import 'package:flutter_webspark_test/provider_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webspark_test/screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ProviderState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webspark test',
      //default theme scheme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue[300],
        textTheme: TextTheme(
          bodySmall: TextStyle(
            color: Colors.black,
            fontSize: 14
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue,
          selectedIconTheme: IconThemeData(color: Colors.white,),
          unselectedIconTheme: IconThemeData(color: Colors.white,),
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
