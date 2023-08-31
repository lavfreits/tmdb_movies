part of 'home_bloc.dart';
abstract class HomeEvent {}

class LoadMoviesEvent extends HomeEvent {}
class PerformSearchEvent extends HomeEvent {
  final String query;

  PerformSearchEvent(this.query);

}
