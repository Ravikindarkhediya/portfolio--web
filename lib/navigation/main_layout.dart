import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_portfolio/navigation/section_container.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/theme_controller.dart';
import '../features/home/home_screen.dart';
import '../features/about/about_screen.dart';
import '../features/projects/projects_screen.dart';
import '../features/skills/skills_screen.dart';
import '../features/contact/contact_screen.dart';



// Section keys
final homeKey = GlobalKey();
final aboutKey = GlobalKey();
final projectsKey = GlobalKey();
final skillsKey = GlobalKey();
final contactKey = GlobalKey();

class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  final ScrollController scrollController = ScrollController();

  final List<String> _pageTitles = [
    "Home",
    "About",
    "Projects",
    "Skills",
    "Contact",
  ];

  final List<IconData> _pageIcons = [
    Icons.home_outlined,
    Icons.person_outline,
    Icons.work_outline,
    Icons.lightbulb_outline,
    Icons.mail_outline,
  ];

  final List<IconData> _pageSelectedIcons = [
    Icons.home,
    Icons.person,
    Icons.work,
    Icons.lightbulb,
    Icons.mail,
  ];

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: 500.ms,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen =
        ResponsiveBreakpoints.of(context).isMobile ||
        ResponsiveBreakpoints.of(context).isTablet;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Portfolio",
        ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2),
        actions: [
          if (!isSmallScreen)
            Row(
              children: List.generate(_pageTitles.length, (i) {
                final key =
                    [homeKey, aboutKey, projectsKey, skillsKey, contactKey][i];
                return TextButton.icon(
                  onPressed: () => scrollToSection(key),
                  icon: Icon(_pageIcons[i], color: Colors.black),
                  label: Text(
                    _pageTitles[i],
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }),
            ),
          IconButton(
            icon: Obx(
              () => Icon(
                themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
            onPressed: themeController.toggleTheme,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      drawer: isSmallScreen ? _buildDrawer(context) : null,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SectionContainer(key: homeKey, child: const HomeScreen()),
            SectionContainer(key: aboutKey, child: const AboutScreen()),
            SectionContainer(key: projectsKey, child: ProjectsScreen()),
            SectionContainer(key: skillsKey, child: const SkillsScreen()),
            SectionContainer(key: contactKey, child: ContactScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final sectionKeys = [homeKey, aboutKey, projectsKey, skillsKey, contactKey];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Text(
              'Menu',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
          for (int i = 0; i < _pageTitles.length; i++)
            ListTile(
              leading: Icon(_pageIcons[i]),
              title: Text(_pageTitles[i]),
              onTap: () {
                scrollToSection(sectionKeys[i]);
                Navigator.pop(context); // close drawer
              },
            ),
        ],
      ),
    );
  }
}
