import 'package:charging_station/models/model.dart';

abstract class BookingDetailState {}

class BookingDetailLoading extends BookingDetailState {}

class BookingDetailSuccess extends BookingDetailState {
  final BookingModel item;
  BookingDetailSuccess(this.item);
}
