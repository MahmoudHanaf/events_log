import 'package:charging_station/configs/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class SubmitEventScreen extends StatelessWidget {
  const SubmitEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Submit Event',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 21,
            // color: HexColor("#595fde"),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(height: 15),
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    itemsContainer(
                      context: context,
                      title: "Add new event",
                      icon: Icons.cloud_upload_outlined,
                      onTap: () {},
                    ),
                    SizedBox(height: 15),
                    itemsContainer(
                      context: context,
                      title: "Submissions",
                      icon: Icons.shopping_bag_outlined,
                      onTap: () {},
                    ),
                    SizedBox(height: 15),
                    itemsContainer(
                      context: context,
                      title: "Bookings",
                      icon: Icons.book_outlined,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemsContainer({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 28),
          SizedBox(width: 18),
          Container(
            width: 120,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 15,
                //color: HexColor("#595fde"),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
