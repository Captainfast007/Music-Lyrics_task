import 'package:bloc/bloc.dart';
import 'package:flutter_task/data/track.dart';
import 'package:flutter_task/repositry/repositry.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';




class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repositry repositry;
  HomeBloc(this.repositry) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeInitial) {
        emit(HomeLoading());
        final response = await repositry.getTracks();
        response.fold((l) {
          return emit(HomeError(l));
        }, (r) {
          return emit(HomeLoaded(r));
        });
      }
    });
  }
}
