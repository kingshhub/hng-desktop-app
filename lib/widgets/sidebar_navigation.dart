import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../providers/category_provider.dart';
import '../providers/theme_provider.dart';

class SidebarNavigation extends StatefulWidget {
  final String selectedMenu;
  final ValueChanged<String>? onMenuSelected;

  const SidebarNavigation(
      {super.key, this.selectedMenu = 'Home', this.onMenuSelected});

  @override
  State<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {
  late String _selectedMenu;

  @override
  void initState() {
    super.initState();
    _selectedMenu = widget.selectedMenu;
  }

  @override
  void didUpdateWidget(covariant SidebarNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedMenu != widget.selectedMenu) {
      _selectedMenu = widget.selectedMenu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    return Container(
      width: AppSizes.sidebarWidth,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : AppColors.cardBackground,
        border: Border(
          right: BorderSide(
            color: isDark ? Colors.white12 : AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Section
          Container(
            height: AppSizes.appBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.radiusM),
                  ),
                  child: const Icon(
                    Icons.wallpaper_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSizes.paddingM),
                Text(
                  'Wallpapers',
                  style: AppTextStyles.heading3.copyWith(
                    color: isDark ? AppColors.textDark : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Navigation Menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              children: [
                _buildMenuItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isSelected: _selectedMenu == 'Home',
                  onTap: () {
                    setState(() => _selectedMenu = 'Home');
                    widget.onMenuSelected?.call('Home');
                  },
                  isDark: isDark,
                ),
                _buildMenuItem(
                  icon: Icons.favorite_rounded,
                  label: 'Favorites',
                  isSelected: _selectedMenu == 'Favorites',
                  onTap: () {
                    setState(() => _selectedMenu = 'Favorites');
                    widget.onMenuSelected?.call('Favorites');
                  },
                  isDark: isDark,
                ),
                _buildMenuItem(
                  icon: Icons.download_rounded,
                  label: 'Downloads',
                  isSelected: _selectedMenu == 'Downloads',
                  onTap: () {
                    setState(() => _selectedMenu = 'Downloads');
                    widget.onMenuSelected?.call('Downloads');
                  },
                  isDark: isDark,
                ),

                const SizedBox(height: AppSizes.paddingL),

                // Categories Section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM,
                    vertical: AppSizes.paddingS,
                  ),
                  child: Text(
                    'CATEGORIES',
                    style: AppTextStyles.overline.copyWith(
                      color: isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingS),

                ...categoryProvider.categories.map(
                  (category) => _buildCategoryItem(
                    label: category.name,
                    count: category.wallpaperCount,
                    color: category.color,
                    isSelected:
                        categoryProvider.selectedCategoryId == category.id,
                    onTap: () {
                      if (categoryProvider.selectedCategoryId == category.id) {
                        categoryProvider.clearSelectedCategory();
                      } else {
                        categoryProvider.selectCategory(category.id);
                      }
                    },
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),

          // Theme Toggle
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: isDark
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  label: isDark ? 'Light Mode' : 'Dark Mode',
                  isSelected: false,
                  onTap: () => themeProvider.toggleTheme(),
                  isDark: isDark,
                ),
                const SizedBox(height: AppSizes.paddingS),
                _buildMenuItem(
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  isSelected: _selectedMenu == 'Settings',
                  onTap: () {
                    setState(() => _selectedMenu = 'Settings');
                    widget.onMenuSelected?.call('Settings');
                  },
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingM,
              vertical: AppSizes.paddingM,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: AppSizes.iconM,
                  color: isSelected
                      ? AppColors.primary
                      : (isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textSecondary),
                ),
                const SizedBox(width: AppSizes.paddingM),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                              ? AppColors.textDark
                              : AppColors.textPrimary),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem({
    required String label,
    required int count,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingS),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingM,
              vertical: AppSizes.paddingM,
            ),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSizes.paddingM),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color:
                          isDark ? AppColors.textDark : AppColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  count.toString(),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.textDarkSecondary
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
