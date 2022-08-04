part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final Lyrics lyrics;

  DetailsLoaded(this.lyrics);
}

class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}
