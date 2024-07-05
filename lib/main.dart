import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/http.dart';
import 'package:social_crm/utilis/shared_prefes.dart';
import 'package:social_crm/view/screens/navigaton_main.dart';
import 'package:social_crm/view/screens/first_screen.dart';

import 'viewModel/customerList_vm.dart';
import 'viewModel/statusDetails_viewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SharedPrefernce.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var isTokenExist = SharedPrefernce.prefs?.get('token');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerViewModel()),

        ChangeNotifierProvider(
            create: (_) =>
                StatusHistoryViewModel()) // Add your CustomerViewModel provider
      ],
      child: Resize(
        builder: () {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social CRM',
            theme: ThemeData(),
            home:
                isTokenExist != null ? const MainScreen() : const AuthScreen(),
          );
        },
      ),
    );
  }
}

//