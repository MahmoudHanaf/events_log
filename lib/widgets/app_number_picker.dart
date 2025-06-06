import 'package:flutter/material.dart';
import 'package:charging_station/utils/utils.dart';

class AppNumberPicker extends StatefulWidget {
  final int? value;
  const AppNumberPicker({super.key, this.value});

  @override
  State<AppNumberPicker> createState() {
    return _AppNumberPickerState();
  }
}

class _AppNumberPickerState extends State<AppNumberPicker> {
  int _value = 0;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (_value != 0) {
                              setState(() {
                                _value -= 1;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).dividerColor,
                            ),
                            child: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '$_value',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _value += 1;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 8,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, _value);
                  },
                  child: Text(Translate.of(context).translate('apply')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
