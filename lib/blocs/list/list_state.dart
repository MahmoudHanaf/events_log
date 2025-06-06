import 'package:charging_station/models/model.dart';

abstract class ListState {}

class ListLoading extends ListState {}

class ListSuccess extends ListState {
  final List<ProductModel> list;
  final bool canLoadMore;

  ListSuccess({required this.list, required this.canLoadMore});
}
