import 'package:flutter/material.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/app_placeholder.dart';

class AppRating extends StatelessWidget {
  final RateModel? rate;

  const AppRating({super.key, this.rate});

  @override
  Widget build(BuildContext context) {
    if (rate == null) {
      return AppPlaceholder(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "0.0",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  "${Translate.of(context).translate('out_of')} 0",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              [1, 2, 3, 4, 5].map((item) {
                                return const Icon(Icons.star, size: 12);
                              }).toList(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 8),
                          height: 4,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              [1, 2, 3, 4].map((item) {
                                return const Icon(Icons.star, size: 12);
                              }).toList(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 8),
                          height: 4,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              [1, 2, 3].map((item) {
                                return const Icon(Icons.star, size: 12);
                              }).toList(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 8),
                          height: 4,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              [1, 2].map((item) {
                                return const Icon(Icons.star, size: 12);
                              }).toList(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 8),
                          height: 4,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                              [1].map((item) {
                                return const Icon(Icons.star, size: 12);
                              }).toList(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 8),
                          height: 4,
                          decoration: BoxDecoration(
                            color: Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Loading",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${rate!.avg}",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              "${Translate.of(context).translate('out_of')} 5",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                          [1, 2, 3, 4, 5].map((item) {
                            return const Icon(Icons.star, size: 12);
                          }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8),
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          rate!.five > 0
                              ? FractionallySizedBox(
                                widthFactor: rate!.five,
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )
                              : Container(),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                          [1, 2, 3, 4].map((item) {
                            return const Icon(Icons.star, size: 12);
                          }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8),
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          rate!.four > 0
                              ? FractionallySizedBox(
                                widthFactor: rate!.four,
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )
                              : Container(),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                          [1, 2, 3].map((item) {
                            return const Icon(Icons.star, size: 12);
                          }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8),
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          rate!.three > 0
                              ? FractionallySizedBox(
                                widthFactor: rate!.three,
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )
                              : Container(),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                          [1, 2].map((item) {
                            return const Icon(Icons.star, size: 12);
                          }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8),
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          rate!.two > 0
                              ? FractionallySizedBox(
                                widthFactor: rate!.two,
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )
                              : Container(),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                          [1].map((item) {
                            return const Icon(Icons.star, size: 12);
                          }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 8),
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          rate!.one > 0
                              ? FractionallySizedBox(
                                widthFactor: rate!.one,
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )
                              : Container(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${rate!.total} ${Translate.of(context).translate('rating')}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
