import 'dart:developer';
import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path_provider/path_provider.dart';

class VideoSplitter {
  // Future<List<File>> splitVideo(File? videoFile) async {
  //   final List<File> segmentedFiles = [];

  //   try {
  //     // Get video duration
  //     final duration = await _getVideoDuration(videoFile!);
  //     if (duration == null) {
  //       throw Exception('Failed to determine video duration');
  //     }

  //     const segmentDuration = 10; // Segment duration in seconds
  //     int startTime = 0;
  //     int segmentIndex = 1;

  //     // Create a temporary directory for segments
  //     final tempDir = await getTemporaryDirectory();

  //     // Loop through video, creating segments
  //     while (startTime < duration) {
  //       final segmentFileName = '${tempDir.path}/segment_$segmentIndex.mp4';
  //       final command =
  //           '-i ${videoFile.path} -ss ${_formatDuration(startTime)} -t $segmentDuration -c copy $segmentFileName';

  //       final session = await FFmpegKit.executeAsync(command, (session) async {
  //         final returnCode = await session.getReturnCode();
  //         if (ReturnCode.isSuccess(returnCode)) {
  //           segmentedFiles.add(File(segmentFileName));
  //         } else if (ReturnCode.isCancel(returnCode)) {
  //           log('FFmpeg session canceled');
  //         } else {
  //           log('FFmpeg error (code: $returnCode)');
  //         }
  //       });
  //     }

  //     return segmentedFiles;
  //   } catch (error) {
  //     log('Error splitting video: $error');
  //     return [];
  //   } finally {
  //     // Clean up temporary directory (optional)
  //     // tempDir.delete(recursive: true); // Uncomment if needed
  //   }
  // }

  // Future<int?> _getVideoDuration(File videoFile) async {
  //   final session =
  //       await FFmpegKit.execute('-i ${videoFile.path} -hide_banner');
  //   final output = await session.getOutput();

  //   final durationRegex = RegExp(r'Duration: (\d+):(\d+):(\d+)\.(\d+)');
  //   final match = durationRegex.firstMatch(output!);

  //   if (match != null) {
  //     final hours = int.parse(match.group(1)!);
  //     final minutes = int.parse(match.group(2)!);
  //     final seconds = int.parse(match.group(3)!);
  //     return hours * 3600 + minutes * 60 + seconds;
  //   }

  //   return null;
  // }

  // String _formatDuration(int seconds) {
  //   final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
  //   final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
  //   final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
  //   return '$hours:$minutes:$remainingSeconds';
  // }

  Future<List<File>> splitVideo(File? videoFile) async {
    List<File> segmentedFiles = [];

    FFmpegKit.executeAsync(
        '-i ${videoFile?.path} -ss 00:00:00 -t 00:00:10 -c copy smallfile1.mp4',
        (session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        // SUCCESS
        segmentedFiles.add(File("samll1.mp4"));
      } else if (ReturnCode.isCancel(returnCode)) {
        // CANCEL
      } else {
        // ERROR
        log("error");
      }
    }).then((value) {
      log(value.toString());
    });

    return segmentedFiles;
  }
}
