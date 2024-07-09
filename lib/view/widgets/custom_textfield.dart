// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';

class CustomTextFields extends StatefulWidget {
  final double height;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final bool showBorder;
  final Color backgroundColor;
  final TextDirection textDirection;


  CustomTextFields({
    super.key,
    required this.height,
    required this.controller,
    this.hintText,
    required this.keyboardType,
    this.showBorder = false,
    this.backgroundColor = AppColors.kWhiteColor,
    required this.textDirection,
    // Set default prefix to "+972"
  });

  @override
  _CustomTextFieldsState createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {






  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 0.1.h,
        ),
        child: Directionality(
          textDirection: widget.textDirection,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLines: null,
            cursorColor: AppColors.cursorColor,
            style: AppConstantsTextStyle.kTextFieldTextStyle,
            decoration: InputDecoration(
              hintStyle: AppConstantsTextStyle.kTextFieldTextStyle,
              hintText: widget.hintText,
              border: widget.showBorder ? null : InputBorder.none,
            ),
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
          style: AppConstantsTextStyle.kTextFieldTextStyle,
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
              hintStyle: AppConstantsTextStyle.kTextFieldTextStyle,
              hintText: widget.hintText,
              border: InputBorder.none),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool showBorder; // New parameter to control border visibility
  Color backgroundColor;
  SearchTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.showBorder = false, // Default value for showBorder
      this.backgroundColor = AppColors.kWhiteColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            BorderRadius.circular(25), // Nullify border if showBorder is false
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.1.h),
        child: TextFormField(
          controller: controller,
          cursorColor: AppColors.cursorColor,
          style: AppConstantsTextStyle.kTextFieldTextStyle,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.scaffoldColor,
            ),
            hintStyle: AppConstantsTextStyle.kTextFieldTextStyle,
            hintText: hintText,
            border:
                showBorder ? null : InputBorder.none, // Remove default border
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final double height;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;
  final bool showBorder;
  final Color backgroundColor;
  final TextDirection textDirection;
  final String? prefixText;

  CustomTextField({
    super.key,
    required this.height,
    required this.controller,
    this.hintText,
    required this.keyboardType,
    this.showBorder = false,
    this.backgroundColor = AppColors.kWhiteColor,
    required this.textDirection,
    this.prefixText = "+", // Set default prefix to "+972"
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    // Prepend the prefix text to the controller's initial text if it doesn't already start with it
    if (widget.prefixText != null && !widget.controller.text.startsWith(widget.prefixText!)) {
      widget.controller.text = '${widget.prefixText}${widget.controller.text}';
    }

    // Add listener to handle changes
    widget.controller.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChanged);
    super.dispose();
  }

  void _handleTextChanged() {
    // Ensure the text always starts with the prefix text
    if (widget.prefixText != null && !widget.controller.text.startsWith(widget.prefixText!)) {
      widget.controller.text = '${widget.prefixText}${widget.controller.text}';
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: 0.1.h,
        ),
        child: Directionality(
          textDirection: widget.textDirection,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLines: null,
            cursorColor: AppColors.cursorColor,
            style: AppConstantsTextStyle.kTextFieldTextStyle,
            decoration: InputDecoration(
              hintStyle: AppConstantsTextStyle.kTextFieldTextStyle,
              hintText: widget.hintText,
              border: widget.showBorder ? null : InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
