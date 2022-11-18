// Created by Muhammadjonov Abdulloh on 21.10.2022

import 'package:hive/hive.dart';

part 'character_model.g.dart';

@HiveType(typeId: 0)
class CharacterModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String status;
  @HiveField(3)
  final String gender;
  @HiveField(4)
  final String location;
  @HiveField(5)
  final String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
    required this.gender,
    required this.location,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    String location = '';
    if(json['location'] != null && json['location']['name'] != null) {
      location = json['location']['name'] ?? "";
    }
    return CharacterModel(
      id: json['id'],
      name: json['name'] ?? "",
      status: json['status'] ?? "",
      gender: json['gender'] ?? "",
      location: location,
      image: json['image'] ?? "",
    );
  }

  static List<CharacterModel> fetchData(Map<String, dynamic> data) {
    List items = data['results'];
    List<CharacterModel> characters = [];

    for(int i = 0; i < items.length; i++) {
      characters.add(CharacterModel.fromJson(items[i]));
    }
    return characters;
  }
}