import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unipark_uitm_app/firebase_options.dart';
import 'package:unipark_uitm_app/src/features/authentication/presentation/pages/welcome_page.dart';
import 'package:unipark_uitm_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:unipark_uitm_app/src/utils/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.android)
      .then((value) => Get.put(AuthenticationRepository()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomePage(),
    );
  }
}
