import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../application/video_watcher_bloc/video_watcher_bloc.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoWatcherBloc, VideoWatcherState>(
      builder: (context, state) {
        return state.reportFiles.isNotEmpty
            ? PageView.builder(
                itemCount: state.reportFiles.length,
                scrollDirection: Axis.vertical,
                onPageChanged: (v) {
                  context
                      .read<VideoWatcherBloc>()
                      .add(VideoWatcherEvent.videoInitialize(id: [v]));
                },
                itemBuilder: (context, index) => ReportView(
                  data: state.reportFiles[index],
                  reportIndex: index,
                ),
              )
            : Container();
      },
    );
  }
}

class ReportView extends StatelessWidget {
  final int reportIndex;
  final List<dynamic> data;
  const ReportView({
    Key? key,
    required this.data,
    required this.reportIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        onPageChanged: (value) => context
            .read<VideoWatcherBloc>()
            .add(VideoWatcherEvent.videoInitialize(id: [reportIndex, value])),
        itemCount: data.length,
        itemBuilder: (context, index) {
          if (data[index] is CachedVideoPlayerController) {
            CachedVideoPlayerController controller = data[index];
            return VideoViewer(controller: controller);
          } else {
            return data[index];
          }
        });
  }
}

class VideoViewer extends StatefulWidget {
  CachedVideoPlayerController controller;
  VideoViewer({Key? key, required this.controller}) : super(key: key);

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> with WidgetsBindingObserver {
  @override
  void initState() {
    widget.controller.play();
    widget.controller.setLooping(true);
    WidgetsBinding.instance?.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.controller.pause();
        });
      },
      child: CachedVideoPlayer(widget.controller),
    );
  }
}
