import 'package:charging_station/models/model.dart';

class ClaimListState {}

class ClaimListLoading extends ClaimListState {}

class ClaimListSuccess extends ClaimListState {
  final List<ClaimModel> list;
  final bool canLoadMore;

  ClaimListSuccess({required this.list, required this.canLoadMore});
}
