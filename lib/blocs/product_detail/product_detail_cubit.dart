import 'package:bloc/bloc.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/repository/repository.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailLoading());
  ProductModel? product;

  void onLoad(int id) async {
    final result = await ListRepository.loadProduct(id);
    if (result != null) {
      product = result;
      emit(ProductDetailSuccess(product!));
    }
  }

  void onFavorite() {
    if (product != null) {
      product!.favorite = !product!.favorite;
      emit(ProductDetailSuccess(product!));
      if (product!.favorite) {
        AppBloc.wishListCubit.onAdd(product!.id);
      } else {
        AppBloc.wishListCubit.onRemove(product!.id);
      }
    }
  }
}
