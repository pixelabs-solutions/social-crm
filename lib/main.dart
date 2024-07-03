import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/shared_prefes.dart';
import 'package:social_crm/view/auth/login_screen.dart';
import 'package:social_crm/view/screens/NavigatonMain.dart';
import 'package:social_crm/view/screens/first_screen.dart';

import 'viewModel/CustomerList_vm.dart';
import 'viewModel/StatusDetails_viewModel.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Import jwt_decoder package for token decoding

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefernce.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool shouldNavigateToMainScreen = checkTokenValidity();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerViewModel()),
        ChangeNotifierProvider(create: (_) => StatusHistoryViewModel()), // Add your CustomerViewModel provider
        ChangeNotifierProvider(create: (_) => StatusHistoryViewModel()),
        // Add other providers as needed
      ],
      child: Resize(
        builder: () {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social CRM',
            theme: ThemeData(),
            home: shouldNavigateToMainScreen ? MainScreen() : AuthScreen(),
          );
        },
      ),
    );
  }

  bool checkTokenValidity() {
    var token = SharedPrefernce.prefs?.getString('token');

    if (token == null) {
      return false; // No token exists
    }

    bool isTokenExpired = isTokenExpiredFunction(token);
    return token.isNotEmpty && !isTokenExpired;
  }

  bool isTokenExpiredFunction(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    if (decodedToken['exp'] != null) {
      int expiryTimeInSeconds = decodedToken['exp'];
      DateTime expiryDateTime = DateTime.fromMillisecondsSinceEpoch(expiryTimeInSeconds * 1000);
      print("Token Expiry Date: ${expiryDateTime}" );
      return expiryDateTime.isBefore(DateTime.now());
    } else {
      return true; // If 'exp' claim is missing, consider token as expired
    }
  }
}
