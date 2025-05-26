import 'package:charging_station/models/model.dart';

abstract class ClaimDetailState {}

class ClaimDetailLoading extends ClaimDetailState {}

class ClaimDetailSuccess extends ClaimDetailState {
  final ClaimModel item;
  ClaimDetailSuccess(this.item);
}
