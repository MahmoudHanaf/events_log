import 'dart:convert';

import 'package:charging_station/api/api.dart';
import 'package:charging_station/api/dio_helper.dart';
import 'package:charging_station/blocs/FAQ/FAQ_states.dart';
import 'package:charging_station/models/FAQ_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FAQCubit extends Cubit<FAQStates> {
  FAQCubit() : super(InitialFAQState());

  /// get FAQ
  Future getFAQ() async {
    emit(GetFAQLoading());
    final dioHelper = DioHelper();
    try {
      final response = await dioHelper.request(url: Api.faq, method: "GET");
      print(response);

      FAQModel faqModel = FAQModel.fromJson(response);

      print(faqModel);
      emit(SuccessGetFAQ(faqModel: faqModel));
    } catch (e) {
      print("Error: $e");
      emit(ErrorGetFAQ(message: "$e"));
    }
  }
}
