import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'customers_list.dart';
import 'dashboard_screen.dart';
import 'status_calender.dart';
import 'status_view_history.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    CustomersList(),
    const StatusHistoryView(),
    const StatusCalendar(),
    const DashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _screens[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                height: 45.h,
                decoration: BoxDecoration(
                  color: AppColors.orangeButtonColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          22.0.w), // Increased padding for left and right
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavItem(0, 'assets/faUserFriends.svg'),
                      _buildNavItem(1, 'assets/faArrowUpRightDots.svg'),
                      _buildNavItem(2, 'assets/faCalendar.svg'),
                      _buildNavItem(3, 'assets/faHomesmall.svg'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          for (int i = 0; i < 4; i++) _buildAnimatedIcon(i),
        ],
      ),
    );
  }

  Widget _buildAnimatedIcon(int index) {
    double leftPosition =
        (MediaQuery.of(context).size.width / 8) * (2 * index + 1);
    double iconSize = 20.h; // Adjust the size of the icon as needed

    // Adjusting left position for the last icon to move it slightly left
    if (index == 3) {
      leftPosition -= 16.w; // Adjust the value as needed
    }
    if (index == 2) {
      leftPosition -= 8.w; // Adjust the value as needed
    }
    if (index == 1) {
      leftPosition -= 8.w; // Adjust the value as needed
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      bottom: _selectedIndex == index ? 40 : 18, // Adjusted bottom position
      left: leftPosition -
          18, // Adjusted left position to center the icon, considering padding

      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: ClipRect(
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 45.h, // Total height of the icon container
            width: 50.w, // Total width of the icon container
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? AppColors.primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: _selectedIndex == index
                  ? Border.all(
                      color: AppColors.scaffoldColor,
                      width: 4) // Adjust the border color and width as needed
                  : null,
            ),
            child: Center(
              child: SvgPicture.asset(
                _getIconPath(index),
                color: _selectedIndex == index
                    ? AppColors.orangeButtonColor
                    : Colors.black,
                height: iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getIconPath(int index) {
    switch (index) {
      case 0:
        return 'assets/faUserFriends.svg';
      case 1:
        return 'assets/faArrowUpRightDots.svg';
      case 2:
        return 'assets/faCalendar.svg';
      case 3:
        return 'assets/faHomesmall.svg';
      default:
        return '';
    }
  }

  Widget _buildNavItem(int index, String assetName) {
    return SizedBox(width: 40.w); // Placeholder to maintain space for icons
  }
}
