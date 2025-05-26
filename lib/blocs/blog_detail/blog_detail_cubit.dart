import 'package:bloc/bloc.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/repository/repository.dart';

class BlogDetailCubit extends Cubit<BlogDetailState> {
  BlogDetailCubit() : super(BlogDetailLoading());
  BlogModel? blog;

  void onLoad(int id) async {
    final result = await BlogRepository.loadBlog(id);
    if (result != null) {
      emit(BlogDetailSuccess(result));
    }
  }
}
