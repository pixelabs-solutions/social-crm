import 'package:resize/resize.dart';

import '../../utilis/constant_colors.dart';
import '../screens/dashboard_screen.dart';
import '../screens/status_view_history.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_bottomNavigationBar.dart';

// Assuming these are the paths to your screens


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: -30).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return DashboardScreen();
      case 1:
        return StatusHistoryView();
      case 2:
        return DashboardScreen();
      case 3:
        return StatusHistoryView();
      default:
        return DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          Expanded(
            child: _getScreen(_selectedIndex),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 25.0, left: 14.h,right: 14.h),
            child: CustomBottomNavigationBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              animation: _animation,
            ),
          ),
        ],
      ),
    );
  }
}