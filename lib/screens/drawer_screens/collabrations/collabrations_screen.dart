import 'package:charging_station/blocs/collaborations/collaborations_cubit.dart';
import 'package:charging_station/blocs/collaborations/collaborations_states.dart';
import 'package:charging_station/configs/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hexcolor/hexcolor.dart';

class CollaborationsScreen extends StatefulWidget {
  CollaborationsScreen({super.key});

  @override
  State<CollaborationsScreen> createState() => _CollaborationsScreenState();
}

class _CollaborationsScreenState extends State<CollaborationsScreen> {
  List<Map<String, dynamic>> collaborators = [
    {
      "title": "Societies and Organizations",
      "items": [Images.socities as String],
    },
    {
      "title": "Hospitals and Institutions",
      "items": [Images.hospital1 as String, Images.hospital2 as String],
    },
    {
      "title": "Organizing Companies",
      "items": [Images.company1 as String, Images.company2 as String],
    },
  ];

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await BlocProvider.of<CollaborationsCubit>(context).getCollaborations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CollaborationsCubit, CollaborationsStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                children: [
                  if (state is GetCollaborationsLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: HexColor("#3fa0cb"),
                        value: 0.35,
                      ),
                    )
                  else if (state is SuccessGetCollaborations)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 10,
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Html(
                          data:
                              state.collaborationsModel.content.rendered
                                  .toString(),
                          style: {
                            "p": Style(
                              fontSize: FontSize(16),
                              color: HexColor("#3fa0cb"),
                            ),
                            "h3": Style(
                              fontSize: FontSize(
                                16,
                              ), // Smaller size for headers
                              color: Colors.black87,
                            ),
                            "a": Style(
                              fontSize: FontSize(12), // Smaller size for links
                              color: HexColor("#3fa0cb"),
                              textDecoration: TextDecoration.underline,
                            ),
                            "div": Style(
                              fontSize: FontSize(
                                12,
                              ), // Ensure divs with text content are styled
                              color: HexColor("#3fa0cb"),
                            ),
                          },
                        ),
                      ),
                    ),

                  // ...List.generate(
                  // collaborators.length,
                  // (index) => Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // children: [
                  // Text(
                  // state.collaborationsModel.title.toString(),

                  // /collaborators[index]['title']
                  // style: Theme.of(
                  // context,
                  // ).textTheme.titleLarge!.copyWith(
                  // fontSize: 18,
                  // color: HexColor("#3fa0cb"),
                  // fontWeight: FontWeight.w600,
                  // ),
                  // ),
                  // SizedBox(height: 15),
                  // Wrap(
                  // spacing: 20,
                  // runSpacing: 15,
                  // children: List.generate(
                  // collaborators[index]['items'].length,
                  // (index2) => Material(
                  // elevation: 2,
                  // borderRadius: BorderRadius.circular(10),
                  // child: Container(
                  // width: 150,
                  // height: 150,
                  // decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  // color: Colors.white,
                  // ),
                  // child: Column(
                  // children: [
                  // ClipRRect(
                  // borderRadius: BorderRadius.all(
                  // Radius.circular(10),
                  // ),
                  // child: Image.asset(
                  // collaborators[index]['items'][index2],
                  // fit: BoxFit.cover,
                  //height: 205,
                  //width: double.infinity,
                  // ),
                  // ),
                  // ],
                  // ),
                  // ),
                  // ),
                  // ),
                  // ),
                  // SizedBox(height: 15),
                  // ],
                  // ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
