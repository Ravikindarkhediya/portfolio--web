import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/theme/theme_controller.dart';
import 'app_pages.dart';
import 'navigation_controller.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final NavigationController navController = Get.put(NavigationController());
  final ThemeController themeController = Get.find<ThemeController>();

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

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = ResponsiveBreakpoints.of(context).isMobile ||
        ResponsiveBreakpoints.of(context).isTablet;

    return Scaffold(
      appBar: AppBar(
        title: Obx(
              () => Text(
            _pageTitles[navController.selectedIndex.value],
          ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2, end: 0),
        ),
        actions: [
          if (!isSmallScreen)
           Obx(()=> Row(
             children: List.generate(
               _pageTitles.length,
                   (i) => TextButton.icon(
                 onPressed: () => navController.changePage(i),
                 label: Text(
                   _pageTitles[i],
                   style: TextStyle(
                     color: navController.selectedIndex.value == i
                         ? Colors.white
                         : Colors.black,
                   ),
                 ),
                 icon: Icon(
                   navController.selectedIndex.value == i
                       ? _pageSelectedIcons[i]
                       : _pageIcons[i],
                   color: navController.selectedIndex.value == i
                       ? Colors.white
                       : Colors.black,
                 ),

               ),
             ),
           ),),
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
      body: Obx(
            () => AppPages.mainScreens[navController.selectedIndex.value].page(),
      ),
      bottomNavigationBar: isSmallScreen ? _buildBottomNavigationBar() : null,
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
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
          for (int i = 0; i < _pageTitles.length; i++)
            Obx(
                  () => ListTile(
                leading: Icon(
                  navController.selectedIndex.value == i
                      ? _pageSelectedIcons[i]
                      : _pageIcons[i],
                  color: navController.selectedIndex.value == i
                      ? Theme.of(context).colorScheme.secondary
                      : (themeController.isDarkMode.value
                      ? Colors.white70
                      : Colors.black54),
                ),
                title: Text(
                  _pageTitles[i],
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                selected: navController.selectedIndex.value == i,
                selectedTileColor: Theme.of(context)
                    .colorScheme
                    .secondary
                    .withOpacity(0.2),
                onTap: () {
                  navController.changePage(i);
                  Navigator.pop(context); // Close drawer
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
          () => BottomNavigationBar(
        currentIndex: navController.selectedIndex.value,
        onTap: navController.changePage,
        type: BottomNavigationBarType.fixed,
        items: [
          for (int i = 0; i < _pageTitles.length; i++)
            BottomNavigationBarItem(
              icon: Icon(_pageIcons[i]),
              activeIcon: Icon(_pageSelectedIcons[i]),
              label: _pageTitles[i],
            ),
        ],
      ),
    ).animate().slideY(begin: 1, end: 0, duration: 300.ms);
  }
}
