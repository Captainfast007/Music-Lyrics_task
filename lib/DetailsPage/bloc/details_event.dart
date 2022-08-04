part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class DetailsInital extends DetailsEvent {}

class PageStarted extends DetailsEvent {
  final int trackId;

  PageStarted(this.trackId);
}
