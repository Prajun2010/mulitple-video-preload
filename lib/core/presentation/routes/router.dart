import 'package:auto_route/annotations.dart';
import 'package:video_optimiaztion/features/reports/presentation/pages/video_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: VideoPage, initial: true),
  ],
)
class $AppRouter {}
