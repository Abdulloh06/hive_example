// Created by Muhammadjonov Abdulloh on 21.10.2022

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_update/service/get_characters.dart';
import 'package:local_update/utils/get_it.dart';

import 'home_state.dart';
import 'home_event.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState) {
    on<HomeInitEvent>((event, emit) => _init(event: event, emit: emit));
    on<HomeGetNextPageEvent>((event, emit) => _getNextPage(event: event, emit: emit));
  }

  Future<void> _init({
    required HomeInitEvent event,
    required Emitter<HomeState> emit,
  }) async {
    emit(HomeLoadingState());
    HomeGetNextPageEvent.page = 1;
    HomeGetNextPageEvent.hasReachedMax = false;
    try {
      final result = await getIt.get<GetCharacters>().getCharacters(
        page: 1,
      );
      emit(HomeInitState(characters: result));

    } catch(e) {
      emit(HomeErrorState(
        error: e.toString(),
      ));
    }
  }

  Future<void> _getNextPage({
    required HomeGetNextPageEvent event,
    required Emitter<HomeState> emit,
  }) async {

    try {
      HomeInitState data = state as HomeInitState;
      HomeGetNextPageEvent.page++;
      HomeGetNextPageEvent.hasReachedMax = true;
      final result = await getIt.get<GetCharacters>().getCharacters(
        page: HomeGetNextPageEvent.page,
      );
      if(result.isNotEmpty) {
        emit(HomeInitState(characters: data.characters + result));
      } else {
        HomeGetNextPageEvent.hasReachedMax = true;
        emit(HomeInitState(characters: data.characters));
      }

    } catch(e) {
      emit(HomeErrorState(error: e.toString()));
    }

  }
}