import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_crm/utilis/variables.dart';
import 'package:video_player/video_player.dart';

import 'video_view_screen.dart';

// ignore: must_be_immutable
class VideoUploadImage extends StatefulWidget {
  VideoUploadImage(
      {super.key,
      required this.videoUrl,
      required this.isSeletedValue,
      required this.videoId});
  final String videoUrl;
  final String videoId;
  bool isSeletedValue;
  @override
  State<VideoUploadImage> createState() => _VideoUploadImageState();
}

class _VideoUploadImageState extends State<VideoUploadImage> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
    Variables.selectedVideoUrl.add(widget.videoId);
    super.initState();
  }

  void _onCheckboxChanged(bool? newValue) {
    setState(() {
      if (widget.isSeletedValue) {
        Variables.selectedVideoUrl.add(widget.videoId);
      } else {
        Variables.selectedVideoUrl.remove(widget.videoId);
      }
    });
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
                    Positioned(
                      left: 37,
                      bottom: 35,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: widget.isSeletedValue,
                        onChanged: _onCheckboxChanged,
                      ),
                    )
                  ],
                )),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
