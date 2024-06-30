import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/view/auth/login_screen.dart';
import 'package:social_crm/view/screens/NavigatonMain.dart';
import 'package:social_crm/view/screens/first_screen.dart';
import 'view/auth/whatsappCode.dart';
import 'view/screens/clientpage_screen.dart';
import 'viewModel/CustomerList_vm.dart';
import 'viewModel/StatusDetails_viewModel.dart'; // Add this import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerViewModel()),
        ChangeNotifierProvider(create: (_)=> StatusHistoryViewModel())// Add your CustomerViewModel provider
      ],
      child: Resize(
        builder: () {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social CRM',
            theme: ThemeData(),
            home: FutureBuilder<bool>(
              future: checkLoginStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator
                } else {
                  if (snapshot.hasData && snapshot.data == true) {
                    return MainScreen(); // User is logged in, show main screen
                  } else {
                    return
                      // WhatsAppCode();
                      //MainScreen();
                     AuthScreen(); // User is not logged in, show login screen
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
