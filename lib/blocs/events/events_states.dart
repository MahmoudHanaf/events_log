import 'package:charging_station/models/all_events_model.dart';

abstract class EventsStates {}

class InitEvents extends EventsStates {}

class GetEventsLoading extends EventsStates {}

class SuccessGetEvents extends EventsStates {
  final List<AllEventsModel> allEventsModel;
  SuccessGetEvents({required this.allEventsModel});
}

class ErrorGetEvents extends EventsStates {
  final String message;
  ErrorGetEvents({required this.message});
}
