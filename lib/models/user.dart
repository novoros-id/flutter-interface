class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : DateTime.now(),
    );
  }
}