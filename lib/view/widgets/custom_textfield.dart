// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';

class CustomTextField extends StatelessWidget {
  double height;
  TextEditingController controller;
  String? hintText = "";
  TextInputType keyboardType; // Add keyboardType parameter
  bool showBorder; // New parameter to control border visibility
  CustomTextField({
    super.key,
    required this.height,
    required this.controller,
    this.hintText,
    required this.keyboardType, // Make keyboardType required
    this.showBorder = false, // Default value for showBorder
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            25), // Nullify border if showBorder is false
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: 0.1.h),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: null,
          cursorColor: AppColors.cursorColor,
          style: AppConstantsTextStyle.kDefaultappTextStyle,
          decoration: InputDecoration(
            hintStyle: AppConstantsTextStyle.kDefaultappTextStyle,
            hintText: hintText,
            border:
                showBorder ? null : InputBorder.none, // Remove default border
          ),
        ),
      ),
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  String? hintText = "";
  TextEditingController? controller;
  CustomPasswordTextField({
    super.key,
    this.hintText,
    this.controller,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.0025),
        child: TextFormField(
          obscureText: !_isPasswordVisible,
          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: AppColors.cursorColor,
          style: AppConstantsTextStyle.kDefaultappTextStyle,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: _isPasswordVisible
                    ? const Icon(
                        Icons.visibility,
                        color: AppColors.primaryColor,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: AppColors.primaryColor,
                      ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              hintStyle: AppConstantsTextStyle.kNormalWhiteTextStyle,
              hintText: widget.hintText,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
