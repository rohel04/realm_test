class CustomeUser {
  final String userId;
  final String name;

  CustomeUser({required this.userId, required this.name});

  factory CustomeUser.fromMap(Map<String, dynamic> map) =>
      CustomeUser(userId: map['userId'], name: map['name']);
}
