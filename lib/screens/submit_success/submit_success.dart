import 'package:flutter/material.dart';
import 'package:charging_station/configs/config.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/widget.dart';

class SubmitSuccess extends StatefulWidget {
  const SubmitSuccess({super.key});

  @override
  State<SubmitSuccess> createState() {
    return _SubmitSuccessState();
  }
}

class _SubmitSuccessState extends State<SubmitSuccess> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On Add More
  void _onSuccess() {
    Navigator.pushReplacementNamed(context, Routes.submit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('completed')),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Translate.of(context).translate('completed'),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Translate.of(
                          context,
                        ).translate('submit_success_message'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AppButton(
                  Translate.of(context).translate('add_more'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _onSuccess,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
