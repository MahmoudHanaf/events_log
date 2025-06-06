import 'package:bloc/bloc.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/configs/config.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/repository/repository.dart';
import 'package:charging_station/utils/logger.dart';

import 'cubit.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListLoading());

  int page = 1;
  List<ProductModel> list = [];
  PaginationModel? pagination;

  Future<void> onLoad(FilterModel filter) async {
    ///Fetch API
    final result = await ListRepository.loadList(
      page: page,
      perPage: Application.setting.perPage,
      filter: filter,
    );
    if (result != null) {
      if (page == 1) {
        list = result[0];
      } else {
        list.addAll(result[0]);
      }
      pagination = result[1];

      ///Notify
      emit(
        ListSuccess(
          list: list,
          canLoadMore: pagination!.page < pagination!.maxPage,
        ),
      );
    }
  }

  Future<void> onUpdate(int id) async {
    try {
      final exist = list.firstWhere((e) => e.id == id);
      final result = await ListRepository.loadProduct(id);
      if (result != null) {
        list =
            list.map((e) {
              if (e.id == exist.id) {
                return result;
              }
              return e;
            }).toList();

        ///Notify
        emit(
          ListSuccess(
            list: list,
            canLoadMore: pagination!.page < pagination!.maxPage,
          ),
        );
      }
    } catch (error) {
      UtilLogger.log("LIST NOT FOUND UPDATE", error);
    }
  }
}
