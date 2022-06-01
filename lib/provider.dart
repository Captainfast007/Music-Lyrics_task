import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/repositry/repositry.dart';
import 'package:flutter_task/service/service.dart';

import 'home/bloc/home_bloc.dart';

final dioProvider = Provider((ref) => Dio());

final homeBlocProvider = Provider(
  (ref) => HomeBloc(
    Repositry(
      ServiceClass(
        ref.read(dioProvider),
      ),
    ),
  ),
);
