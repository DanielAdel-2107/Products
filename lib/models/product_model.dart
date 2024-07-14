class Product {
  final int id;
  final String title;
  final String? description;
  final double originalPrice;
  final double discountPercentage;
  final double? rating;
  final String? thumbnail;
  final bool isFavorite;

  Product({
    required this.id,
    required this.title,
    this.description,
    required this.originalPrice,
    required this.discountPercentage,
    this.rating,
    this.thumbnail,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      originalPrice: json['price']?.toDouble() ?? 0.0,
      discountPercentage: json['discountPercentage']?.toDouble() ?? 0.0,
      rating: json['rating']?.toDouble(),
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Product copyWith({bool? isFavorite}) {
    return Product(
      id: this.id,
      title: this.title,
      description: this.description,
      originalPrice: this.originalPrice,
      discountPercentage: this.discountPercentage,
      rating: this.rating,
      thumbnail: this.thumbnail,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
