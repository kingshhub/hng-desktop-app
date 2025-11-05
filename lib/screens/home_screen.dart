import 'package:flutter/material.dart';
import '../widgets/sidebar_navigation.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/wallpaper_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // App Bar
                CustomAppBar(),

                // Wallpaper Grid
                Expanded(
                  child: WallpaperGrid(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
