import 'package:get/get.dart';
import '../features/about/about_screen.dart';
import '../features/contact/contact_screen.dart';
import '../features/home/home_screen.dart';
import '../features/projects/projects_screen.dart';
import '../features/skills/skills_screen.dart';
import 'main_layout.dart';

class AppPages {
  static const String initial = '/';

  static final routes = [
    GetPage(
      name: initial,
      page: () => MainLayout(),
    ),
  ];

  static List<GetPage> getAppPages() => routes;

  static final List<GetPage> mainScreens = [
    GetPage(name: '/home', page: () => const HomeScreen(), transition: Transition.fadeIn),
    GetPage(name: '/about', page: () => const AboutScreen(), transition: Transition.fadeIn),
    GetPage(name: '/projects', page: () => ProjectsScreen(), transition: Transition.fadeIn),
    GetPage(name: '/skills', page: () => const SkillsScreen(), transition: Transition.fadeIn),
    GetPage(name: '/contact', page: () => ContactScreen(), transition: Transition.fadeIn),
  ];
}