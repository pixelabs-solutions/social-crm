import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custom_singledropdown_button.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import '../../Model/customer.dart';
import '../../viewModel/CustomerList_vm.dart';

class EditingCustomerDetails extends StatelessWidget {
  final CustomerData customer;

  const EditingCustomerDetails({required this.customer, super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CustomerViewModel>(context);

    // Initialize controllers with customer data
    viewModel.nameController.text = customer.name!;
    viewModel.mailController.text = customer.email!;
    viewModel.phoneController.text = customer.phoneNumber!;
    viewModel.selectedItems = customer.occupation != null
        ? [
            ValueItem(
              label: customer.occupation!,
              value: customer.occupation!,
            )
          ]
        : [];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                  SizedBox(width: 13.w),
                  Center(
                    child: Text(
                      'עריכת פרטי לקוח',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
                  ),
                ],
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFormField(
                          context,
                          'שם לקוח',
                          viewModel.nameController,
                          TextInputType.name,
                        ),
                        _buildFormField(
                          context,
                          'כתובת דוא"ל',
                          viewModel.mailController,
                          TextInputType.emailAddress,
                        ),
                        _buildFormField(
                          context,
                          'מספר טלפון',
                          viewModel.phoneController,
                          TextInputType.number,
                        ),
                        showText('עיסוק'),
                        CustomDropdownButton(
                          fieldBackgroundColor: AppColors.kWhiteColor40Opacity,
                          options: viewModel.items,
                          selectedItem: viewModel.selectedItems,
                          onOptionSelected: (options) {
                            viewModel.selectedItems = options;
                          },
                          controller: viewModel.controller,
                        ),
                        SizedBox(height: 40.h),
                        viewModel.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ConstantLargeButton(
                                text: 'לעדכן פרטי לקוח →',
                                onPressed: () {
                                  viewModel.editCustomer(customer.id!);
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 12.w),
      child: Text(
        text,
        style: AppConstantsTextStyle.kNormalTextWeight800TextStyle,
      ),
    );
  }

  Widget _buildFormField(
    BuildContext context,
    String labelText,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showText(labelText),
        CustomTextField(
          backgroundColor: AppColors.kWhiteColor40Opacity,
          controller: controller,
          height: MediaQuery.of(context).size.height * 0.06,
          keyboardType: keyboardType,
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
