// Created by Muhammadjonov Abdulloh on 21.10.2022

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:local_update/bloc/home_bloc.dart';
import 'package:local_update/bloc/home_event.dart';
import 'package:local_update/bloc/home_state.dart';
import 'package:local_update/models/character_model.dart';
import 'package:local_update/service/connectivity_service.dart';
import 'package:local_update/widgets/character_card.dart';
import 'package:local_update/widgets/loader.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final box = Hive.box<CharacterModel>('characters');
  final _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(HomeInitEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if(state is HomeInitState && state.characters.isNotEmpty) {
                if(ConnectivityService.hasConnection) {
                  box.clear().then((value) => box.addAll(state.characters));
                }
                return SmartRefresher(
                  controller: _controller,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () {
                    context.read<HomeBloc>().add(HomeInitEvent());
                    _controller.refreshCompleted();
                  },
                  onLoading: () {
                    context.read<HomeBloc>().add(HomeGetNextPageEvent());
                    _controller.loadComplete();
                  },
                  footer: CustomFooter(
                    builder: (context, status) {
                      if(status == LoadStatus.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  header: const WaterDropHeader(
                    waterDropColor: Colors.blue,
                  ),
                  child: ListView.builder(
                    itemCount: state.characters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(
                        id: state.characters[index].id,
                        name: state.characters[index].name,
                        gender: state.characters[index].gender,
                        location: state.characters[index].location,
                        status: state.characters[index].status,
                        image: state.characters[index].image,
                      );
                    },
                  ),
                );
              } else if(state is HomeInitState && state.characters.isEmpty) {
                return const Center(
                  child: Text(
                    'There is no data..\nConnect to internet to load',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                return const Loader();
              }
            }
          ),
        ),
      ),
    );
  }
}
