import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_portfolio/features/about/widgets/about_controller.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'navigation/app_pages.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  Animate.restartOnHotReload = true;
  runApp(const MyApp());
  Get.put(AboutController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(
          () => GetMaterialApp(
        title: 'My Portfolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        initialRoute: AppPages.initial,
        getPages: AppPages.getAppPages(),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1920, name: DESKTOP),
            Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}