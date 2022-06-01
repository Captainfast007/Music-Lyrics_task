part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final TrackList tracks;

  HomeLoaded(this.tracks);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
