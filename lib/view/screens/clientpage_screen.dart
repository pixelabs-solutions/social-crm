// views/status_history_view.dart
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

import '../../Model/customer.dart';
import '../../viewModel/customerList_vm.dart';
import 'editing_customerdetails_screen.dart';

class ClientPage extends StatefulWidget {
  final CustomerData customer;

  const ClientPage({required this.customer, super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  CustomerViewModel customerViewModel = CustomerViewModel();

  @override
  void initState() {
    super.initState();
    final customerViewModel =
        Provider.of<CustomerViewModel>(context, listen: false);
    customerViewModel.setCustomer(widget.customer);
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: Row(
                        children: [
                          Text(
                            'פרטי לקוח:',
                            style: AppConstantsTextStyle.heading2Style,
                          ),
                          Text(
                            ' ${widget.customer.name}',
                            style: AppConstantsTextStyle.heading2Style,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                margin: const EdgeInsets.all(12.0),
                padding: EdgeInsets.only(top: 12.0.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      _customRow("דוא\"ל", "פעיל"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "${widget.customer.email}",
                              style: AppConstantsTextStyle
                                  .kNormalWhiteNotoTextStyle,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      _customIconRow("assets/editIcon.svg", "טלפון", onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (o) => EditingCustomerDetails(
                                      customer: widget.customer,
                                    )));
                      }),
                      showText("${widget.customer.phoneNumber}"),
                      SizedBox(
                        height: 5.h,
                      ),
                      _customIconRow("assets/deleteIcon.svg", "מקצוע",
                          onTap: () {}),
                      showText("${widget.customer.occupation}"),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        height: 35.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.kWhiteColor23pacity,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(
                          "היסטוריית פרסומים",
                          style:
                              AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                        )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      statusRow("14,500", "24/06/15", "סטטוס וידאו",
                          "assets/vedioStatusIcon.svg"),
                      statusRow(
                          "14,500", "24/06/15", "סטטוס טקסט", "assets/A.svg"),
                      statusRow("14,500", "24/06/15", "סטטוס תמונה",
                          "assets/photoStatusIcon.svg"),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(
      BuildContext context, CustomerViewModel viewModel, String customerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('אישור מחיקה'),
          content: const Text('האם אתה בטוח שברצונך למחוק את הלקוח?'),
          actions: <Widget>[
            TextButton(
              child: const Text('ביטול'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('מחק'),
              onPressed: () {
                viewModel.deleteCustomer(customerId).then((_) {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context)
                      .pop(); // Navigate back to previous screen
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget statusRow(String views, String date, String title, String icon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/eyeIcon.svg",
                    width: 12.w,
                    height: 12.h,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    views,
                    style: AppConstantsTextStyle.kNormalWhiteNotoSmallTextStyle,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 60.w,
              child: Text(
                date,
                style: AppConstantsTextStyle.kNormalWhiteNotoSmallTextStyle,
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Text(
                    title,
                    style: AppConstantsTextStyle.kNormalWhiteNotoSmallTextStyle,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SvgPicture.asset(
                    icon,
                    width: 12.w,
                    height: 12.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: const Divider(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _customRow(String email, String status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            int newStatus = widget.customer.active == 1 ? 0 : 1;
            await customerViewModel.setActiveStatus(
                widget.customer.id!, newStatus);
          },
          child: Consumer<CustomerViewModel>(
            builder: (context, viewModel, child) {
              // Determine the active status based on the view model state

              return Container(
                height: 20.h,
                width: 65.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (widget.customer.active == 0)
                      ? AppColors.offstatusContainerColor
                      : AppColors.statusContainerColor,
                ),
                child: Center(
                  child: Text(
                    widget.customer.active == 0 ? "כבוי" : "פעיל",
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 6.w,
        ),
        GestureDetector(
          onTap: () async {
            int newStatus = widget.customer.active == 1 ? 0 : 1;
            await customerViewModel.setActiveStatus(
                widget.customer.id!, newStatus);
          },
          child: Consumer<CustomerViewModel>(
            builder: (context, viewModel, child) {
              // Determine the active status based on the view model state

              return Container(
                height: 20.h,
                width: 65.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (widget.customer.active == 1)
                      ? AppColors.offstatusContainerColor
                      : AppColors.statusContainerColor,
                ),
                child: Center(
                  child: Text(
                    widget.customer.active == 1 ? "כבוי" : "פעיל",
                  ),
                ),
              );
            },
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Text(
            email,
            style: AppConstantsTextStyle.kNormalWhiteTextStyle,
          ),
        )
      ],
    );
  }

  Widget _customIconRow(String icon, String text,
      {required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: SvgPicture.asset(
              icon,
              width: 20.w,
              height: 20.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.h),
            child: Text(
              text,
              style: AppConstantsTextStyle.kNormalWhiteTextStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget showText(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 7.h),
      child: Text(
        text,
        style: AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
      ),
    );
  }
}
