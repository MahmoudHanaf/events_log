import 'dart:async';

import 'package:charging_station/widgets/drawer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/configs/config.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/screens/home/home_category_item.dart';
import 'package:charging_station/screens/home/home_header_basic.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _homeCubit = HomeCubit();
  StreamSubscription? _submitSubscription;
  StreamSubscription? _reviewSubscription;

  @override
  void initState() {
    // _homeCubit.getEvents();
    super.initState();
    _homeCubit.onLoad(reload: true);

    _reviewSubscription = AppBloc.reviewCubit.stream.listen((state) {
      if (state is ReviewSuccess && state.id != null) {
        _homeCubit.onLoad();
      }
    });
  }

  String formatDate(String inputDate, bool day) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formatted = DateFormat('dd MMMM').format(dateTime); // e.g. 04 July
    return day == true ? formatted.split(" ").first : formatted.split(" ").last;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _homeCubit.close();
    _submitSubscription?.cancel();
    _reviewSubscription?.cancel();
    super.dispose();
  }

  ///Refresh
  Future<void> _onRefresh() async {
    await _homeCubit.onLoad();
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
  }

  List timeList = [
    {"number": "0", "title": "Days"},
    {"number": "00", "title": "HR"},
    {"number": "00", "title": "MIN"},
    {"number": "00", "title": "SEC"},
  ];

  ///On scan
  void _onScan() async {
    final result = await Navigator.pushNamed(context, Routes.scanQR);
    if (result != null) {
      final deeplink = DeepLinkModel.fromString(result as String);
      if (deeplink.target.isNotEmpty) {
        if (!mounted) return;
        Navigator.pushNamed(context, Routes.deepLink, arguments: deeplink);
      }
    }
  }

  ///On select category
  void _onCategory(CategoryModel? item) {
    if (item == null) {
      Navigator.pushNamed(context, Routes.category);
      return;
    }
    if (item.hasChild) {
      Navigator.pushNamed(context, Routes.category, arguments: item);
    } else {
      Navigator.pushNamed(context, Routes.listProduct, arguments: item);
    }
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On handle submit listing
  void _onSubmit() async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.submit,
      );
      if (result == null) return;
    }
    if (!mounted) return;
    Navigator.pushNamed(context, Routes.submit);
  }

  ///Build category UI
  Widget _buildCategory(List<CategoryModel>? category) {
    ///Loading
    Widget content = Wrap(
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children:
          List.generate(8, (index) => index).map((item) {
            return const HomeCategoryItem();
          }).toList(),
    );

    if (category != null) {
      final more = CategoryModel.fromJson({
        "term_id": -1,
        "name": Translate.of(context).translate("more"),
        "icon": "fas fa-ellipsis",
        "color": "#ff8a65",
      });

      content = Wrap(
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          ...category.take(7).toList().map((item) {
            return HomeCategoryItem(item: item, onPressed: _onCategory);
          }),
          HomeCategoryItem(
            item: more,
            onPressed: (item) {
              _onCategory(null);
            },
          ),
        ],
      );
    }

    return Container(padding: const EdgeInsets.all(8), child: content);
  }

  ///Build popular UI
  Widget _buildLocation(List<CategoryModel>? location) {
    ///Loading
    Widget content = ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: AppCategoryItem(type: CategoryViewType.card),
        );
      },
      itemCount: List.generate(8, (index) => index).length,
    );

    if (location != null) {
      content = ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemBuilder: (context, index) {
          final item = location[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AppCategoryItem(
              item: item,
              type: CategoryViewType.card,
              onPressed: () {
                _onCategory(item);
              },
            ),
          );
        },
        itemCount: location.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate('popular_location'),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate('let_find_interesting'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Container(
          height: 180,
          padding: const EdgeInsets.only(top: 4),
          child: content,
        ),
      ],
    );
  }

  ///Build list recent
  Widget _buildRecent(List<ProductModel>? recent) {
    ///Loading
    Widget content = ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: AppProductItem(type: ProductViewType.small),
        );
      },
      itemCount: 8,
    );

    if (recent != null) {
      content = ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = recent[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppProductItem(
              onPressed: () {
                _onProductDetail(item);
              },
              item: item,
              type: ProductViewType.small,
            ),
          );
        },
        itemCount: recent.length,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Translate.of(context).translate('recent_location'),
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate('what_happen'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  ///Build submit button
  Widget? _buildSubmit() {
    if (Application.setting.enableSubmit) {
      return FloatingActionButton(
        mini: true,
        backgroundColor: HexColor("#3fa0cb"),
        onPressed: () {}, //_onSubmit,
        child: const Icon(Icons.add, color: Colors.white),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: HexColor("#3fa0cb"),
        title: Text(
          "Events Log",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },

          child: Icon(Icons.menu, color: Colors.white, size: 32),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                Images.profile,
                color: Colors.white,
                width: 38,
                height: 38,
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        bloc: _homeCubit,
        builder: (context, state) {
          List<String>? banner;
          List<CategoryModel>? category;
          List<CategoryModel>? location;
          List<ProductModel>? recent;

          if (state is HomeSuccess) {
            banner = state.banner;
            category = state.category;
            location = state.location;
            recent = state.recent;
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: HomeHeaderBasic(
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  minHeight: 60 + MediaQuery.of(context).padding.top,
                  banners: banner,
                  onSearch: _onSearch,
                  onScan: _onScan,
                ),
                pinned: true,
              ),
              CupertinoSliverRefreshControl(onRefresh: _onRefresh),
              SliverList(
                delegate: SliverChildListDelegate([
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 120),
                        Container(
                          width: MediaQuery.of(context).size.width * .93,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Text(
                              "Stay Updated! Be the first  to know\nabout new events",
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        AppButton(
                          "Subscribe Now",
                          onPressed: () {
                            //  _homeCubit.getEvents();
                          },
                          //type: ButtonType.text,
                        ),
                        SizedBox(height: 18),
                        Material(
                          elevation: 2,
                          child: Container(
                            width: double.infinity,
                            height: 260,
                            color: Colors.white,

                            child: Column(
                              children: [
                                Wrap(
                                  children: List.generate(
                                    timeList.length,
                                    (index) => Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          left: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 1,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            timeList[index]["number"],
                                            textAlign: TextAlign.center,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 21,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            timeList[index]["title"],
                                            textAlign: TextAlign.center,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleLarge!.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                if (state is HomeSuccess)
                                  Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 170,
                                        color: HexColor("#595fde"),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              formatDate(
                                                //  formate day
                                                state.eventModel.date,
                                                true,
                                              ),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge!.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              formatDate(
                                                //  formate day
                                                state.eventModel.date,
                                                false,
                                              ),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge!.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Colors.grey.shade100,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Next",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge!.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "Upcoming Event",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge!.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                                //color: Colors.white,
                                              ),
                                            ),

                                            Container(
                                              width: 250,
                                              child: Text(
                                                state.eventModel.title,
                                                maxLines: 2,
                                                // textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 21,
                                                      color: HexColor(
                                                        "#595fde",
                                                      ),
                                                    ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size: 22,
                                                ),
                                                Text(
                                                  state.eventModel.venue.name,
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // _buildCategory(category),
                        // _buildLocation(location),
                        // const SizedBox(height: 8),
                        // _buildRecent(recent),
                        // const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildSubmit(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
