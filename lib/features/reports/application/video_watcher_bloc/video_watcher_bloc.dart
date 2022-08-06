import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'video_watcher_bloc.freezed.dart';
part 'video_watcher_event.dart';
part 'video_watcher_state.dart';

@injectable
class VideoWatcherBloc extends Bloc<VideoWatcherEvent, VideoWatcherState> {
  List<List<String>> reportsLink = [
    [
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/416-2022_July_28_041857-Screenshot_2022-07-25-13-12-18-640_com.naxa.shaasa_88p7ta4.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210055Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=c0d8fcd2a810372eccc5e66cf77eebfd4b6e1743bcf88277a77aa0bd73e7a5d7",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/409-2022_July_26_044912-3f81152c-24e1-4b85-ba1f-068bdb74fb8a88475607370333_wEcu9oW.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210055Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=d1d7198e4f60fbf91a5dbca1b8ab862585db2be51a4e71b8183e800a0aa2f042",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/405-2022_July_24_121233-febb66e5-fab2-4794-b32c-75cd9676e4d318773221277748_YKlEEGS.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210055Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=bd662b8373b48a90e1022fe974f391bc7f73cba9bd908a85e1d7f2d46ab12b2b",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/392-2022_July_13_085351-47bf8053-b069-4dd8-849d-9801bb498de879875365696569_SwrsY4x.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210055Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=ab876c7bc1f7d310d8302d997f4b464478bc0223cca7e5246e919b449b506e7d"
    ],
    [
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/387-2022_July_04_044120-20220703_112624_compressed5410843792032916975.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210055Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=8299989980c4e58c85b4e5e0c636a14b0b7cebc8daf8405291c217827ddcbcbb",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/229-2022_June_08_133642-VID_2022-06-08_07-21-29.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210831Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=72794450722a3f56b2dfbb87f743c13457b059ce0060c72d7fe98adec89b2c76",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/387-2022_July_04_044125-20220703_112631_compressed2835980801119752733.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210055Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=3f1cab40bf0c0fd46b097640a5bfaed6c11013584cb9ef7211540ff617ecbc2a",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/382-2022_June_28_142806-IMG_20220624_195819_compressed4161902257699022932.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210449Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=fd6e841e90292090cb38d94d79a6f591e574818111a0f0c9088a2e76ca3fbdce"
    ],
    [
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/321-2022_June_19_203338-Screenshot_2022-06-19-20-14-14-89_compressed710833_AksPPWn.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210449Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=c4813d9d28884d7afd044c8a7ac0fdb359ef2095d41354ddd582f3a98a3f1c2b",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/381-2022_June_28_063248-VID_2022-06-28_12-17-04.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210449Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=da5f47605dc506711bedbc3e92e916977b4fdb34558637060d465c87fa1f82e8",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/321-2022_June_19_203339-Screenshot_2022-06-19-20-14-03-32_compressed502065_eTdio6I.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210449Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=461954d097db0cb9dcbceea530bbf1d873102d3400deb1e0838af9a580270409"
    ],
    [
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/272-2022_June_11_042133-VID_2022-06-11_10-06-22.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210449Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=637a749052e77f2020b0d20be289ea81139bfe535aafcbaab58504bde6df80f0",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/272-2022_June_11_042135-IMG_20220610_201730_compressed4805284811929395718.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210449Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=bc86ca3483c62a9b8a6e4d920d2f15293fb822bde07800c4569ded8e693f4da5",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/241-2022_June_10_053002-VID_2022-06-10_11-15-01.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210717Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=fb90011f4a8154d9a8dbdfa47c7744d59c4d59162d4a3441b603482f64cf2b73"
    ],
    [
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/239-2022_June_10_052225-VID_2022-06-10_11-07-24.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210717Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=7be5860082eba887b500bee99ac8459ce05bcc8999eb76333bd638689f9af190",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/231-2022_June_09_044648-VID_2022-06-09_10-31-43.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210831Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=e50a31dda79e98cb22d49c25d2a755b9d31ee91b9d3548d87032286c24dfb4df",
      "https://sashaan-mobile.s3.amazonaws.com/privateuploads/reports/files/230-2022_June_08_143401-VID_2022-06-08_08-18-54.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ7LFYEFSZ3V6FRG4%2F20220806%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20220806T210831Z&X-Amz-Expires=604799&X-Amz-SignedHeaders=host&X-Amz-Signature=bf37e7bd0b64866fd819cdd1423e1ebf8596c2361c31640edc2ef4a1016b5b0c",
    ]
  ];
  VideoWatcherBloc() : super(VideoWatcherState.initial()) {
    on<VideoWatcherEvent>(
      (event, emit) async {
        event.map(
          fetchVideos: (e) {
            List<List<dynamic>> temp = [];

            for (List<String> e in reportsLink) {
              List<dynamic> data = [];
              for (String s in e) {
                if (s.split('?').first.toLowerCase().contains('mp4')) {
                  data.add(CachedVideoPlayerController.network(s));
                } else {
                  data.add(
                    CachedNetworkImage(
                      imageUrl: s,
                    ),
                  );
                }
              }
              temp.add(data);
            }

            for (int i = 0; i < temp.length; i++) {
              for (int j = 0; j < temp[i].length; j++) {
                if (temp[i][j] is CachedVideoPlayerController) {
                  (temp[i][j] as CachedVideoPlayerController).initialize();
                }
              }
            }

            emit(state.copyWith(reportFiles: temp));
          },
          videoInitialize: (e) {
            // index checking [0 or 0,1]
            if (e.id.length - 1 < 1) {
              if (e.id[0] > 0 && e.id[0] < state.reportFiles.length) {
                for (var b in state.reportFiles[e.id[0] - 1]) {
                  if (b is CachedVideoPlayerController) {
                    b.pause();
                  }
                }
                for (var f in state.reportFiles[e.id[0] + 1]) {
                  if (f is CachedVideoPlayerController) {
                    f.pause();
                  }
                }
              }
              if (e.id[0] == 0) {
                for (var f in state.reportFiles[e.id[0] + 1]) {
                  if (f is CachedVideoPlayerController) {
                    f.pause();
                  }
                }
              }
              if (e.id[0] == state.reportFiles.length - 1) {
                for (var f in state.reportFiles[e.id[0] - 1]) {
                  if (f is CachedVideoPlayerController) {
                    f.pause();
                  }
                }
              }
            } else {
              if (e.id[1] > 0 && e.id[1] < state.reportFiles[e.id[0]].length) {
                for (int i = e.id[1] - 1; i > i - 1; i--) {
                  if (state.reportFiles[e.id[0]][i]
                      is CachedVideoPlayerController) {
                    state.reportFiles[e.id[0]][i].pause();
                  }
                }
                for (int j = e.id[1] + 1;
                    j < state.reportFiles[e.id[0]].length;
                    j++) {
                  if (state.reportFiles[e.id[0]][j]
                      is CachedVideoPlayerController) {
                    state.reportFiles[e.id[0]][j].pause();
                  }
                }
              }

              if (e.id[1] == 0) {
                for (int j = e.id[1] + 1;
                    j < state.reportFiles[e.id[0]].length;
                    j++) {
                  if (state.reportFiles[e.id[0]][j]
                      is CachedVideoPlayerController) {
                    state.reportFiles[e.id[0]][j].pause();
                  }
                }
              }
              if (e.id[1] == state.reportFiles.length - 1) {
                for (int i = e.id[1] - 1; i > i - 1; i--) {
                  if (state.reportFiles[e.id[0]][i]
                      is CachedVideoPlayerController) {
                    state.reportFiles[e.id[0]][i].pause();
                  }
                }
              }
            }
          },
          pausePlayVideo: (value) {},
        );
      },
    );
  }
}
