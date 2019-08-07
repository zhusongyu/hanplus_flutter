import 'dart:convert';

class ProductResponseModel {
  List<ProductResponseDataModel> data;

  ProductResponseModel({
    this.data,
  });

  factory ProductResponseModel.fromRawJson(String str) =>
      ProductResponseModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      new ProductResponseModel(
        data: new List<ProductResponseDataModel>.from(
            json["data"].map((x) => ProductResponseDataModel.fromJson(x))),
      );
}

class ProductResponseDataModel {
  int id;
  String sku;
  String name;
  String picture;
  String price;
  String priceRmb;
  int stock;
  String vp;
  int number;
  bool selected;

  ProductResponseDataModel(
      {this.id,
      this.name,
      this.sku,
      this.picture,
      this.price,
      this.priceRmb,
      this.stock,
      this.vp,
      this.number,
      this.selected});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "picture": picture,
        "price": price,
        "priceRmb": priceRmb,
        "stock": stock,
        "vp": vp,
        "number": number,
        "selected": selected,
      };

  factory ProductResponseDataModel.fromJson(Map<String, dynamic> json) =>
      new ProductResponseDataModel(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        picture: json["picture"],
        price: json["price"],
        priceRmb: json["priceRmb"],
        stock: json["stock"],
        vp: json["vp"],
        number: json["number"] == null ? 0 : json["number"],
        selected: json["selected"] == null ? false : json["selected"],
      );
}

// class ProductModelList {
//   List<ProductModel> modelList;

//   ProductModelList({
//     this.modelList,
//   });

//   factory ProductModelList.fromRawJson(String str) =>
//       ProductModelList.fromJson(json.decode(str));
//   String toRawJson() => json.encode(toJson());

//   Map<String, dynamic> toJson() => {
//         "data": new List<dynamic>.from(modelList.map((x) => x.toJson())),
//       };

//   factory ProductModelList.fromJson(Map<String, dynamic> json) =>
//       new ProductModelList(
//         modelList: new List<ProductModel>.from(
//             json["modelList"].map((x) => ProductModel.fromJson(x))),
//       );
// }

// class ProductModel {
//   ProductResponseDataModel model;
//   int number;
//   bool selected;

//   ProductModel({
//     this.model,
//     this.number,
//     this.selected,
//   });

//   factory ProductModel.fromRawJson(String str) =>
//       ProductModel.fromJson(json.decode(str));
//   String toRawJson() => json.encode(toJson());

//   Map<String, dynamic> toJson() => {
//         "model": model.toJson(),
//         "number": number,
//         "selected": selected,
//       };

//   factory ProductModel.fromJson(Map<String, dynamic> json) => new ProductModel(
//         model: json['model'],
//         number: json['number'],
//         selected: json['selected'],
//       );
// }
