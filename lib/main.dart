import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/view/auth/login_screen.dart';
import 'package:social_crm/view/screens/NavigatonMain.dart';
import 'package:social_crm/view/screens/first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Resize(
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner:false ,
          title: 'Social CRM',
          theme: ThemeData(

          ),
          home: FutureBuilder<bool>(
            future: checkLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading indicator
              } else {
                if (snapshot.hasData && snapshot.data == true) {
                  return MainScreen(); // User is logged in, show main screen
                } else {
                  return AuthScreen();
                    //AuthScreen(); // User is not logged in, show login screen
                }
              }
            },
          ),
        );
      },
    );
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
