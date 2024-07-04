// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gepetrol_eguros/models/marque.dart';
import 'package:gepetrol_eguros/models/power.dart';
import 'package:gepetrol_eguros/models/typeRemoque.dart';

class Facture {
  int? id;
  dynamic userId;
  String? firstName;
  String? lastName;
  String? phone;
  dynamic sex;
  String? email;
  int? fuelTypeId;
  int? typeCarId;
  int? powerId;
  int? carCategoryId;
  int? brandId;
  int? trailerId;
  String? model;
  String? state;
  int? placeNumber;
  String? code;
  int? initialPrice;
  int? attestationPrice;
  int? subTotal;
  int? accessoriesPrice;
  double? vat;
  String? regisNumber;
  int? status;
  double? total;
  String? link;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? extraPrice;
  Marque brand;
  Power power;
  TypeRemoque trailer;

  Facture({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.sex,
    this.email,
    this.fuelTypeId,
    this.typeCarId,
    this.powerId,
    this.carCategoryId,
    this.brandId,
    this.trailerId,
    this.model,
    this.state,
    this.placeNumber,
    this.code,
    this.initialPrice,
    this.attestationPrice,
    this.subTotal,
    this.accessoriesPrice,
    this.vat,
    this.regisNumber,
    this.status,
    this.total,
    this.link,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.extraPrice,
    required this.brand,
    required this.power,
    required this.trailer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'sex': sex,
      'email': email,
      'fuelTypeId': fuelTypeId,
      'typeCarId': typeCarId,
      'powerId': powerId,
      'carCategoryId': carCategoryId,
      'brandId': brandId,
      'trailerId': trailerId,
      'model': model,
      'state': state,
      'placeNumber': placeNumber,
      'code': code,
      'initialPrice': initialPrice,
      'attestationPrice': attestationPrice,
      'subTotal': subTotal,
      'accessoriesPrice': accessoriesPrice,
      'vat': vat,
      'regisNumber': regisNumber,
      'status': status,
      'total': total,
      'link': link,
      'deletedAt': deletedAt,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'extraPrice': extraPrice,
      'brand': brand.toMap(),
      'power': power.toMap(),
      'trailer': trailer.toMap(),
    };
  }

  factory Facture.fromMap(Map<String, dynamic> map) {
    return Facture(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] as dynamic,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      sex: map['sex'] as dynamic,
      email: map['email'] != null ? map['email'] as String : null,
      fuelTypeId: map['fuelTypeId'] != null ? map['fuelTypeId'] as int : null,
      typeCarId: map['typeCarId'] != null ? map['typeCarId'] as int : null,
      powerId: map['powerId'] != null ? map['powerId'] as int : null,
      carCategoryId:
          map['carCategoryId'] != null ? map['carCategoryId'] as int : null,
      brandId: map['brandId'] != null ? map['brandId'] as int : null,
      trailerId: map['trailerId'] != null ? map['trailerId'] as int : null,
      model: map['model'] != null ? map['model'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      placeNumber:
          map['placeNumber'] != null ? map['placeNumber'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      initialPrice:
          map['initialPrice'] != null ? map['initialPrice'] as int : null,
      attestationPrice: map['attestationPrice'] != null
          ? map['attestationPrice'] as int
          : null,
      subTotal: map['subTotal'] != null ? map['subTotal'] as int : null,
      accessoriesPrice: map['accessoriesPrice'] != null
          ? map['accessoriesPrice'] as int
          : null,
      vat: map['vat'] != null ? map['vat'] as double : null,
      regisNumber:
          map['regisNumber'] != null ? map['regisNumber'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      total: map['total'] != null ? map['total'] as double : null,
      link: map['link'] != null ? map['link'] as String : null,
      deletedAt: map['deletedAt'] as dynamic,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      extraPrice: map['extraPrice'] != null ? map['extraPrice'] as int : null,
      brand: Marque.fromMap(map['brand'] as Map<String, dynamic>),
      power: Power.fromMap(map['power'] as Map<String, dynamic>),
      trailer: TypeRemoque.fromMap(map['trailer'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Facture.fromJson(String source) =>
      Facture.fromMap(json.decode(source) as Map<String, dynamic>);
}
