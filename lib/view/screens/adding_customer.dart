// views/status_history_view.dart
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custom_singledropdown_button.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

class AddingCustomerDetails extends StatelessWidget {
  AddingCustomerDetails({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final MultiSelectController controller = MultiSelectController();
  List<ValueItem> selectedItems = [];
  List<ValueItem> items = [
    const ValueItem(label: 'makeup', value: 'makeup'),
    const ValueItem(label: 'hair cuter', value: 'hair_cuter'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: Row(
                children: [
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.arrow_back_ios_outlined,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  Center(
                    child: Text(
                      'Adding a new customer',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                margin: const EdgeInsets.all(12.0),
                padding: EdgeInsets.only(top: 12.0.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        showText('Customer Name'),
                        CustomTextField(
                          backgroundColor: AppColors.kWhiteColor40Opacity,
                          controller: nameController,
                          height: MediaQuery.of(context).size.height * 0.06,
                          keyboardType: TextInputType.name,
                        ),
                        showText('Mail Address'),
                        CustomTextField(
                          backgroundColor: AppColors.kWhiteColor40Opacity,
                          controller: mailController,
                          height: MediaQuery.of(context).size.height * 0.06,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        showText('Phone Number'),
                        CustomTextField(
                          backgroundColor: AppColors.kWhiteColor40Opacity,
                          controller: phoneController,
                          height: MediaQuery.of(context).size.height * 0.06,
                          keyboardType: TextInputType.number,
                        ),
                        showText('occupation'),
                        CustomDropdownButton(
                          fieldBackgroundColor: AppColors.kWhiteColor40Opacity,
                          options: items,
                          selectedItem: selectedItems,
                          onOptionSelected: (options) {
                            selectedItems = options;
                            // String selectedItem = "";
                            // for (var option in options) {
                            //   var selectedItem = option.value.toString();
                            // }
                          },
                          controller: controller,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        ConstantLargeButton(
                          text: 'Add Customer →',
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2.h),
      child: Text(
        text,
        style: AppConstantsTextStyle.kNormalTextWeight800TextStyle,
      ),
    );
  }
}
