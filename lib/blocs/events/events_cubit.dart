import 'dart:convert';

import 'package:charging_station/api/api.dart';
import 'package:charging_station/api/dio_helper.dart';
import 'package:charging_station/blocs/events/events_states.dart';
import 'package:charging_station/models/all_events_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class EventsCubit extends Cubit<EventsStates> {
  EventsCubit() : super(InitEvents());

  /// get events
  Future getAllEvents() async {
    emit(GetEventsLoading());
    final dioHelper = DioHelper();
    try {
      final response = await dioHelper.request(
        url: Api.allEvents,
        method: "GET",
      );
      print(response);
      List<dynamic> eventsJson = response;
      List<AllEventsModel> allEventsModel = List<AllEventsModel>.from(
        eventsJson.map((event) => AllEventsModel.fromJson(event)),
      );

      for (int i = 0; i < eventsJson.length; i++) {
        fetchEventImageUrl(allEventsModel[i].featuredMedia);
      }

      print(allEventsModel);
      emit(SuccessGetEvents(allEventsModel: allEventsModel));
    } catch (e) {
      print("Error: $e");
      emit(ErrorGetEvents(message: "$e"));
    }
  }

  List eventImages = [];
  Future fetchEventImageUrl(int mediaId) async {
    final response = await http.get(
      Uri.parse('https://events-log.com/wp-json/wp/v2/media/$mediaId'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data['source_url']);
      eventImages.add(data['source_url']);
    }
  }
}
