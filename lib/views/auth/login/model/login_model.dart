class LoginModel {
  final bool success;
  final String message;
  final LoginData data;

  LoginModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? LoginData.fromJson(json['data'])
          : LoginData.empty(),
    );
  }
}

class LoginData {
  final User user;
  final String accessToken;

  LoginData({
    required this.user,
    required this.accessToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: json['user'] != null ? User.fromJson(json['user']) : User.empty(),
      accessToken: json['accessToken'] ?? '',
    );
  }

  factory LoginData.empty() => LoginData(
    user: User.empty(),
    accessToken: '',
  );
}

class User {
  final String id;
  final AuthId authId;
  final String name;
  final String email;
  final String? profileImage;
  final String? phoneNumber;
  final Favorites favorites;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.authId,
    required this.name,
    required this.email,
    this.profileImage,
    this.phoneNumber,
    required this.favorites,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      authId: json['authId'] != null
          ? AuthId.fromJson(json['authId'])
          : AuthId.empty(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_image'],
      phoneNumber: json['phoneNumber'],
      favorites: json['favorites'] != null
          ? Favorites.fromJson(json['favorites'])
          : Favorites.empty(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ??
          DateTime.now(),
    );
  }

  factory User.empty() => User(
    id: '',
    authId: AuthId.empty(),
    name: '',
    email: '',
    profileImage: null,
    phoneNumber: null,
    favorites: Favorites.empty(),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}

class AuthId {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String role;
  final bool isActive;
  final bool isBlocked;

  AuthId({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.role,
    required this.isActive,
    required this.isBlocked,
  });

  factory AuthId.fromJson(Map<String, dynamic> json) {
    return AuthId(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      role: json['role'] ?? '',
      isActive: json['isActive'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
    );
  }

  factory AuthId.empty() => AuthId(
    id: '',
    name: '',
    email: '',
    phoneNumber: null,
    role: '',
    isActive: false,
    isBlocked: false,
  );
}

class Favorites {
  final List<String> categories;

  Favorites({required this.categories});

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  factory Favorites.empty() => Favorites(categories: []);
}
