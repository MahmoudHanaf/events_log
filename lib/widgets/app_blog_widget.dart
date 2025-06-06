import 'package:flutter/material.dart';
import 'package:charging_station/configs/config.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/widgets/widget.dart';

class AppBlogWidget extends StatelessWidget {
  final BlogWidgetModel widget;
  const AppBlogWidget({super.key, required this.widget});

  Widget _buildWidgetDirection(BuildContext context) {
    if (widget.direction == Axis.horizontal) {
      final Map<BlogViewType, double> widthHorizontal = {
        BlogViewType.grid: 200,
        BlogViewType.list: 300,
        BlogViewType.block: 300,
      };
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children:
                widget.items.map((item) {
                  return Container(
                    padding: const EdgeInsets.only(left: 12),
                    width: widthHorizontal[widget.layout]!,
                    child: AppBlogItem(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.blogDetail,
                          arguments: item,
                        );
                      },
                      item: item,
                      type: widget.layout,
                    ),
                  );
                }).toList(),
          ),
        ),
      );
    }

    Widget content = ListView.separated(
      scrollDirection: widget.direction,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return AppBlogItem(
          onPressed: () {
            Navigator.pushNamed(context, Routes.blogDetail, arguments: item);
          },
          item: item,
          type: widget.layout,
        );
      },
      itemCount: widget.items.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 12);
      },
    );

    if (widget.layout == BlogViewType.grid) {
      final screenWidth = MediaQuery.of(context).size.width;
      const spacing = 12 + 32;
      final widthGrid = screenWidth - spacing;
      content = Wrap(
        runSpacing: 12,
        spacing: 12,
        children:
            widget.items.map((item) {
              return SizedBox(
                width: widthGrid / 2,
                child: AppBlogItem(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.blogDetail,
                      arguments: item,
                    );
                  },
                  item: item,
                  type: widget.layout,
                ),
              );
            }).toList(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Container();
    Widget description = Container();
    Widget header = Container();
    if (widget.title.isNotEmpty) {
      title = Text(
        widget.title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      );
    }
    if (widget.description.isNotEmpty) {
      description = Text(
        widget.description,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
    if (widget.title.isNotEmpty || widget.description.isNotEmpty) {
      header = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[title, description, const SizedBox(height: 8)],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [header, _buildWidgetDirection(context)],
    );
  }
}
