import 'dart:convert';

import 'package:charging_station/api/api.dart';
import 'package:charging_station/api/dio_helper.dart';
import 'package:charging_station/blocs/collaborations/collaborations_states.dart';

import 'package:charging_station/models/collaborations_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollaborationsCubit extends Cubit<CollaborationsStates> {
  CollaborationsCubit() : super(InitialCollaborationsState());

  /// get Collaborations
  Future getCollaborations() async {
    emit(GetCollaborationsLoading());
    final dioHelper = DioHelper();
    try {
      final response = await dioHelper.request(
        url: Api.collaborations,
        method: "GET",
      );
      print(response);

      CollaborationsModel collaborationsModel = CollaborationsModel.fromJson(
        response,
      );

      print(collaborationsModel);
      emit(SuccessGetCollaborations(collaborationsModel: collaborationsModel));
    } catch (e) {
      print("Error: $e");
      emit(ErrorGetCollaborations(message: "$e"));
    }
  }
}
