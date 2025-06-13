// class Item {
//   final String id;
//   final String title;
//   final String description;
//   final String image;
//   final double price;
//   final String category;
//   final double rating;
//   final bool inStock;

//   Item({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.price,
//     required this.category,
//     required this.rating,
//     required this.inStock,
//   });

//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       image: json['image'],
//       price: json['price'].toDouble(),
//       category: json['category'],
//       rating: json['rating'].toDouble(),
//       inStock: json['inStock'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'image': image,
//       'price': price,
//       'category': category,
//       'rating': rating,
//       'inStock': inStock,
//     };
//   }
// }


class Item {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final double rating;
  final bool inStock;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
    this.inStock = true,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      rating: (json['rating']?['rate'] ?? 0).toDouble(),
      inStock: json['inStock'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': {'rate': rating},
      'inStock': inStock,
    };
  }
}