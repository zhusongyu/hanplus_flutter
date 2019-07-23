import 'dart:convert';

class CategoryResponseModel {
  List<CategoryResponseDataModel> data;

  CategoryResponseModel({
    this.data,
  });
  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      new CategoryResponseModel(
        data: new List<CategoryResponseDataModel>.from(
            json["data"].map((x) => CategoryResponseDataModel.fromJson(x))),
      );
}

class CategoryResponseDataModel {
  
  int id;
  String name;

  CategoryResponseDataModel({
    this.id,
    this.name,
  });
  factory CategoryResponseDataModel.fromJson(Map<String, dynamic> json) =>
      new CategoryResponseDataModel(
        id: json["id"],
        name: json["name"],
      );
}