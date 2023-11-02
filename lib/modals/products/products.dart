class ProductsModal {
  List<Products> products;

  ProductsModal({
    required this.products,
  });

  factory ProductsModal.fromJson(Map<String, dynamic> json) {
    List<Products> data = [];
    json['products'].forEach((v) {
      data.add(Products.fromJson(v));
    });
    return ProductsModal(
      products: List.from(data),
    );
  }
}

class Products {
  int id;
  String title;
  String description;
  int price;
  String brand;
  String category;
  String thumbnail;
  List images;

  Products({
    required this.brand,
    required this.category,
    required this.description,
    required this.id,
    required this.price,
    required this.thumbnail,
    required this.title,
    required this.images,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      brand: json['brand'],
      category: json['category'],
      description: json['description'],
      id: json['id'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      images: List.from(json['images']),
    );
  }
}
