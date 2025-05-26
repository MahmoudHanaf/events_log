import 'package:flutter/material.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/widgets/widget.dart';

class HomeHeaderBasic extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;
  final List<String>? banners;
  final VoidCallback onSearch;
  final VoidCallback onScan;

  HomeHeaderBasic({
    required this.expandedHeight,
    required this.minHeight,
    required this.onSearch,
    required this.onScan,
    this.banners,
  });

  List categories = [
    {"name": "Events", "number": "537", "icon": Icons.date_range_outlined},
    {"name": "Destination", "number": "174", "icon": Icons.location_on},

    {"name": "Categories", "number": "55", "icon": Icons.check_box_outlined},
    {"name": "Organizers", "number": "65", "icon": Icons.language},
  ];

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Stack(
        alignment: Alignment.bottomCenter,

        children: [
          Container(
            height: 230,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: Opacity(
                    opacity: (1 - shrinkOffset / minExtent).clamp(0.0, 1.0),
                    child: AppImageSwiper(
                      images:
                          banners?.map((e) {
                            return ImageModel(id: 0, full: e, thumb: e);
                          }).toList(),
                      alignment: const Alignment(0.0, 0.7),
                    ),
                  ),
                ),
                SizedBox(height: 65),
              ],
            ),
          ),
          SizedBox(
            height: 90,
            child: Wrap(
              runSpacing: 15,
              spacing: 15,
              children: List.generate(
                categories.length,
                (index) => Container(
                  child: AppSearchBar(
                    onSearch: onSearch,
                    onScan: onScan,
                    title: categories[index]["name"] ?? "",
                    icon: categories[index]["icon"] ?? "",
                    number: categories[index]["number"] ?? "",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
