import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/wallpaper_model.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_sizes.dart';
import '../providers/wallpaper_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/wallpaper_card.dart';

class WallpaperDetailScreen extends StatelessWidget {
  final WallpaperModel wallpaper;

  const WallpaperDetailScreen({
    super.key,
    required this.wallpaper,
  });

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider = Provider.of<WallpaperProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final relatedWallpapers =
        wallpaperProvider.getRelatedWallpapers(wallpaper.id);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 500,
            pinned: true,
            backgroundColor: isDark
                ? AppColors.darkCardBackground
                : AppColors.cardBackground,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: isDark ? AppColors.textDark : AppColors.textPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  wallpaper.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: wallpaper.isFavorite
                      ? AppColors.accent
                      : (isDark ? AppColors.textDark : AppColors.textPrimary),
                ),
                onPressed: () {
                  wallpaperProvider.toggleFavorite(wallpaper.id);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.share_rounded,
                  color: isDark ? AppColors.textDark : AppColors.textPrimary,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: AppSizes.paddingS),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    wallpaper.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.primary.withOpacity(0.1),
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_rounded,
                            size: 64,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          (isDark
                                  ? AppColors.darkBackground
                                  : AppColors.background)
                              .withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingXL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Author
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wallpaper.title,
                              style: AppTextStyles.heading1.copyWith(
                                color: isDark
                                    ? AppColors.textDark
                                    : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppSizes.paddingS),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  child: Icon(Icons.person, size: 16),
                                ),
                                const SizedBox(width: AppSizes.paddingS),
                                Text(
                                  wallpaper.author,
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: isDark
                                        ? AppColors.textDarkSecondary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download_rounded),
                            label: const Text('Download'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.paddingL,
                                vertical: AppSizes.paddingM,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radiusL),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.paddingM),
                          OutlinedButton.icon(
                            onPressed: () {
                              wallpaperProvider
                                  .setActiveWallpaper(wallpaper.id);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Set Wallpaper'),
                                  content: const Text(
                                      'This will mark the wallpaper as active in the app. On Windows you can use the exported image to set as system wallpaper.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.check_rounded),
                            label: const Text('Set as Wallpaper'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: isDark
                                  ? AppColors.textDark
                                  : AppColors.textPrimary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.paddingL,
                                vertical: AppSizes.paddingM,
                              ),
                              side: const BorderSide(
                                color: AppColors.primary,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radiusL),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingXL),
                  // Stats Row
                  Row(
                    children: [
                      _buildStatCard(
                        icon: Icons.download_rounded,
                        label: 'Downloads',
                        value: wallpaper.downloads.toString(),
                        isDark: isDark,
                      ),
                      const SizedBox(width: AppSizes.paddingM),
                      _buildStatCard(
                        icon: Icons.aspect_ratio_rounded,
                        label: 'Resolution',
                        value: wallpaper.resolution,
                        isDark: isDark,
                      ),
                      const SizedBox(width: AppSizes.paddingM),
                      _buildStatCard(
                        icon: Icons.category_rounded,
                        label: 'Category',
                        value: wallpaper.category,
                        isDark: isDark,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.paddingXL),

                  // Tags Section
                  Text(
                    'Tags',
                    style: AppTextStyles.heading3.copyWith(
                      color:
                          isDark ? AppColors.textDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingM),
                  Wrap(
                    spacing: AppSizes.paddingS,
                    runSpacing: AppSizes.paddingS,
                    children: wallpaper.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              backgroundColor: isDark
                                  ? AppColors.primary.withOpacity(0.2)
                                  : AppColors.primary.withOpacity(0.1),
                              labelStyle: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: AppSizes.paddingXXL),

                  // Related Wallpapers
                  if (relatedWallpapers.isNotEmpty) ...[
                    Text(
                      'Related Wallpapers',
                      style: AppTextStyles.heading2.copyWith(
                        color:
                            isDark ? AppColors.textDark : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingL),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: relatedWallpapers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 220,
                            margin:
                                const EdgeInsets.only(right: AppSizes.paddingM),
                            child: WallpaperCard(
                              wallpaper: relatedWallpapers[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingL),
        decoration: BoxDecoration(
          color:
              isDark ? AppColors.darkCardBackground : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusL),
          border: Border.all(
            color: isDark ? Colors.white12 : AppColors.divider,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: AppSizes.iconL,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSizes.paddingS),
            Text(
              value,
              style: AppTextStyles.heading3.copyWith(
                color: isDark ? AppColors.textDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
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
