class UserModel {
  final int uid;
  final String email;
  final String name;
  final String phone;
  final String address;
  final DateTime birthday;
  final int role;
  final String? image; // Optional image field

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.birthday,
    required this.role,
    this.image, // Optional image
  });

  // Factory constructor to create an instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'] as String)
          : DateTime.now(), // Default to now if birthday is null
      role: json['role'] as int,
      image: json['image'] as String?, // Handle nullable image
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'birthday': birthday.toIso8601String(),
      'role': role,
      'image': image, // Optional field; if null, it won't appear in JSON
    };
  }
}
