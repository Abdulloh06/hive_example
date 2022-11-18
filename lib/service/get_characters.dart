// Created by Muhammadjonov Abdulloh on 21.10.2022

import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:local_update/models/character_model.dart';
import 'package:local_update/service/connectivity_service.dart';


class GetCharacters {

  Future<List<CharacterModel>> getCharacters() async {

    try {

      if(await ConnectivityService.checkConnection()) {
        final response = await http.get(
          Uri.parse('https://rickandmortyapi.com/api/character'),
        );

        if(response.statusCode == HttpStatus.ok) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          return CharacterModel.fetchData(data);
        } else {
          throw Exception(response.reasonPhrase);
        }
      } else {
        List<CharacterModel> data = [];
        data.addAll(Hive.box<CharacterModel>('characters').values.toList());
        return data;
      }

    } catch(_) {
      throw Exception('UNKNOWN');
    }
  }

}