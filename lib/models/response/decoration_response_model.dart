class DecorationResponseModel {
  List<DecorationResponseDataModel> sliders = [];

  DecorationResponseModel({
    this.sliders,
  });
  factory DecorationResponseModel.fromJson(Map<String, dynamic> json) =>
      new DecorationResponseModel(
        sliders: new List<DecorationResponseDataModel>.from(json["content"]["data"]["slides"]
            .map((x) => DecorationResponseDataModel.fromJson(x))),
      );
}

class DecorationResponseDataModel {
  String imgUrl;
  String imageTitle;
  String linkTo;
  String name;

  DecorationResponseDataModel({
    this.imgUrl,
    this.imageTitle,
    this.linkTo,
    this.name,
  });
  factory DecorationResponseDataModel.fromJson(Map<String, dynamic> json) =>
      new DecorationResponseDataModel(
        imgUrl: json["imgUrl"],
        imageTitle: json["imageTitle"],
        linkTo: json["linkTo"],
        name: json["name"],
      );
}
