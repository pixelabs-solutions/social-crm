// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Animation<double> animation;

  const CustomBottomNavigationBar({super.key, 
    required this.selectedIndex,
    required this.onItemTapped,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.orangeButtonColor,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, 'assets/userVector.svg'), // Replace with SVG path
              _buildNavItem(context, 1, 'assets/userVector.svg'), // Replace with SVG path
              _buildNavItem(context, 2, 'assets/faCalendar.svg'), // Replace with SVG path
              _buildNavItem(context, 3, 'assets/userVector.svg'), // Replace with SVG path
            ],
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Positioned(
                top: animation.value,
                left: _selectedIndexToLeft(context, selectedIndex),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryColor,
                    border: Border.all(
                      color: AppColors.primaryColor2.withAlpha(20),
                      width: 3,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      _selectedIndexToIcon(selectedIndex),
                      color: AppColors.orangeButtonColor,
                      height: 22.0.h, // Adjust height as needed
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  double _selectedIndexToLeft(BuildContext context, int index) {
    const double containerPadding = 20.0;
    final double iconSegmentWidth = (MediaQuery.of(context).size.width - 2 * containerPadding) / 4;
    const double iconWidth = 55.0; // Adjust this to the actual width of your icon container

    switch (index) {
      case 0:
        return containerPadding + (iconSegmentWidth * 0.30.w- iconWidth / 2);
      case 1:
        return containerPadding + (iconSegmentWidth * 1.10.w - iconWidth / 2);
      case 2:
        return containerPadding + (iconSegmentWidth * 2.1.w - iconWidth / 2);
      case 3:
        return containerPadding + (iconSegmentWidth * 2.9.w - iconWidth / 2);
      default:
        return containerPadding + (iconSegmentWidth * 0.5.w - iconWidth / 2);
    }
  }

  String _selectedIndexToIcon(int index) {
    switch (index) {
      case 0:
        return 'assets/userVector.svg';
      case 1:
        return 'assets/userVector.svg';
      case 2:
        return 'assets/faCalendar.svg';
      case 3:
        return 'assets/userVector.svg';
      default:
        return 'assets/userVector.svg';
    }
  }

  Widget _buildNavItem(BuildContext context, int index, String iconPath) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: SvgPicture.asset(
        iconPath,
        color: selectedIndex == index ? AppColors.orangeButtonColor : AppColors.primaryColor,
        height: 22.0.h,
        // Adjust height as needed
      ),
    );
  }
}
