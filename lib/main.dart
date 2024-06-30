import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/view/screens/NavigatonMain.dart';
import 'package:social_crm/view/screens/first_screen.dart';

import 'utilis/shared_prefes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefernce.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var isTokenExist = SharedPrefernce.prefs?.get('token');
    return Resize(
      builder: () {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social CRM',
            theme: ThemeData(),
            home:
                isTokenExist != null ? const MainScreen() : const AuthScreen());
      },
    );
  }
}
