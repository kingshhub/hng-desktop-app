import 'package:flutter/material.dart';
import '../widgets/sidebar_navigation.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/wallpaper_grid.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'downloads_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedMenu = 'Home';

  void _onMenuSelected(String menu) {
    setState(() {
      _selectedMenu = menu;
    });
  }

  Widget _buildMainContent() {
    switch (_selectedMenu) {
      case 'Favorites':
        return const FavoritesScreen();
      case 'Downloads':
        return const DownloadsScreen();
      case 'Settings':
        return const SettingsScreen();
      case 'Home':
      default:
        return const WallpaperGrid();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedMenu: _selectedMenu,
            onMenuSelected: _onMenuSelected,
          ),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // App Bar
                const CustomAppBar(),

                // Main Area
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
