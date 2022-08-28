import 'dart:convert';

class Product {
  final int id;
  final double price;
  final String slug;
  final String title;
  final String description;
  final String imageUrl;
  final int quantity;
  Product({
    required this.id,
    required this.price,
    required this.slug,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'price': price});
    result.addAll({'slug': slug});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'featured_image': imageUrl});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      slug: map['slug'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['featured_image'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
