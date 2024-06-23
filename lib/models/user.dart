// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gepetrol_eguros/helper/utile.dart';

class User {
  int id;
  String email;
  String first_name;
  String last_name;
  String username;
  String? gender;
  String country;
  String? city;
  int? first_subscription;
  Residence? residence;
  FamilyStatus? family_status;
  Piece? piece;
  String? status;
  dynamic account_verification;
  String? email_verified_at;
  dynamic two_factor_code;
  int? use_two_factor_code;
  dynamic two_factor_expires_at;
  Naiss? naiss;
  Phone? phone;
  Photo? photo;
  String userable_type;
  int? userable_id;
  dynamic banned_until;
  User({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.username,
    this.photo,
    this.phone,
    this.naiss,
    this.gender,
    required this.country,
    this.city,
    this.first_subscription,
    this.residence,
    this.family_status,
    this.piece,
    this.status,
    this.account_verification = "",
    this.email_verified_at = "",
    this.two_factor_code = "",
    this.use_two_factor_code = 0,
    this.two_factor_expires_at = "",
    required this.userable_type,
    this.userable_id = 0,
    this.banned_until = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
      'gender': gender,
      'country': country,
      'city': city,
      'first_subscription': first_subscription,
      'residence': residence?.toMap(),
      'family_status': family_status?.toMap(),
      'piece': piece?.toMap(),
      'status': status,
      'account_verification': account_verification,
      'email_verified_at': email_verified_at,
      'two_factor_code': two_factor_code,
      'use_two_factor_code': use_two_factor_code,
      'two_factor_expires_at': two_factor_expires_at,
      'userable_type': userable_type,
      'userable_id': userable_id,
      'banned_until': banned_until,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      email: map['email'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      username: map['username'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
      country: map['country'] as String,
      city: map['city'] != null ? map['city'] as String : null,
      first_subscription: map['first_subscription'] != null
          ? map['first_subscription'] as int
          : null,
      residence: map['residence'] != null
          ? Residence.fromMap(map['residence'] as Map<String, dynamic>)
          : null,
      family_status: map['family_status'] != null
          ? FamilyStatus.fromMap(map['family_status'] as Map<String, dynamic>)
          : null,
      piece: map['piece'] != null
          ? Piece.fromMap(map['piece'] as Map<String, dynamic>)
          : null,
      photo: map['photo'] != null
          ? Photo.fromMap(map['photo'] as Map<String, dynamic>)
          : null,
      naiss: map['naiss'] != null
          ? Naiss.fromMap(map['naiss'] as Map<String, dynamic>)
          : null,
      phone: map['phone'] != null
          ? Phone.fromMap(map['phone'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      account_verification: map['account_verification'] as dynamic,
      email_verified_at: map['email_verified_at'] != null
          ? map['email_verified_at'] as dynamic
          : null,
      two_factor_code: map['two_factor_code'] as dynamic,
      use_two_factor_code: map['use_two_factor_code'] != null
          ? map['use_two_factor_code'] as int
          : null,
      two_factor_expires_at: map['two_factor_expires_at'] as dynamic,
      userable_type: map['userable_type'] as String,
      userable_id:
          map['userable_id'] != null ? map['userable_id'] as int : null,
      banned_until: map['banned_until'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  // factory User.fromJson(String source) =>
  //     User.fromMap(json.decode(source) as Map<String, dynamic>);

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        username: json["username"],
        gender: json["gender"],
        country: json["country"],
        city: json["city"],
        first_subscription: json["first_subscription"],
        residence: json["residence"],
        family_status: json["family_status"],
        piece: json["piece"],
        status: json["status"],
        account_verification: json["account_verification"],
        email_verified_at: json["email_verified_at"],
        two_factor_code: json["two_factor_code"],
        use_two_factor_code: json["use_two_factor_code"],
        two_factor_expires_at: json["two_factor_expires_at"],
        userable_type: json["userable_type"],
        userable_id: json["userable_id"],
        banned_until: json["banned_until"],
      );

  @override
  String toString() {
    return 'User(id: $id, email: $email, first_name: $first_name, last_name: $last_name, username: $username, gender: $gender, country: $country, city: $city, first_subscription: $first_subscription, residence: $residence, family_status: $family_status, piece: $piece, status: $status, account_verification: $account_verification, email_verified_at: $email_verified_at, two_factor_code: $two_factor_code, use_two_factor_code: $use_two_factor_code, two_factor_expires_at: $two_factor_expires_at, naiss: $naiss, phone: $phone, userable_type: $userable_type, userable_id: $userable_id, banned_until: $banned_until)';
  }
}

class FamilyStatus {
  String? family_status;
  String? number_enfants;

  FamilyStatus({
    this.family_status,
    this.number_enfants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'family_status': family_status,
      'number_enfants': number_enfants,
    };
  }

  factory FamilyStatus.fromMap(Map<String, dynamic> map) {
    return FamilyStatus(
      family_status:
          map['family_status'] != null ? map['family_status'] as String : null,
      number_enfants: map['number_enfants'] != null
          ? map['number_enfants'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FamilyStatus.fromJson(String source) =>
      FamilyStatus.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Naiss {
  String? date_of_birth;
  String? place_of_birth;
  Naiss({
    this.date_of_birth,
    this.place_of_birth,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date_of_birth': date_of_birth,
      'place_of_birth': place_of_birth,
    };
  }

  factory Naiss.fromMap(Map<String, dynamic> map) {
    return Naiss(
      date_of_birth:
          map['date_of_birth'] != null ? map['date_of_birth'] as String : null,
      place_of_birth: map['place_of_birth'] != null
          ? map['place_of_birth'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Naiss.fromJson(String source) =>
      Naiss.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Phone {
  String? home_phone;
  String? mobile_phone;
  String? fax;
  Phone({
    this.home_phone,
    this.mobile_phone,
    this.fax,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'home_phone': home_phone,
      'mobile_phone': mobile_phone,
      'fax': fax,
    };
  }

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      home_phone:
          map['home_phone'] != null ? map['home_phone'] as String : null,
      mobile_phone:
          map['mobile_phone'] != null ? map['mobile_phone'] as String : null,
      fax: map['fax'] != null ? map['fax'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Phone.fromJson(String source) =>
      Phone.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Photo {
  String? upload;
  String? selfi;
  Photo({
    this.upload,
    this.selfi,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'upload': upload,
      'selfi': selfi,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      upload: map['upload'] != null ? map['upload'] as String : null,
      selfi: map['selfi'] != null ? map['selfi'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Photo.fromJson(String source) =>
      Photo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Piece {
  String? document;
  String? identification_document;
  String? identification_number;
  String? issued_in;
  String? issued_by;
  String? expires_on;
  String? delivery_date;
  Piece({
    this.document,
    this.identification_document,
    this.identification_number,
    this.issued_in,
    this.issued_by,
    this.expires_on,
    this.delivery_date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'document': document,
      'identification_document': identification_document,
      'identification_number': identification_number,
      'issued_in': issued_in,
      'issued_by': issued_by,
      'expires_on': expires_on,
      'delivery_date': delivery_date,
    };
  }

  factory Piece.fromMap(Map<String, dynamic> map) {
    return Piece(
      document: map['document'] != null ? map['document'] as String : null,
      identification_document: map['identification_document'] != null
          ? map['identification_document'] as String
          : null,
      identification_number: map['identification_number'] != null
          ? map['identification_number'] as String
          : null,
      issued_in: map['issued_in'] != null ? map['issued_in'] as String : null,
      issued_by: map['issued_by'] != null ? map['issued_by'] as String : null,
      expires_on: map['expires_on'] != null
          ? Utile.getFormattedDate(map['expires_on'])
          : null,
      delivery_date: map['delivery_date'] != null
          ? Utile.getFormattedDate(map['delivery_date'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Piece.fromJson(String source) =>
      Piece.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Residence {
  String? document;
  String? address;
  String? zip_code;
  Residence({
    this.document,
    this.address,
    this.zip_code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'document': document,
      'address': address,
      'zip_code': zip_code,
    };
  }

  factory Residence.fromMap(Map<String, dynamic> map) {
    return Residence(
      document: map['document'] != null ? map['document'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      zip_code: map['zip_code'] != null ? map['zip_code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Residence.fromJson(String source) =>
      Residence.fromMap(json.decode(source) as Map<String, dynamic>);
}
