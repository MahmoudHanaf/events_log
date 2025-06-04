import 'package:charging_station/models/events_model.dart';
import 'package:charging_station/models/model.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeHeaderModel? headerType;
  final List<String> banner;
  final List<CategoryModel> category;
  final List<CategoryModel> location;
  final List<ProductModel> recent;
  final List<CategoryModel> options;
  final List<WidgetModel> widgets;
  final EventModel eventModel;

  HomeSuccess({
    required this.headerType,
    required this.banner,
    required this.category,
    required this.location,
    required this.recent,
    required this.options,
    required this.widgets,
    required this.eventModel,
  });
}

class EventsLoading extends HomeState {}

class SuccessGetEvents extends HomeState {
  final EventModel eventModel;
  SuccessGetEvents({required this.eventModel});
}

class ErrorGetEvents extends HomeState {
  final String message;
  ErrorGetEvents({required this.message});
}
