import 'package:flutter/material.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/widget.dart';

class DetailSlot extends StatefulWidget {
  final SlotBookingModel bookingStyle;
  final VoidCallback onCalcPrice;

  const DetailSlot({
    super.key,
    required this.bookingStyle,
    required this.onCalcPrice,
  });

  @override
  State<DetailSlot> createState() {
    return _DetailSlotState();
  }
}

class _DetailSlotState extends State<DetailSlot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Show number picker
  void _onPicker(int? init, Function(int) callback) async {
    final result = await showModalBottomSheet<int?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AppNumberPicker(value: init);
      },
    );
    if (result != null) {
      callback(result);
      widget.onCalcPrice();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppPickerItem(
                      leading: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).hintColor,
                      ),
                      value: widget.bookingStyle.adult?.toString(),
                      title: Translate.of(context).translate('adult'),
                      onPressed: () {
                        _onPicker(widget.bookingStyle.adult, (value) {
                          setState(() {
                            widget.bookingStyle.adult = value;
                          });
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppPickerItem(
                      leading: Icon(
                        Icons.child_friendly_outlined,
                        color: Theme.of(context).hintColor,
                      ),
                      value: widget.bookingStyle.children?.toString(),
                      title: Translate.of(context).translate('children'),
                      onPressed: () {
                        _onPicker(widget.bookingStyle.children, (value) {
                          setState(() {
                            widget.bookingStyle.children = value;
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translate.of(context).translate('total'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.bookingStyle.price,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
