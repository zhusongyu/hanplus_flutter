class ProductResponseModel {
  List<ProductResponseDataModel> data;

  ProductResponseModel({
    this.data,
  });
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

  ProductResponseDataModel(
      {this.id,
      this.name,
      this.sku,
      this.picture,
      this.price,
      this.priceRmb,
      this.stock,
      this.vp,
      this.number});
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
                number: 0,
      );
}
