import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_optimiaztion/core/application/injection.dart';
import 'package:video_optimiaztion/core/presentation/routes/router.gr.dart';

import 'features/reports/application/video_watcher_bloc/video_watcher_bloc.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();
  AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<VideoWatcherBloc>()..add(const VideoWatcherEvent.fetchVideos()),
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
