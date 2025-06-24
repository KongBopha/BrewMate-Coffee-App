class AppUser {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? address;
  final String? profileImageUrl;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
    this.profileImageUrl,
  });
    AppUser copyWith({
    String? name,
    String? email,
    String? image,
  }) {
    return AppUser(
      id: id,  
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: image ?? profileImageUrl,
    );
  }
  factory AppUser.fromFirestore(String id, Map<String, dynamic> data) {
    return AppUser(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      profileImageUrl: data['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'profileImageUrl': profileImageUrl,
    };
  }
}
