import 'package:flutter/cupertino.dart';
import 'package:video_optimiaztion/app_widget.dart';
import 'package:video_optimiaztion/core/application/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(AppWidget());
}
