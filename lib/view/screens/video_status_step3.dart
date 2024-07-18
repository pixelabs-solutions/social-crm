import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:social_crm/Model/status.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:social_crm/utilis/constant_textstyles.dart';
import 'package:social_crm/utilis/variables.dart';
import 'package:social_crm/view/screens/calendar_screen.dart';
import 'package:social_crm/view/widgets/custom_appbar.dart';
import 'package:social_crm/view/widgets/custome_largebutton.dart';
import '../../Model/video.dart';
import '../../viewModel/status_viewmodel.dart';
import 'video_upload_img.dart';

class VideoUploadStep3Screen extends StatelessWidget {
  const VideoUploadStep3Screen({super.key, this.videoStatus});
  final VideoStatus? videoStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const HomeAppBar(),
      body: ChangeNotifierProvider(
        create: (_) => TextStatusViewModel(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
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
                    Center(
                      child: Text(
                        'העלאת סטטוס ',
                        style: AppConstantsTextStyle.heading1Style,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w, right: 8.w),
                child: Container(
                  height: MediaQuery.of(context).size.height *
                      0.5, // 70% of screen height
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "הסרטון נחתך בהצלחה!",
                          style: AppConstantsTextStyle.heading2Style,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0.h, horizontal: 16.w),
                            itemCount: videoStatus?.data?.length,
                            itemBuilder: (context, index) {
                              return GridTile(
                                  child: VideoUploadImage(
                                videoUrl: "${videoStatus?.data?[index].url}",
                                videoId: "${videoStatus?.data?[index].id}",
                                isSeletedValue: true,
                              )

                                  // _buildContainerWithIcon(),
                                  );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Consumer<TextStatusViewModel>(
                              builder: (context, viewModel, child) {
                            return ConstantLargeButton(
                                text: "לתזמון הסטטוס ←",
                                onPressed: () {
                                  if (Variables.selectedVideoUrl.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (i) =>
                                                CalendarScreen(
                                                  statusData: StatusData(
                                                      contentType: "video"),
                                                )));
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'Please select one video atleast',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                });
                          }),
                        )
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


}
