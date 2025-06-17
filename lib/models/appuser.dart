  class AppUser {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? address;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
  });


  factory AppUser.fromFirestore(String id, Map<String, dynamic> data) {
    return AppUser(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'],
      address: data['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
