import 'package:charging_station/models/collaborations_model.dart';

abstract class CollaborationsStates {}

class InitialCollaborationsState extends CollaborationsStates {}

class GetCollaborationsLoading extends CollaborationsStates {}

class SuccessGetCollaborations extends CollaborationsStates {
  final CollaborationsModel collaborationsModel;
  SuccessGetCollaborations({required this.collaborationsModel});
}

class ErrorGetCollaborations extends CollaborationsStates {
  final String message;
  ErrorGetCollaborations({required this.message});
}
