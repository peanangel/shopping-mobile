class ProductModel {
  final int pid;
  final String productName;
  final String image;
  final String description;
  final double price;
  final int stock;
  final double point;
  final int type;
  final int sid;
  final String sellerName; // Add seller name

  ProductModel({
    required this.pid,
    required this.productName,
    required this.image,
    required this.description,
    required this.price,
    required this.stock,
    required this.point,
    required this.type,
    required this.sid,
    required this.sellerName, // Initialize seller name
  });

  // Factory constructor to create an instance from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      pid: json['pid'],
      productName: json['product_name'],
      image: json['image'],
      description: json['description'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      point: json['point'].toDouble(),
      type: json['type'],
      sid: json['sid'],
      sellerName: json['seller_name'], // Get seller name
    );
  }

  // Convert the model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'pid': pid,
      'product_name': productName,
      'image': image,
      'description': description,
      'price': price,
      'stock': stock,
      'point': point,
      'type': type,
      'sid': sid,
      'seller_name': sellerName, // Add seller name
    };
  }
}
