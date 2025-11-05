import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../providers/category_provider.dart';
import '../providers/theme_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: Text(
          'Categories',
          style: AppTextStyles.heading2.copyWith(
            color: isDark ? AppColors.textDark : AppColors.textPrimary,
          ),
        ),
        backgroundColor:
            isDark ? AppColors.darkCardBackground : AppColors.cardBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXL),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppSizes.paddingL,
            mainAxisSpacing: AppSizes.paddingL,
            childAspectRatio: 1.5,
          ),
          itemCount: categoryProvider.categories.length,
          itemBuilder: (context, index) {
            final category = categoryProvider.categories[index];
            return _buildCategoryCard(
              category: category,
              isDark: isDark,
              onTap: () {
                categoryProvider.selectCategory(category.id);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required category,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: category.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          border: Border.all(
            color: category.color.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_rounded,
              size: 48,
              color: category.color,
            ),
            const SizedBox(height: AppSizes.paddingM),
            Text(
              category.name,
              style: AppTextStyles.heading3.copyWith(
                color: isDark ? AppColors.textDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSizes.paddingS),
            Text(
              '${category.wallpaperCount} wallpapers',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark
                    ? AppColors.textDarkSecondary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
