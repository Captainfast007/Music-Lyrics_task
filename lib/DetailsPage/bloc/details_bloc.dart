import 'package:bloc/bloc.dart';
import 'package:flutter_task/data/music.dart';
import 'package:flutter_task/data/track.dart';
import 'package:flutter_task/repositry/repositry.dart';
import 'package:meta/meta.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final Repositry repositry;
  DetailsBloc(this.repositry) : super(DetailsLoading()) {
    on<DetailsEvent>((event, emit) async {
      if (event is PageStarted) {
        emit(DetailsLoading());
        final response = await repositry.getLyricsOfTrack(event.trackId);
        response.fold((l) {
          return emit(DetailsError(l));
        }, (r) {
          return emit(DetailsLoaded(r));
        });
      }
    });
  }
}
