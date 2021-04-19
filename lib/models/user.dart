class User {
  final String username;
  final String name;
  final String email;
  final String phone;
  final String accessToken;
  final List<dynamic> historyBooked;
  User(
      {this.historyBooked,
      this.username,
      this.name,
      this.email,
      this.phone,
      this.accessToken});

  User copyWith(
      {String username,
      String name,
      String email,
      List<dynamic> historyBooked,
      String phone,
      String accessToken}) {
    return User(
        accessToken: accessToken ?? this.accessToken,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        username: username ?? this.username,
        historyBooked: historyBooked ?? this.historyBooked);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['taiKhoan'] as String,
        accessToken: json['accessToken'] as String,
        email: json['email'] as String,
        name: json['hoTen'] as String,
        phone: json['soDT'] as String);
  }
}
