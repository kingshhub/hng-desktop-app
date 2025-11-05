import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../providers/wallpaper_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/wallpaper_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider = Provider.of<WallpaperProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final favorites = wallpaperProvider.favorites;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: AppTextStyles.heading2.copyWith(
            color: isDark ? AppColors.textDark : AppColors.textPrimary,
          ),
        ),
        backgroundColor:
            isDark ? AppColors.darkCardBackground : AppColors.cardBackground,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 64,
                    color: isDark
                        ? AppColors.textDarkSecondary
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSizes.paddingM),
                  Text(
                    'No favorites yet',
                    style: AppTextStyles.heading3.copyWith(
                      color: isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingS),
                  Text(
                    'Start adding wallpapers to your favorites',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppSizes.paddingL),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: AppSizes.gridCrossAxisCount,
                crossAxisSpacing: AppSizes.gridSpacing,
                mainAxisSpacing: AppSizes.gridSpacing,
                childAspectRatio: AppSizes.gridChildAspectRatio,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return WallpaperCard(wallpaper: favorites[index]);
              },
            ),
    );
  }
}
