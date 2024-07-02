import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';

import '../../viewModel/dashboard_viewModel.dart';
import 'StatusUploadScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel()..fetchDashboardData(),
      child: Scaffold(
        appBar: const HomeAppBar(),
        backgroundColor: AppColors.scaffoldColor,
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Consumer<DashboardViewModel>(
            builder: (context, model, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RoundedContainer(
                          color: AppColors.orangeButtonColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/faCalendar.svg",
                                height: 33,
                                width: 33,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                model.isLoading
                                    ? 'Loading...'
                                    : '${model.pendingAds}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'מודעות ממתינות',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RoundedContainer(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/userVector.svg",
                                height: 32,
                                width: 32,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                model.isLoading
                                    ? 'Loading...'
                                    : '${model.totalCustomers}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                'לקוחות ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "assets/backImg.jpeg",
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.275,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 15),
                                Text(
                                  "מספר הצופים הגבוה ביותר",
                                  style: AppConstantsTextStyle.paragraph1Style,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  model.isLoading
                                      ? 'Loading...'
                                      : '${model.highestViewers}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 14),
                                GestureDetector(
                                  onTap: () {
                                    // Handle button tap
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 22),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.orangeButtonColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.transparent,
                                    ),
                                    child: const Text(
                                      'פרסם לי את זה בסטטוס ←',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -35,
                        left: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          'assets/faEye.svg', // Replace with your SVG icon path
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {
                      model.fetchUpcomingStatus();
                      // // model.fetchTotalCustomers();
                      // // model.fetchHighestViewers();
                      // model.fetchPendingStatusCount();
                    },
                    child: RoundedContainer(
                      color: AppColors.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'הסטטוס הקרוב ב ',
                                style: AppConstantsTextStyle.heading2Style,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${model.scheduleDate ?? "No Upcoming Status"} ${model.scheduleTime ?? ""}'
                                    .trim(),
                                style: AppConstantsTextStyle.paragraph2Style,
                              )
                            ],
                          ),
                          const SizedBox(width: 13),
                          SvgPicture.asset(
                            "assets/faMobile.svg",
                            height: 40,
                            width: 35,
                          ),
                        ],
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
}

class RoundedContainer extends StatelessWidget {
  final Color color;
  final Widget child;

  const RoundedContainer({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
