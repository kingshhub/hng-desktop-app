import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../providers/wallpaper_provider.dart';
import '../providers/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider = Provider.of<WallpaperProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Container(
      height: AppSizes.appBarHeight,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : AppColors.cardBackground,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.white12 : AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
        child: Row(
          children: [
            // Search Bar
            Expanded(
              flex: 2,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radiusL),
                  border: Border.all(
                    color: isDark ? Colors.white12 : AppColors.divider,
                  ),
                ),
                child: TextField(
                  onChanged: (value) => wallpaperProvider.setSearchQuery(value),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDark ? AppColors.textDark : AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search wallpapers...',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textSecondary,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingM,
                      vertical: AppSizes.paddingM,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: AppSizes.paddingL),

            // Sort Dropdown
            Container(
              height: 44,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : AppColors.background,
                borderRadius: BorderRadius.circular(AppSizes.radiusL),
                border: Border.all(
                  color: isDark ? Colors.white12 : AppColors.divider,
                ),
              ),
              child: DropdownButton<SortOption>(
                value: wallpaperProvider.sortOption,
                underline: const SizedBox(),
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: isDark ? AppColors.textDark : AppColors.textPrimary,
                ),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColors.textDark : AppColors.textPrimary,
                ),
                dropdownColor: isDark
                    ? AppColors.darkCardBackground
                    : AppColors.cardBackground,
                items: const [
                  DropdownMenuItem(
                    value: SortOption.newest,
                    child: Text('Newest'),
                  ),
                  DropdownMenuItem(
                    value: SortOption.popular,
                    child: Text('Popular'),
                  ),
                  DropdownMenuItem(
                    value: SortOption.featured,
                    child: Text('Featured'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    wallpaperProvider.setSortOption(value);
                  }
                },
              ),
            ),

            const SizedBox(width: AppSizes.paddingM),
            // Grid/List View Toggle
            IconButton(
              icon: const Icon(Icons.grid_view_rounded),
              color: isDark ? AppColors.textDark : AppColors.textPrimary,
              onPressed: () {},
            ),
            const SizedBox(width: AppSizes.paddingS),
            // Settings Button
            IconButton(
              icon: const Icon(Icons.settings_rounded),
              color: isDark ? AppColors.textDark : AppColors.textPrimary,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
