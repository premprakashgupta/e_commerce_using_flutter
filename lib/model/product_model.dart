class CategoryModal {
  // class for displaying category on shopScreen
  int id;
  String name;
  String image;
  CategoryModal({required this.id, required this.name, required this.image});
  factory CategoryModal.fromJson(Map<String, dynamic> json) {
    return CategoryModal(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}

class CatelogModel {
  // class for displaying catelog which is category by
  int id;
  String title;
  int price;
  String description;
  List<dynamic> images;
  CatelogModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.images});
  factory CatelogModel.fromJson(Map<String, dynamic> json) {
    return CatelogModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      images: json['images'],
    );
  }
}

class SingleProductModal {
  // class for displaying single product detail
  int id;
  String title;
  int price;
  String description;
  CategoryModal category;
  List<String> images;

  SingleProductModal(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.images});

  factory SingleProductModal.fromJson(Map<String, dynamic> json) {
    return SingleProductModal(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: (json['category'] != null
            ? CategoryModal.fromJson(json['category'])
            : null)!,
        images: json['images'].cast<String>());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category.toJson(),
        'images': images,
      };
}

class CartModel {
  // class for displaying single product detail
  int id;

  String title;
  int price;
  int item_count;
  CategoryModal category;
  List<String> images;

  CartModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.item_count,
      required this.category,
      required this.images});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        item_count: json['item_count'],
        category: (json['category'] != null
            ? CategoryModal.fromJson(json['category'])
            : null)!,
        images: json['images'].cast<String>());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'item_count': item_count,
        'category': category.toJson(),
        'images': images,
      };
}
