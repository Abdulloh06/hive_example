// Created by Muhammadjonov Abdulloh on 21.10.2022

import 'package:get_it/get_it.dart';
import 'package:local_update/service/get_characters.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerLazySingleton<GetCharacters>(() => GetCharacters());
}