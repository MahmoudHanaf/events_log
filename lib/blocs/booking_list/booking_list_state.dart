import 'package:charging_station/models/model.dart';

abstract class BookingManagementState {}

class BookingListLoading extends BookingManagementState {}

class BookingListSuccess extends BookingManagementState {
  final List<BookingModel> listBooking;
  final List<BookingModel> listRequest;
  final bool canLoadMore;

  BookingListSuccess({
    required this.listBooking,
    required this.listRequest,
    required this.canLoadMore,
  });
}
