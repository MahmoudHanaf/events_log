import 'package:flutter/material.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/app_button.dart';

class CategoryPicker extends StatefulWidget {
  final PickerModel picker;

  const CategoryPicker({super.key, required this.picker});

  @override
  State<CategoryPicker> createState() {
    return _CategoryPickerState();
  }
}

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onApply() {
    Navigator.pop(context, widget.picker.selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.picker.title!),
        actions: <Widget>[
          AppButton(
            Translate.of(context).translate('apply'),
            onPressed: onApply,
            type: ButtonType.text,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            children:
                widget.picker.data.map((item) {
                  final selected = widget.picker.selected.contains(item);
                  return FilterChip(
                    selected: selected,
                    label: Text(item.title),
                    onSelected: (value) {
                      if (value) {
                        widget.picker.selected.add(item);
                      } else {
                        widget.picker.selected.remove(item);
                      }
                      setState(() {});
                    },
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
