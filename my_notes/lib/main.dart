import 'package:flutter/material.dart';
import 'package:my_notes/screens/addNote.dart';
import 'package:my_notes/screens/homescreen.dart';
import 'package:my_notes/screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
    // return LayoutBuilder(builder: (context, constraints) {
    //   if (constraints.maxHeight < 420 && constraints.maxWidth < 640) {
    //     return MaterialApp(
    //       title: 'Flutter Demo',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       home: SplashScreen(),
    //       debugShowCheckedModeBanner: false,
    //     );
    //   } else {
    //     return Center(
    //       child: Text("Your device is not supported"),
    //     );
    //   }
    // });
  }
}
