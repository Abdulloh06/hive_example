// Created by Muhammadjonov Abdulloh on 21.10.2022

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_update/service/get_characters.dart';
import 'package:local_update/utils/get_it.dart';

import 'home_state.dart';
import 'home_event.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState) {
    on<HomeInitEvent>((event, emit) => _init(event: event, emit: emit));
  }

  Future<void> _init({
    required HomeInitEvent event,
    required Emitter<HomeState> emit,
  }) async {
    emit(HomeLoadingState());

    try {

      final result = await getIt.get<GetCharacters>().getCharacters();
      emit(HomeInitState(characters: result));

    } catch(e) {
      emit(HomeErrorState(
        error: e.toString(),
      ));
    }
  }
}