import 'package:flutter/material.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/utils/utils.dart';

enum PageType { map, list }

class AppNavBar extends StatelessWidget {
  final PageType pageStyle;
  final SortModel? currentSort;
  final VoidCallback onChangeSort;
  final VoidCallback onChangeView;
  final VoidCallback onFilter;
  final IconData iconModeView;

  const AppNavBar({
    super.key,
    this.pageStyle = PageType.list,
    this.currentSort,
    required this.onChangeSort,
    required this.iconModeView,
    required this.onChangeView,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    String sortTitle = Translate.of(context).translate('sort');
    if (currentSort != null) {
      sortTitle = Translate.of(context).translate(currentSort!.title);
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                enableFeedback: true,
                icon: const Icon(Icons.swap_vert),
                onPressed: onChangeSort,
              ),
              Text(sortTitle, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    enableFeedback: true,
                    icon: Icon(iconModeView),
                    onPressed: onChangeView,
                  ),
                  SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ],
              ),
              IconButton(
                enableFeedback: true,
                icon: const Icon(Icons.track_changes),
                onPressed: onFilter,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
