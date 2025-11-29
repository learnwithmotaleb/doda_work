class UserAllCategoryModel {
  int? statusCode;
  bool? success;
  String? message;
  List<Data>? data;

  UserAllCategoryModel(
      {this.statusCode, this.success, this.message, this.data});

  UserAllCategoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? icon;
  bool? isActive;
  String? createdBy;
  List<Subcategories>? subcategories;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? updatedBy;

  Data(
      {this.sId,
        this.name,
        this.icon,
        this.isActive,
        this.createdBy,
        this.subcategories,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.updatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['isActive'] = this.isActive;
    data['createdBy'] = this.createdBy;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['updatedBy'] = this.updatedBy;
    return data;
  }
}

class Subcategories {
  String? name;
  bool? isActive;
  String? createdBy;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Subcategories(
      {this.name,
        this.isActive,
        this.createdBy,
        this.sId,
        this.createdAt,
        this.updatedAt});

  Subcategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['createdBy'] = this.createdBy;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
