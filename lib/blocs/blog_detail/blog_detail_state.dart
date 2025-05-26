import 'package:charging_station/models/model.dart';

abstract class BlogDetailState {}

class BlogDetailLoading extends BlogDetailState {}

class BlogDetailSuccess extends BlogDetailState {
  final BlogModel blog;

  BlogDetailSuccess(this.blog);
}
