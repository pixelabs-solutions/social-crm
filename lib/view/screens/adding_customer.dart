// views/status_history_view.dart

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

import '../../viewModel/CustomerList_vm.dart';

class AddingCustomerDetails extends StatelessWidget {
  AddingCustomerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomerViewModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const HomeAppBar(),
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Consumer<CustomerViewModel>(
            builder: (context, viewModel, child) {
              return Column(
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
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'הוספת לקוח חדש',
                              style: AppConstantsTextStyle.heading1Style,
                            ),
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
                            _buildFormField(
                              context,
                              'שם הלקוח',
                              viewModel.nameController,
                              TextInputType.name,
                              viewModel.nameController.text.isEmpty && !viewModel.isLoading ? 'שדה שם הלקוח הוא חובה' : null,
                            ),
                            _buildFormField(
                              context,
                              'כתובת דואר אלקטרוני',
                              viewModel.mailController,
                              TextInputType.emailAddress,
                              viewModel.mailController.text.isEmpty && !viewModel.isLoading ? 'שדה כתובת הדואר האלקטרוני הוא חובה' : null,
                            ),
                            _buildFormField(
                              context,
                              'מספר טלפון',
                              viewModel.phoneController,
                              TextInputType.number,
                              viewModel.phoneController.text.isEmpty && !viewModel.isLoading ? 'שדה מספר הטלפון הוא חובה' : null,
                            ),
                            showText('תעסוקה'),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: CustomDropdownButton(
                                fieldBackgroundColor: AppColors.kWhiteColor40Opacity,
                                options: viewModel.items,
                                selectedItem: viewModel.selectedItems,
                                onOptionSelected: (options) {
                                  viewModel.selectedItems = options;
                                },
                                controller: MultiSelectController(),
                              ),
                            ),
                            if (viewModel.selectedItems.isEmpty && !viewModel.isLoading) showErrorText('בחר לפחות עיסוק אחד'),
                            SizedBox(
                              height: 20.h,
                            ),
                            viewModel.isLoading
                                ? Center(child: CircularProgressIndicator())
                                : ConstantLargeButton(
                              text: 'הוסף לקוח →',
                              onPressed: () {
                                viewModel.addCustomer();
                              },
                            ),

                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          text,
          style: AppConstantsTextStyle.kNormalTextWeight800TextStyle,
        ),
      ),
    );
  }

  Widget _buildFormField(
      BuildContext context,
      String labelText,
      TextEditingController controller,
      TextInputType keyboardType,
      String? errorText,
      ) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
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
          if (errorText != null)
            showErrorText(errorText),
        ],
      ),
    );
  }

  Widget showErrorText(String errorText) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 2.h, bottom: 7.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          errorText,
          style: TextStyle(color: Colors.red, fontSize: 12.sp),
        ),
      ),
    );
  }
}

