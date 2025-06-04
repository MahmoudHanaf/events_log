import 'package:charging_station/blocs/FAQ/FAQ_states.dart';
import 'package:charging_station/blocs/faq/faq_cubit.dart';
import 'package:charging_station/configs/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hexcolor/hexcolor.dart';

class FAQScreen extends StatefulWidget {
  FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await BlocProvider.of<FAQCubit>(context).getFAQ();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FAQCubit, FAQStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'FAQ',
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
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      //  borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        if (state is GetFAQLoading)
                          Center(
                            child: CircularProgressIndicator(
                              color: HexColor("#3fa0cb"),
                              value: 0.35,
                            ),
                          )
                        else if (state is SuccessGetFAQ)
                          Html(
                            data: state.faqModel.content.rendered.toString(),
                            style: {
                              "p": Style(
                                fontSize: FontSize(16),
                                color: Colors.black87,
                              ),
                            },
                          ),
                      ],
                    ),
                  ),

                  // if (state is GetFAQLoading)
                  // Center(
                  // child: CircularProgressIndicator(
                  // color: HexColor("#3fa0cb"),
                  // value: 0.35,
                  // ),
                  // )
                  // else if (state is SuccessGetFAQ)
                  // ...List.generate(
                  // collaborators.length,
                  // (index) => Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // children: [
                  // Text(
                  // state.FAQModel.title.toString(),

                  ///collaborators[index]['title']
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
                  // height: 205,
                  //  width: double.infinity,
                  // ),
                  // ),
                ],
                // ),
                // ),
                // ),
                // ),
                // ),
                // SizedBox(height: 15),
                // ],
                // ),
                // ),
                //],
              ),
            ),
          ),
        );
      },
    );
  }
}
