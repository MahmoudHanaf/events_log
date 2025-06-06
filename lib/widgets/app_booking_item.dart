import 'package:flutter/material.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/utils/datetime.dart';
import 'package:charging_station/widgets/app_placeholder.dart';

class AppBookingItem extends StatelessWidget {
  final BookingModel? item;
  final VoidCallback? onPressed;

  const AppBookingItem({super.key, this.item, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      return InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item?.title ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item?.createdBy ?? '',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.date?.dateView ?? '',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item?.status ?? '',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: item?.statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return AppPlaceholder(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 10, width: 100, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(height: 10, width: 150, color: Colors.white),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 100, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 10, width: 100, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
