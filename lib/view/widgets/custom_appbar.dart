import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/view/screens/first_screen.dart';

import '../../utilis/Toast.dart';



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: AppColors.scaffoldColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_outlined,
            color: Colors.white), // Change the icon and color here
        onPressed: () {
          Navigator.of(context).pop(); // Define the action for the back button
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(30);
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  Future<void> logoutUser(BuildContext context) async {
    try {
      // Clear user data
      await clearUserData();

      // Navigate to the login screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
            (Route<dynamic> route) => false,
      );

      // Show a logout success message
      ToastUtil.showToast(
        msg: "Logout successful",
        backgroundColor: Colors.green,
      );
    } catch (e) {
      print('Error occurred during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: AppColors.primaryColor,
            title: Center(
              child: const Text(
                'אישור',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: const Text(
              'האם אתה בטוח שברצונך להתנתק?',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  side: const BorderSide(color: AppColors.orangeButtonColor),
                ),
                child: const Text('ביטול'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.orangeButtonColor,
                ),
                child: const Text('התנתקות'),
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                  await logoutUser(context); // Call the logout function
                },
              ),
            ],
          ),
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        color: AppColors.scaffoldColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo2.png',
                  height: 70.h,
                ),
              ],
            ),
            GestureDetector(
              onTap: ()async{
                showLogoutConfirmationDialog(context);
              },

              child:Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor2,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.logout, size: 25,
                  color: AppColors.orangeButtonColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // ignore: prefer_const_constructors
  Size get preferredSize => Size.fromHeight(200.h);
}
