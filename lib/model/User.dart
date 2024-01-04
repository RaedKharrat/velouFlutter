class User {
  final String? id;
  final String? email;
  final String? password;
  final String? fullname;
  final String? username;
  final String? phone;
  final String? token;

  User({
    this.id,
    this.email,
    this.password,
    required this.fullname,
    required this.username,
    required this.phone,
    this.token,
  });

  // Méthode pour convertir un objet User en un objet JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'password': password,
      'fullname': fullname,
      'username': username,
      'phone': phone,
      'token': token,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      fullname: json['fullname'],
      username: json['username'],
      phone: json['phone'],
      token: json['token'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, '
        'email: $email, '
        'password: $password, '
        'fullname: $fullname, '
        'username: $username, '
        'phone: $phone, '
        'token: $token}';
  }
}

DateTime? parseDateTime(String? dateTimeString) {
  if (dateTimeString != null) {
    return DateTime.parse(dateTimeString);
  }
  return null;
}
