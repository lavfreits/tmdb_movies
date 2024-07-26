part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadMoviesEvent extends HomeEvent {
  bool isPopular;

  LoadMoviesEvent({this.isPopular = false});
}

class PerformSearchEvent extends HomeEvent {
  final String query;

  PerformSearchEvent(this.query);
}
