import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/view/screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Resize(builder: () {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social CRM',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MainScreen(),
      );
    });
  }
}
