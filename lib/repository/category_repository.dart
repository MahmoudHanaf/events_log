import 'package:charging_station/api/api.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/models/model.dart';

class CategoryRepository {
  ///Load Category
  static Future<List<CategoryModel>?> loadCategory({int? id}) async {
    final Map<String, dynamic> params = {};
    if (id != null) {
      params['category_id'] = id;
    }
    final response = await Api.requestCategory(params);
    if (response.success) {
      return List.from(response.origin['data'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
    }
    AppBloc.messageBloc.add(MessageEvent(message: response.message));
    return null;
  }

  ///Load Location category
  static Future<List<CategoryModel>?> loadLocation(int id) async {
    final response = await Api.requestLocation({"parent_id": id});
    if (response.success) {
      return List.from(response.origin['data'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
    }
    AppBloc.messageBloc.add(MessageEvent(message: response.message));
    return null;
  }

  ///Load Discovery
  static Future<List<DiscoveryModel>?> loadDiscovery() async {
    final response = await Api.requestDiscovery();
    if (response.success) {
      return List.from(response.origin['data'] ?? []).map((item) {
        return DiscoveryModel.fromJson(item);
      }).toList();
    }
    AppBloc.messageBloc.add(MessageEvent(message: response.message));
    return null;
  }
}
