import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:charging_station/blocs/events/events_cubit.dart';
import 'package:charging_station/blocs/events/events_states.dart';
import 'package:charging_station/configs/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    init();

    super.initState();
  }

  init() async {
    await BlocProvider.of<EventsCubit>(context).getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Events',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 21,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                if (state is GetEventsLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: HexColor("#3fa0cb"),
                      value: 35,
                    ),
                  )
                else if (state is SuccessGetEvents)
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          state
                              .allEventsModel
                              .length, // Replace with actual item count, e.g., state.events.length
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: double.infinity,
                              height: 280,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      BlocProvider.of<EventsCubit>(
                                        context,
                                      ).eventImages[index].toString(),
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container(
                                          width: double.infinity,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      height: 205,
                                      width: double.infinity,
                                    ),
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        state
                                            .allEventsModel[index]
                                            .title
                                            .rendered
                                            .toString(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge!.copyWith(
                                          fontSize: 13,
                                          color: HexColor("#3fa0cb"),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
