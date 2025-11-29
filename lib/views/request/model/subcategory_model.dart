class SubCategoryModel {
  int? statusCode;
  bool? success;
  String? message;
  List<SubCategoryData>? data;

  SubCategoryModel({this.statusCode, this.success, this.message, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubCategoryData>[];
      json['data'].forEach((v) {
        data!.add(SubCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['statusCode'] = statusCode;
    jsonData['success'] = success;
    jsonData['message'] = message;
    if (data != null) {
      jsonData['data'] = data!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }
}

class SubCategoryData {
  String? sId;
  String? name;
  bool? isActive;
  String? createdBy;
  String? categoryId; // optional if you want to track parent category
  String? createdAt;
  String? updatedAt;
  int? iV;

  SubCategoryData({
    this.sId,
    this.name,
    this.isActive,
    this.createdBy,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    categoryId = json['categoryId']; // if your API sends it
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['_id'] = sId;
    jsonData['name'] = name;
    jsonData['isActive'] = isActive;
    jsonData['createdBy'] = createdBy;
    jsonData['categoryId'] = categoryId;
    jsonData['createdAt'] = createdAt;
    jsonData['updatedAt'] = updatedAt;
    jsonData['__v'] = iV;
    return jsonData;
  }
}
