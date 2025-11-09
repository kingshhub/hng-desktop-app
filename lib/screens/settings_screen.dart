import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTextStyles.heading2.copyWith(
            color: isDark ? AppColors.textDark : AppColors.textPrimary,
          ),
        ),
        backgroundColor:
            isDark ? AppColors.darkCardBackground : AppColors.cardBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Appearance', style: AppTextStyles.heading3),
            const SizedBox(height: AppSizes.paddingM),
            // Placeholder for real settings
            ListTile(
              title: const Text('Theme'),
              subtitle: const Text('Light / Dark / System'),
              leading: const Icon(Icons.palette_rounded),
              onTap: () {},
            ),
            const SizedBox(height: AppSizes.paddingL),
            const Text('About', style: AppTextStyles.heading3),
            const SizedBox(height: AppSizes.paddingM),
            ListTile(
              title: const Text('Version'),
              subtitle: const Text('1.0.0'),
              leading: const Icon(Icons.info_outline_rounded),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
