import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:modern_portfolio/navigation/section_container.dart';
import '../core/theme/theme_controller.dart';
import '../features/home/controller/home_controller.dart';
import '../features/home/home_screen.dart';
import '../features/about/about_screen.dart';
import '../features/projects/projects_screen.dart';
import '../features/skills/skills_screen.dart';
import '../features/contact/contact_screen.dart';

final GlobalKey homeKey = GlobalKey();
final GlobalKey aboutKey = GlobalKey();
final GlobalKey projectsKey = GlobalKey();
final GlobalKey skillsKey = GlobalKey();
final GlobalKey contactKey = GlobalKey();

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  final ThemeController themeController = Get.find<ThemeController>();
  final HomeController homeController = Get.put(HomeController());

  final List<String> sectionIds = [
    'home',
    'about',
    'projects',
    'skills',
    'contact',
  ];
  final List<GlobalKey> sectionKeys = [
    homeKey,
    aboutKey,
    projectsKey,
    skillsKey,
    contactKey,
  ];

  final List<String> _pageTitles = [
    'Home',
    'About',
    'Projects',
    'Skills',
    'Contact',
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
  void initState() {
    super.initState();
    homeController.initScrollTracking(
      sectionKeys: sectionKeys,
      sectionIds: sectionIds,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen =
        ResponsiveBreakpoints.of(context).isMobile ||
        ResponsiveBreakpoints.of(context).isTablet;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MY PORTFOLIO',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2),
        actions: [
          if (!isSmallScreen)
            Obx(() {
              return Row(
                children: List.generate(_pageTitles.length, (i) {
                  final isSelected =
                      homeController.selectedSection.value == sectionIds[i];

                  return Obx(() {
                    final isSelected =
                        homeController.selectedSection.value == sectionIds[i];
                    final isHovered = homeController.hoveredIndex.value == i;

                    return MouseRegion(
                      onEnter: (_) => homeController.setHoveredIndex(i),
                      onExit: (_) => homeController.setHoveredIndex(-1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextButton.icon(
                          onPressed: () => scrollToSection(sectionKeys[i]),
                          icon: Icon(
                            isSelected ? _pageSelectedIcons[i] : _pageIcons[i],
                            color:
                                isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : isHovered
                                    ? Colors.white
                                    : Colors.white,
                          ),
                          label: Text(
                            _pageTitles[i],
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : isHovered
                                      ? Colors.white
                                      : Colors.white,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                isSelected ? Colors.white : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color:
                                    isHovered && !isSelected
                                        ? Colors.white
                                        : Colors.transparent,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                }),
              );
            }),
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
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            baseColor: Color(0xffb181f5),
            spawnMinRadius: 1,
            spawnMaxRadius: 4,
            spawnMinSpeed: 10,
            spawnMaxSpeed: 60,
            particleCount: 60,
          ),
        ),
        vsync: this,
        child: SingleChildScrollView(
          controller: homeController.scrollController,
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
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
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
