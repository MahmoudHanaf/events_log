import 'package:charging_station/configs/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Events',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 21,
            // color: HexColor("#595fde"),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            //SizedBox(height: 15),
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        Images.event,
                        fit: BoxFit.cover,
                        height: 205,
                        width: double.infinity,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "3rd Annual Conference of GIT and Liver Diseases",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 13,
                        color: HexColor("#3fa0cb"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
