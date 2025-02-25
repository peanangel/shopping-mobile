// class ProductModel {
//   final int pid;
//   final String productName;
//   final String image;
//   final String description;
//   final double price;
//   final int stock;
//   final double point;
//   final int type;
//   final int sid;
//   final String sellerName; // Add seller name

//   ProductModel({
//     required this.pid,
//     required this.productName,
//     required this.image,
//     required this.description,
//     required this.price,
//     required this.stock,
//     required this.point,
//     required this.type,
//     required this.sid,
//     required this.sellerName, // Initialize seller name
//   });

//   // Factory constructor to create an instance from JSON
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       pid: json['pid'],
//       productName: json['product_name'],
//       image: json['image'],
//       description: json['description'],
//       price: json['price'].toDouble(),
//       stock: json['stock'],
//       point: json['point'].toDouble(),
//       type: json['type'],
//       sid: json['sid'],
//       sellerName: json['seller_name'], // Get seller name
//     );
//   }

//   // Convert the model instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'pid': pid,
//       'product_name': productName,
//       'image': image,
//       'description': description,
//       'price': price,
//       'stock': stock,
//       'point': point,
//       'type': type,
//       'sid': sid,
//       'seller_name': sellerName, // Add seller name
//     };
//   }
// }
import 'package:get/get.dart';

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
  final String sellerName;
  final int cid; // Cart item ID
  final int uid; // User ID
  final RxBool isSelected = false.obs;
  final RxInt quantity;  // Initialize from amount field

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
    this.sellerName = '',  // Make it optional with default value
    this.cid = 0,          // Make it optional with default value
    this.uid = 0,          // Make it optional with default value
    int amount = 1,        // Default amount is 1
  }) : quantity = RxInt(amount);  // Initialize RxInt with the amount

  // Getters to match the view's expected properties
  int get id => pid;
  String get name => productName;
  String get imageUrl => image;

  // Factory constructor to create an instance from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      pid: json['pid'] ?? 0,
      productName: json['product_name'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] is int 
          ? (json['price'] as int).toDouble() 
          : (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      point: json['point'] is int 
          ? (json['point'] as int).toDouble() 
          : (json['point'] ?? 0).toDouble(),
      type: json['type'] ?? 0,
      sid: json['sid'] ?? 0,
      sellerName: json['seller_name'] ?? '',
      cid: json['cid'] ?? 0,
      uid: json['uid'] ?? 0,
      amount: json['amount'] ?? 1,
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
      'seller_name': sellerName,
      'cid': cid,
      'uid': uid,
      'amount': quantity.value,
    };
  }
}