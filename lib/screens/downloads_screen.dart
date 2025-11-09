import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: Text(
          'Downloads',
          style: AppTextStyles.heading2.copyWith(
            color: isDark ? AppColors.textDark : AppColors.textPrimary,
          ),
        ),
        backgroundColor:
            isDark ? AppColors.darkCardBackground : AppColors.cardBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingL),
        child: Center(
          child: Text(
            'No downloads yet',
            style: AppTextStyles.heading3.copyWith(
              color: isDark
                  ? AppColors.textDarkSecondary
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
