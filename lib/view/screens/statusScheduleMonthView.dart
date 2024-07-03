import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/Model/statuslist.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/utilis/variables.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import '../../viewModel/Status_viewModel.dart';
import 'pagestatus_dailyposting_schedule.dart';
import 'text_edit_screen.dart';

class StatusScheduleMonthView extends StatefulWidget {
  const StatusScheduleMonthView({
    super.key,
    required this.selectedDate,
    required this.status,
  });
  final DateTime selectedDate;
  final List<Statuses>? status;
  @override
  State<StatusScheduleMonthView> createState() =>
      _StatusScheduleMonthViewState();
}

class _StatusScheduleMonthViewState extends State<StatusScheduleMonthView> {
  late DateTime _selectedDate;
  final viewModel = TextStatusViewModel();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    viewModel.getSpecficStatus(_selectedDate.toString());
  }

  _goToNextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
    viewModel.getSpecficStatus(_selectedDate.toString());
  }

  _goToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
    viewModel.getSpecficStatus(_selectedDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const HomeAppBar(),
      body: ChangeNotifierProvider(
        create: (_) => viewModel,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
                    Text(
                      'העלאת סטטוס',
                      style: AppConstantsTextStyle.heading1Style,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0.h),
              Padding(
                padding: EdgeInsets.only(left: 14.0.w, right: 8.w),
                child: Container(
                  height: 350.0.h, // Static height for the container
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 14.0),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(Icons.arrow_back_ios_outlined,
                                      color: Colors.white),
                                ),
                                onPressed: () => _goToPreviousDay(),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                                style: AppConstantsTextStyle.heading1Style,
                              ),
                              IconButton(
                                icon: const CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(Icons.arrow_forward_ios_outlined,
                                      color: Colors.white),
                                ),
                                onPressed: () => _goToNextDay(),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 2, color: Colors.white),
                        Expanded(
                          child: Consumer<TextStatusViewModel>(
                              builder: (context, viewModel, child) {
                            if (viewModel.isSpecficLoading) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: AppColors.orangeButtonColor,
                              ));
                            }
                            if (viewModel.statusSpecificList!.data!.statuses!
                                .isNotEmpty) {
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                        Variables.hours.length, (index) {
                                      String currentHour =
                                          Variables.hours[index].split(":")[0];
                                      List<Statuses> hourStatuses =
                                          filterStatusesByHour(
                                              viewModel.statusSpecificList?.data
                                                  ?.statuses,
                                              currentHour);
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 0.8,
                                                  color: Colors.white
                                                      .withOpacity(0.46),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                Variables.hours[index],
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.orange),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 40.h,
                                            width: double.maxFinite,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: hourStatuses.length,
                                              itemBuilder:
                                                  (context, statusIndex) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (hourStatuses[
                                                                statusIndex]
                                                            .statusType ==
                                                        "text") {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TextEditScreen(
                                                                    statusData:
                                                                        hourStatuses[
                                                                            statusIndex])),
                                                      );
                                                    } else {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DailyPostingSchedule(
                                                                    statusData:
                                                                        hourStatuses[
                                                                            statusIndex])),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        color: const Color(
                                                                0xffF7F7F7)
                                                            .withOpacity(0.17)),
                                                    child: Row(
                                                      children: [
                                                        hourStatuses[statusIndex]
                                                                    .statusType ==
                                                                "text"
                                                            ? const Text(
                                                                "A",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : SvgPicture.asset(
                                                                "assets/smalImgIcon.svg"),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          DateFormat("h:mm")
                                                              .format(DateFormat(
                                                                      "HH:mm:ss")
                                                                  .parse(
                                                                      "${hourStatuses[statusIndex].scheduleTime}")),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .orange),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    })),
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  "No Status Were Found",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              );
                            }
                          }),
                        ),
                      ],
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

  List<Statuses> filterStatusesByHour(List<Statuses>? statuses, String hour) {
    return statuses!
        .where((status) => getHourFromTime("${status.scheduleTime}") == hour)
        .toList();
  }

  String getHourFromTime(String time) {
    return time.split(":")[0]; // Extract the hour from the time
  }
}
