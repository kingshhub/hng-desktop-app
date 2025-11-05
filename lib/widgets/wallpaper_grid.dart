import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_sizes.dart';
import '../providers/wallpaper_provider.dart';
import 'wallpaper_card.dart';

class WallpaperGrid extends StatelessWidget {
  const WallpaperGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider = Provider.of<WallpaperProvider>(context);
    final wallpapers = wallpaperProvider.wallpapers;

    if (wallpapers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No wallpapers found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingL),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppSizes.gridCrossAxisCount,
        crossAxisSpacing: AppSizes.gridSpacing,
        mainAxisSpacing: AppSizes.gridSpacing,
        childAspectRatio: AppSizes.gridChildAspectRatio,
      ),
      itemCount: wallpapers.length,
      itemBuilder: (context, index) {
        return WallpaperCard(wallpaper: wallpapers[index]);
      },
    );
  }
}
