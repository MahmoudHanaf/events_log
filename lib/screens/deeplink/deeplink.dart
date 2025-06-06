import 'package:flutter/material.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/configs/config.dart';
import 'package:charging_station/models/model.dart';

class DeepLink extends StatefulWidget {
  final DeepLinkModel deeplink;
  const DeepLink({super.key, required this.deeplink});

  @override
  State<DeepLink> createState() {
    return _DeepLinkState();
  }
}

class _DeepLinkState extends State<DeepLink> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      _onProcess();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onNavigate({required String route, Object? arguments}) async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: route,
      );
      if (result == null) return;
    }
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, route, arguments: arguments);
  }

  ///On scan
  void _onProcess() async {
    if (widget.deeplink.target.isNotEmpty) {
      if (widget.deeplink.authentication) {
        _onNavigate(
          route: widget.deeplink.target,
          arguments: widget.deeplink.item,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          widget.deeplink.target,
          arguments: widget.deeplink.item,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
