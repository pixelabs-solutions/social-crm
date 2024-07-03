import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/Toast.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custom_singledropdown_button.dart';
import 'package:social_crm/view/widgets/custom_textfield.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';

import '../../Model/customer.dart';
import '../../viewModel/CustomerList_vm.dart';

class EditingCustomerDetails extends StatefulWidget {
  final CustomerData customer;

  const EditingCustomerDetails({required this.customer, Key? key}) : super(key: key);

  @override
  _EditingCustomerDetailsState createState() => _EditingCustomerDetailsState();
}

class _EditingCustomerDetailsState extends State<EditingCustomerDetails> {
  late TextEditingController nameController;
  late TextEditingController mailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with customer data
    nameController = TextEditingController(text: widget.customer.name ?? '');
    mailController = TextEditingController(text: widget.customer.email ?? '');
    phoneController = TextEditingController(text: widget.customer.phoneNumber ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers when not needed
    nameController.dispose();
    mailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CustomerViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Padding(
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
                        child: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
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
                            nameController,
                            TextInputType.name,
                          ),
                          _buildFormField(
                            context,
                            'כתובת דוא"ל',
                            mailController,
                            TextInputType.emailAddress,
                          ),
                          _buildFormField(
                            context,
                            'מספר טלפון',
                            phoneController,
                            TextInputType.phone, // Change to TextInputType.phone for phone number input
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
                          ConstantLargeButton(
                            text: 'לעדכן פרטי לקוח →',
                            onPressed: () async {
                              // Update customer data
                              await viewModel.editCustomer(
                                widget.customer.id!,
                                nameController.text,
                                mailController.text,
                                phoneController.text,
                              );

                              Navigator.pop(context);
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
        CustomTextFields(
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
