import 'dart:convert';

class UserResponseModel {
  int id;
  String head;
  int customerId;
  String name;
  String nameEn;
  String address;
  String tincodeType;
  String tincode;
  int gender;
  String birthday;
  String telephone;
  String bankName;
  String bankAccount;
  String bankCode;
  String bankHeadCode;
  String region;
  String avatar;
  String identityName;
  int passwordNeedChange;
  int packageNeedBuy;

  UserResponseModel({
    this.id,
    this.head,
    this.customerId,
    this.name,
    this.nameEn,
    this.address,
    this.tincodeType,
    this.tincode,
    this.gender,
    this.birthday,
    this.telephone,
    this.bankName,
    this.bankAccount,
    this.bankCode,
    this.bankHeadCode,
    this.region,
    this.avatar,
    this.identityName,
    this.passwordNeedChange,
    this.packageNeedBuy,
  });
  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      new UserResponseModel(
        id: json["id"],
        head: json["head"],
        customerId: json["customer_id"],
        name: json["name"],
        nameEn: json["name_en"],
        address: json["address"],
        tincodeType: json["tincode_type"],
        tincode: json["tincode"],
        gender: json["gender"],
        birthday: json["birthday"],
        telephone: json["telephone"],
        bankName: json["bank_name"],
        bankAccount: json["bank_account"],
        bankCode: json["bank_code"],
        bankHeadCode: json["bank_head_code"],
        region: json["region"],
        avatar: json["avatar"],
        identityName: json["identity_name"],
        passwordNeedChange: json["password_need_change"],
        packageNeedBuy: json["package_need_buy"],
      );
}
