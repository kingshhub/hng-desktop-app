import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String iconPath;
  final Color color;
  final int wallpaperCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.color,
    this.wallpaperCount = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconPath': iconPath,
      'color': color.value,
      'wallpaperCount': wallpaperCount,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      iconPath: json['iconPath'],
      color: Color(json['color']),
      wallpaperCount: json['wallpaperCount'] ?? 0,
    );
  }
}
