class Products {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  int quantity;
  double? totalprice;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.quantity,
    required this.totalprice,
  });

  Products copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    Rating? rating,
    int? quantity,
    double? totalprice,
  }) {
    return Products(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
      totalprice: totalprice ?? this.totalprice,
    );
  }

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json['id'],
        quantity: json['quantity'] ?? 1,
        title: json['title'],
        price: json['price']?.toDouble(),
        description: json['description'],
        category: json['category'],
        image: json['image'],
        totalprice: json['totalprice'] ?? 0.0,
        rating: Rating.fromJson(json['rating']),
      );

  factory Products.fromMap(Map<String, dynamic> map) => Products(
        id: map['id'],
        quantity: map['quantity'] ?? 1,
        title: map['title'],
        price: map['price']?.toDouble(),
        description: map['description'],
        category: map['category'],
        totalprice: map['totalprice'],
        image: map['image'],
        rating: Rating.fromJson(map['rating']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'totalprice': totalprice,
        'rating': rating?.toJson(),
      };

  Map<String, dynamic> toMap() => {
        'id': id,
        'quantity': quantity,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'totalprice': totalprice,
        'image': image,
        'rating': rating?.toJson(),
      };
}

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic>? json) => Rating(
        rate: json?['rate']?.toDouble(),
        count: json?['count'],
      );

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };
}
