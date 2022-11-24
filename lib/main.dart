// Created by Muhammadjonov Abdulloh on 21.10.2022


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_update/bloc/home_bloc.dart';
import 'package:local_update/bloc/home_state.dart';
import 'package:local_update/models/character_model.dart';
import 'package:local_update/service/connectivity_service.dart';
import 'package:local_update/utils/get_it.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  await Hive.openBox<CharacterModel>('characters');
  await ConnectivityService.checkConnection();
  setUpGetIt();
  runApp(
    const MyApp(),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    ConnectivityService.listenToConnection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(HomeLoadingState()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Local update',
        home: HomePage(),
      ),
    );
  }
}
