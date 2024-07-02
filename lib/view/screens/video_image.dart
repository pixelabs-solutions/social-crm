import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                VideoPlayer(videoPlayerController),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    CupertinoIcons.play_circle,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ],
            ))
        : const Center(child: CircularProgressIndicator.adaptive());
  }
}
