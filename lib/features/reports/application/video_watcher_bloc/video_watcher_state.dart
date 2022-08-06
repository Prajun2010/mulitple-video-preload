part of 'video_watcher_bloc.dart';

@freezed
class VideoWatcherState with _$VideoWatcherState {
  const factory VideoWatcherState({
    required List<List<dynamic>> reportFiles,
  }) = _VideoWatcherState;
  factory VideoWatcherState.initial() =>
      const VideoWatcherState(reportFiles: []);
}
