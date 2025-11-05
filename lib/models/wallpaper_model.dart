class WallpaperModel {
  final String id;
  final String title;
  final String imageUrl;
  final String category;
  final String author;
  final int downloads;
  final List<String> tags;
  final String resolution;
  final bool isFeatured;
  bool isFavorite;

  WallpaperModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.author,
    this.downloads = 0,
    this.tags = const [],
    this.resolution = '1920x1080',
    this.isFeatured = false,
    this.isFavorite = false,
  });

  WallpaperModel copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? category,
    String? author,
    int? downloads,
    List<String>? tags,
    String? resolution,
    bool? isFeatured,
    bool? isFavorite,
  }) {
    return WallpaperModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      author: author ?? this.author,
      downloads: downloads ?? this.downloads,
      tags: tags ?? this.tags,
      resolution: resolution ?? this.resolution,
      isFeatured: isFeatured ?? this.isFeatured,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'category': category,
      'author': author,
      'downloads': downloads,
      'tags': tags,
      'resolution': resolution,
      'isFeatured': isFeatured,
      'isFavorite': isFavorite,
    };
  }

  factory WallpaperModel.fromJson(Map<String, dynamic> json) {
    return WallpaperModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      author: json['author'],
      downloads: json['downloads'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      resolution: json['resolution'] ?? '1920x1080',
      isFeatured: json['isFeatured'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
