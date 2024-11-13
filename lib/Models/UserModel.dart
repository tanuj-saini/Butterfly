class UserModel {
  String? name;
  String? email;
  String? password;
  String? userId;
  String? profileURL;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.userId,
    this.profileURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      userId: json['_id'],
      profileURL: json['profileURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'userId': userId,
      'profileURL': profileURL,
    };
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, password: $password, userId: $userId, profileURL: $profileURL}';
  }
}
