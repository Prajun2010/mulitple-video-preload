part of 'video_watcher_bloc.dart';

@freezed
class VideoWatcherEvent with _$VideoWatcherEvent {
  const factory VideoWatcherEvent.fetchVideos() = _FetchVideos;
  const factory VideoWatcherEvent.videoInitialize({required List<int> id}) =
      _VideoInitialize;
  const factory VideoWatcherEvent.pausePlayVideo({required List<int> id}) =
      _PausePlayVideo;
}
