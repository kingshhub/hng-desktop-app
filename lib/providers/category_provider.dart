import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../data/dummy_data.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  String? _selectedCategoryId;

  List<CategoryModel> get categories => _categories;
  String? get selectedCategoryId => _selectedCategoryId;

  CategoryModel? get selectedCategory {
    if (_selectedCategoryId == null) return null;
    return _categories.firstWhere(
      (cat) => cat.id == _selectedCategoryId,
      orElse: () => _categories.first,
    );
  }

  CategoryProvider() {
    _loadCategories();
  }

  void _loadCategories() {
    _categories = DummyData.categories;
    notifyListeners();
  }

  void selectCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void clearSelectedCategory() {
    _selectedCategoryId = null;
    notifyListeners();
  }

  List<CategoryModel> searchCategories(String query) {
    if (query.isEmpty) return _categories;
    return _categories
        .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
