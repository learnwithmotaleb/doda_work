class FavoriteCategoryResponse {
  final int statusCode;
  final bool success;
  final String message;
  final FavoriteCategoryData data;

  FavoriteCategoryResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory FavoriteCategoryResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteCategoryResponse(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: FavoriteCategoryData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data.toJson(),
    };
  }
}

class FavoriteCategoryData {
  final bool success;
  final String message;
  final List<FavoriteCategoryItem> data;

  FavoriteCategoryData({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FavoriteCategoryData.fromJson(Map<String, dynamic> json) {
    return FavoriteCategoryData(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => FavoriteCategoryItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}

class FavoriteCategoryItem {
  final String id;
  final String name;
  final String icon;
  final bool isActive;
  final bool isFavorite;

  FavoriteCategoryItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.isActive,
    required this.isFavorite,
  });

  factory FavoriteCategoryItem.fromJson(Map<String, dynamic> json) {
    return FavoriteCategoryItem(
      id: json['_id'],
      name: json['name'],
      icon: json['icon'],
      isActive: json['isActive'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "icon": icon,
      "isActive": isActive,
      "isFavorite": isFavorite,
    };
  }
}
