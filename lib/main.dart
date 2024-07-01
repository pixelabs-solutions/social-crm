import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/shared_prefes.dart';
import 'package:social_crm/view/auth/login_screen.dart';
import 'package:social_crm/view/screens/NavigatonMain.dart';
import 'package:social_crm/view/screens/first_screen.dart';

import 'viewModel/CustomerList_vm.dart';
import 'viewModel/StatusDetails_viewModel.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefernce.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isTokenExist = SharedPrefernce.prefs?.get('token');
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
            home:  isTokenExist != null ? const MainScreen() : const AuthScreen(),
          );
        },
      ),
    );
  }


}

//