// To parse this JSON data, do
//
//     final accountsModel = accountsModelFromJson(jsonString);

import 'dart:convert';

AccountsModel accountsModelFromJson(String str) =>
    AccountsModel.fromJson(json.decode(str));

String accountsModelToJson(AccountsModel data) => json.encode(data.toJson());

class AccountsModel {
  AccountsModel({
    this.id,
    this.businessName,
    this.productSerial,
    this.contactEmail,
    this.isDefault,
    this.databaseName,
  });

  int? id;
  String? businessName;
  String? productSerial;
  String? contactEmail;
  int? isDefault;
  String? databaseName;

  factory AccountsModel.fromJson(Map<String, dynamic> json) => AccountsModel(
        id: json["Id"],
        businessName: json["BusinessName"],
        productSerial: json["ProductSerial"],
        contactEmail: json["ContactEmail"],
        isDefault: json["IsDefault"],
        databaseName: json["DatabaseName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "BusinessName": businessName,
        "ProductSerial": productSerial,
        "ContactEmail": contactEmail,
        "IsDefault": isDefault??0,
        "DatabaseName": databaseName,
      };
}
