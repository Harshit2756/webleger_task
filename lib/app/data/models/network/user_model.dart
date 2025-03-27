import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return "$id, $username, $email, $firstName, $lastName, $gender, $image, ";
  }
}

/*
{
	"id": 2,
	"username": "michaelw",
	"email": "michael.williams@x.dummyjson.com",
	"firstName": "Michael",
	"lastName": "Williams",
	"gender": "male",
	"image": "https://dummyjson.com/icon/michaelw/128"
}*/
