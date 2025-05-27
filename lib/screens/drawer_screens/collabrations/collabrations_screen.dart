import 'package:charging_station/configs/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

class CollaborationsScreen extends StatelessWidget {
  CollaborationsScreen({super.key});

  List<Map<String, dynamic>> collaborators = [
    {
      "title": "Societies and Organizations",
      "items": [Images.socities],
    },
    {
      "title": "Hospitals and Institutions",
      "items": [Images.hospital1, Images.hospital2],
    },
    {
      "title": "Organizing Companies",
      "items": [Images.company1, Images.company2],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collaborations',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 21,
            // color: HexColor("#595fde"),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              collaborators.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collaborators[index]['title'],
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      color: HexColor("#3fa0cb"),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15),

                  Wrap(
                    spacing: 20,
                    runSpacing: 15,
                    children: List.generate(
                      collaborators[index]['items'].length,
                      (index2) => Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Image.asset(
                                  collaborators[index]['items'][index2],
                                  fit: BoxFit.cover,
                                  //  height: 205,
                                  // width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
