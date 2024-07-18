import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_crm/utilis/constant_colors.dart';
import 'package:video_player/video_player.dart';

import 'video_view_screen.dart';

class VideoImage extends StatefulWidget {
  const VideoImage({super.key, required this.videoUrl});
  final String videoUrl;
  @override
  State<VideoImage> createState() => _VideoImageState();
}

class _VideoImageState extends State<VideoImage> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController.value.isInitialized
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    VideoPlayer(videoPlayerController),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (i) => VideoViewScreen(
                                    videoUrl: widget.videoUrl.toString(),
                                  )),
                        );
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                )),
          )
        : const Center(child: CircularProgressIndicator(
      color: AppColors.orangeButtonColor,
    ));
  }
}
