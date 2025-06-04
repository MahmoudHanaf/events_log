import 'package:bloc/bloc.dart';
import 'package:charging_station/api/api.dart';
import 'package:charging_station/api/dio_helper.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/models/events_model.dart';
import 'package:charging_station/models/model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  /// get events
  Future getEvents() async {
    emit(EventsLoading());
    final dioHelper = DioHelper();
    try {
      final response = await dioHelper.request(
        url: Api.events,
        method: "GET",
        // data: {
        //   "phone_number": "+971562029216",
        //   "password": "12345678",
        //   "deviceid": "22-35-23-A3-56",
        // },
        //  options: Options(headers: {"Content-Type": "application/json"}),
      );
      EventModel eventModel = EventModel.fromJson(response);
      print(eventModel);
      emit(SuccessGetEvents(eventModel: eventModel));
    } catch (e) {
      print("Error: $e");
      emit(ErrorGetEvents(message: "$e"));
    }
  }

  Future<void> onLoad({
    reload = false,
    widget = false,
    CategoryModel? location,
  }) async {
    if (reload) {
      emit(HomeLoading());
    }

    final dioHelper = DioHelper();
    EventModel? eventModel;
    try {
      final response = await dioHelper.request(
        url: Api.events,
        method: "GET",
        // data: {
        //   "phone_number": "+971562029216",
        //   "password": "12345678",
        //   "deviceid": "22-35-23-A3-56",
        // },
        //  options: Options(headers: {"Content-Type": "application/json"}),
      );
      eventModel = EventModel.fromJson(response);
    } catch (e) {
      print("Error: $e");
      emit(ErrorGetEvents(message: "$e"));
    }

    ///Fetch API Home
    ResultApiModel response;
    HomeHeaderModel? headerType;
    if (widget) {
      response = await Api.requestHomeWidget({"option": location?.id});
    } else {
      response = await Api.requestHome({"option": location?.id});
    }
    if (response.success) {
      if (response.origin['data']['header'] != null) {
        headerType = HomeHeaderModel.fromJson(
          response.origin['data']['header'],
        );
      }
      final banner = List<String>.from(
        response.origin['data']['sliders'] ?? [],
      );

      final category =
          List.from(response.origin['data']['categories'] ?? []).map((item) {
            return CategoryModel.fromJson(item);
          }).toList();

      final location =
          List.from(response.origin['data']['locations'] ?? []).map((item) {
            return CategoryModel.fromJson(item);
          }).toList();

      final recent =
          List.from(response.origin['data']['recent_posts'] ?? []).map((item) {
            return ProductModel.fromJson(item);
          }).toList();

      final options =
          List.from(response.origin['data']['options'] ?? []).map((item) {
            return CategoryModel.fromJson(item);
          }).toList();

      final widgets =
          List.from(response.origin['data']['widgets'] ?? []).map((item) {
            final String type = item['type'];
            switch (type) {
              case 'listing':
                return ListingWidgetModel.fromJson(item);
              case 'category':
                return CategoryWidgetModel.fromJson(item);
              case 'location':
                return CategoryWidgetModel.fromJson(item);
              case 'banner':
                return BannerWidgetModel.fromJson(item);
              case 'slider':
                return SliderWidgetModel.fromJson(item);
              // case 'admob':
              // return AdmobWidgetModel.fromJson(item);
              case 'post':
                return BlogWidgetModel.fromJson(item);
              default:
                return DefaultWidgetModel.fromJson(item);
            }
          }).toList();

      ///Notify
      emit(
        HomeSuccess(
          headerType: headerType,
          banner: banner,
          category: category,
          location: location,
          recent: recent,
          options: options,
          widgets: widgets,
          eventModel: eventModel!,
        ),
      );
    } else {
      AppBloc.messageBloc.add(MessageEvent(message: response.message));
    }
  }
}
