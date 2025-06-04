import 'package:charging_station/models/FAQ_model.dart';

abstract class FAQStates {}

class InitialFAQState extends FAQStates {}

class GetFAQLoading extends FAQStates {}

class SuccessGetFAQ extends FAQStates {
  final FAQModel faqModel;
  SuccessGetFAQ({required this.faqModel});
}

class ErrorGetFAQ extends FAQStates {
  final String message;
  ErrorGetFAQ({required this.message});
}
