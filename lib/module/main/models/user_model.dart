// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int id;
    String idNo;
    String fname;
    String mname;
    String lname;
    String gender; 
    String email;
    String mobile;
    String address; 
    String username;
    int passwordUpdate;
    int type;

    UserModel({
        required this.id,
        required this.idNo,
        required this.fname,
        required this.mname,
        required this.lname,
        required this.gender, 
        required this.email,
        required this.mobile,
        required this.address, 
        required this.username,
        required this.type,
        required this.passwordUpdate,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        idNo: json["id_no"].toString(),
        fname: json["fname"].toString(),
        mname: json["mname"]??'',
        lname: json["lname"].toString(),
        gender: json["gender"]??'', 
        email: json["email"]??'',
        mobile: json["mobile"].toString(),
        address: json["address"]??'', 
        username: json["username"].toString(),
        passwordUpdate: json["password_update"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_no": idNo,
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "gender": gender, 
        "email": email,
        "mobile": mobile,
        "address": address, 
        "username": username,
        "password_update": passwordUpdate,
        "type": type,
    };
}
