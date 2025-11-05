import 'package:flutter/material.dart';
import '../models/wallpaper_model.dart';
import '../data/dummy_data.dart';

class WallpaperProvider extends ChangeNotifier {
  List<WallpaperModel> _wallpapers = [];
  List<WallpaperModel> _favorites = [];
  String _searchQuery = '';
  String? _selectedCategory;
  SortOption _sortOption = SortOption.newest;

  List<WallpaperModel> get wallpapers => _getFilteredWallpapers();
  List<WallpaperModel> get favorites => _favorites;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  SortOption get sortOption => _sortOption;

  WallpaperProvider() {
    _loadWallpapers();
    _loadFavorites();
  }

  void _loadWallpapers() {
    _wallpapers = DummyData.wallpapers;
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    // TODO: Load from SharedPreferences in production
    _favorites = _wallpapers.where((w) => w.isFavorite).toList();
    notifyListeners();
  }

  List<WallpaperModel> _getFilteredWallpapers() {
    var filtered = List<WallpaperModel>.from(_wallpapers);

    // Apply category filter
    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      filtered =
          filtered.where((w) => w.category == _selectedCategory).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((w) =>
              w.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              w.tags.any((tag) =>
                  tag.toLowerCase().contains(_searchQuery.toLowerCase())) ||
              w.author.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply sorting
    switch (_sortOption) {
      case SortOption.newest:
        // Keep original order
        break;
      case SortOption.popular:
        filtered.sort((a, b) => b.downloads.compareTo(a.downloads));
        break;
      case SortOption.featured:
        filtered.sort((a, b) {
          if (a.isFeatured == b.isFeatured) return 0;
          return a.isFeatured ? -1 : 1;
        });
        break;
    }

    return filtered;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  Future<void> toggleFavorite(String wallpaperId) async {
    final index = _wallpapers.indexWhere((w) => w.id == wallpaperId);
    if (index != -1) {
      _wallpapers[index].isFavorite = !_wallpapers[index].isFavorite;

      if (_wallpapers[index].isFavorite) {
        _favorites.add(_wallpapers[index]);
      } else {
        _favorites.removeWhere((w) => w.id == wallpaperId);
      }

      // Save to SharedPreferences in production
      notifyListeners();
    }
  }

  WallpaperModel? getWallpaperById(String id) {
    try {
      return _wallpapers.firstWhere((w) => w.id == id);
    } catch (e) {
      return null;
    }
  }

  List<WallpaperModel> getRelatedWallpapers(String wallpaperId) {
    final wallpaper = getWallpaperById(wallpaperId);
    if (wallpaper == null) return [];

    return _wallpapers
        .where((w) => w.category == wallpaper.category && w.id != wallpaperId)
        .take(6)
        .toList();
  }
}

enum SortOption {
  newest,
  popular,
  featured,
}
