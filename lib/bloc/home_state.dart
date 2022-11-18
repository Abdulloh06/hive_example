// Created by Muhammadjonov Abdulloh on 21.10.2022

import 'package:equatable/equatable.dart';
import 'package:local_update/models/character_model.dart';


abstract class HomeState extends Equatable {}

class HomeInitState extends HomeState {

  final List<CharacterModel> characters;

  HomeInitState({required this.characters});

  @override
  List<Object?> get props => [characters];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}