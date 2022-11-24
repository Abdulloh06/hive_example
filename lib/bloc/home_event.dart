// Created by Muhammadjonov Abdulloh on 21.10.2022

import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class HomeInitEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeGetNextPageEvent extends HomeEvent {
  static int page = 1;
  static bool hasReachedMax = false;
  @override
  List<Object?> get props => [];
}