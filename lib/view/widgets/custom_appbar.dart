import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';



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
              // onTap: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const StatusCalendarScreen()));
              // },
              child: SvgPicture.asset(
                'assets/menuIcon.svg',
                height: 40.h,
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
