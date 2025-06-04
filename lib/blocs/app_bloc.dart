import 'package:charging_station/blocs/collaborations/collaborations_cubit.dart';
import 'package:charging_station/blocs/events/events_cubit.dart';
import 'package:charging_station/blocs/faq/faq_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final userCubit = UserCubit();
  static final authenticateCubit = AuthenticationCubit();
  static final wishListCubit = WishListCubit();
  static final reviewCubit = ReviewCubit();
  static final messageBloc = MessageBloc();
  static final eventsBloc = EventsCubit();
  static final collaborationsBloc = CollaborationsCubit();
  static final faqCubit = FAQCubit();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(create: (context) => applicationCubit),
    BlocProvider<UserCubit>(create: (context) => userCubit),
    BlocProvider<AuthenticationCubit>(create: (context) => authenticateCubit),
    BlocProvider<WishListCubit>(create: (context) => wishListCubit),
    BlocProvider<ReviewCubit>(create: (context) => reviewCubit),
    BlocProvider<MessageBloc>(create: (context) => messageBloc),

    //
    BlocProvider<EventsCubit>(create: (context) => eventsBloc),
    BlocProvider<CollaborationsCubit>(create: (context) => collaborationsBloc),
    BlocProvider<FAQCubit>(create: (context) => faqCubit),
  ];

  static void dispose() {
    applicationCubit.close();
    userCubit.close();
    wishListCubit.close();
    authenticateCubit.close();
    reviewCubit.close();
    messageBloc.close();
    eventsBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
