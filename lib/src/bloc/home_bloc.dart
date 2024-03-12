import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class HomeEvent {}

class FetchDataEvent extends HomeEvent {}

abstract class HomeState {}

class InitialState extends HomeState {}

class LoadingState extends HomeState {}

class DataLoadedState extends HomeState {
  final List<Map<String, dynamic>> wrapList;

  DataLoadedState(this.wrapList);
}

class ErrorState extends HomeState {
  final String error;

  ErrorState(this.error);
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchDataEvent) {
      yield LoadingState();

      try {
        // Simulate data fetching, replace with your actual data fetching logic
        await Future.delayed(Duration(seconds: 2));

        // Replace with your actual data
        final List<Map<String, dynamic>> wrapList = [
          {'title': 'Upcoming Events', 'icon': Icons.home},
          {'title': 'Birthday / Anniversary', 'icon': Icons.home},
          {'title': 'Working Committee', 'icon': Icons.home},
          {'title': 'Gallery', 'icon': Icons.home},
        ];

        yield DataLoadedState(wrapList);
      } catch (e) {
        yield ErrorState('Error fetching data');
      }
    }
  }
}
