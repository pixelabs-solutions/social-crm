import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

import '../../viewModel/CustomerList_vm.dart';
import '../../viewModel/StatusDetails_viewModel.dart';
import '../auth/confirmationScreen.dart';
import 'adding_customer.dart';
import 'clientpage_screen.dart';

class CustomersList extends StatefulWidget {
  CustomersList({super.key});

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch customers when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomerViewModel>(context, listen: false).fetchCustomers();
    });
  }
  void _navigateToAddCustomer(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddingCustomerDetails()),
    );

    if (result == true) {
      // Refresh the customer list
      setState(() {
        Provider.of<CustomerViewModel>(context, listen: false).fetchCustomers();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const HomeAppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: ChangeNotifierProvider(
        create: (_) => CustomerViewModel()..fetchCustomers(),
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor: AppColors.orangeButtonColor,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32.h,
                        ),
                      ),
                      onPressed: () {
                        _navigateToAddCustomer(context);
                      },
                    ),
                    SizedBox(width: 8.w),
                    Padding(
                      padding: EdgeInsets.only(right: 12.0.w),
                      child: Center(
                        child: Text(
                          'לקוחות',
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
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
                  child: Consumer<CustomerViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.orangeButtonColor,
                          ),
                        );
                      }

                      return ScrollbarTheme(
                        data: ScrollbarThemeData(
                          thumbColor: MaterialStateProperty.all(AppColors.orangeButtonColor),
                          trackColor: MaterialStateProperty.all(AppColors.kWhiteColor40Opacity),
                          thickness: MaterialStateProperty.all(8.w),
                          radius: const Radius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Scrollbar(
                            interactive: true,
                            controller: scrollController,
                            thumbVisibility: true,
                            trackVisibility: true,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: viewModel.customers.length,
                                itemBuilder: (context, index) {
                                  final customer = viewModel.customers[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (o) => ClientPage(
                                            customer: customer,
                                          ),
                                        ),
                                      ).then((_) {
                                        // Refresh customers list after returning from ClientPage
                                        Provider.of<CustomerViewModel>(context, listen: false).fetchCustomers();
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5.h),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                (customer.active == 1)
                                                    ? Container(
                                                  height: 20.h,
                                                  width: 65.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: AppColors.statusContainerColor,
                                                  ),
                                                  child: Center(child: Text("Active")),
                                                )
                                                    : Container(
                                                  height: 20.h,
                                                  width: 65.w,
                                                ),
                                                Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "שם: ",
                                                        style: AppConstantsTextStyle.kSmallButtonBoldWhiteTextStyle,
                                                      ),
                                                      Text(
                                                        "${customer.name}",
                                                        style: AppConstantsTextStyle.kNormalWhiteNotoTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                                            child: const Divider(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
      padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 7.h, bottom: 2.h),
      child: Text(
        text,
        style: AppConstantsTextStyle.kNormalTextWeight800TextStyle,
      ),
    );
  }
}