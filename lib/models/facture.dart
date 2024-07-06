// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gepetrol_eguros/models/marque.dart';
import 'package:gepetrol_eguros/models/power.dart';
import 'package:gepetrol_eguros/models/typeRemoque.dart';

import '../helper/utile.dart';

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
  dynamic initialPrice;
  dynamic attestationPrice;
  dynamic subTotal;
  dynamic accessoriesPrice;
  dynamic vat;
  String? regisNumber;
  int? status;
  dynamic total;
  String? link;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  int? extraPrice;
  Marque? brand;
  Power? power;
  TypeRemoque? trailer;
  Facture({
    this.id,
    required this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    required this.sex,
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
    required this.initialPrice,
    required this.attestationPrice,
    required this.subTotal,
    required this.accessoriesPrice,
    required this.vat,
    this.regisNumber,
    this.status,
    required this.total,
    this.link,
    required this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.extraPrice,
    this.brand,
    this.power,
    this.trailer,
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'extraPrice': extraPrice,
      'brand': brand?.toMap(),
      'power': power?.toMap(),
      'trailer': trailer?.toMap(),
    };
  }

  factory Facture.fromMap(Map<String, dynamic> map) {
    return Facture(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] as dynamic,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
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
          map['place_number'] != null ? map['place_number'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      initialPrice: map['initial_price'] as dynamic,
      attestationPrice: map['attestation_price'] as dynamic,
      subTotal: map['sub_total'] as dynamic,
      accessoriesPrice: map['accessories_price'] as dynamic,
      vat: map['vat'] as dynamic,
      regisNumber:
          map['regis_number'] != null ? map['regis_number'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      total: map['total'] as dynamic,
      link: map['link'] != null ? map['link'] as String : null,
      deletedAt: map['deletedAt'] as dynamic,
      createdAt: map['created_at'] != ""
          ? Utile.getFormattedDate(map['created_at'])
          : '',
      extraPrice: map['extra_price'] != null ? map['extra_price'] as int : null,
      brand: map['brand'] != null
          ? Marque.fromMap(map['brand'] as Map<String, dynamic>)
          : null,
      power: map['power'] != null
          ? Power.fromMap(map['power'] as Map<String, dynamic>)
          : null,
      trailer: map['trailer'] != null
          ? TypeRemoque.fromMap(map['trailer'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Facture.fromJson(String source) =>
      Facture.fromMap(json.decode(source) as Map<String, dynamic>);
}
