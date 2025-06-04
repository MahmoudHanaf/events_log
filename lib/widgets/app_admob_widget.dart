import 'package:flutter/material.dart';

import 'package:charging_station/models/model.dart';

class AppAdmobWidget extends StatefulWidget {
  final AdmobWidgetModel admob;
  const AppAdmobWidget({super.key, required this.admob});

  @override
  createState() {
    return _AppAdmobWidgetState();
  }
}

class _AppAdmobWidgetState extends State<AppAdmobWidget> {
  // BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    //  _createBannerAd();
  }

  @override
  void dispose() {
    //  _bannerAd?.dispose();
    super.dispose();
  }

  ///Create BannerAd
  // void _createBannerAd() {
  // final banner = BannerAd(
  // size: widget.admob.size,
  // request: const AdRequest(),
  // adUnitId: widget.admob.bannerID,
  // listener: BannerAdListener(
  // onAdLoaded: (ad) {
  // setState(() {
  // _bannerAd = ad as BannerAd?;
  // });
  // },
  // onAdFailedToLoad: (ad, error) {
  // ad.dispose();
  // },
  // ),
  // );
  // banner.load();
  // }

  ///Build Banner Ads
  // Widget _buildBanner() {
  // if (_bannerAd != null) {
  // return Align(
  // alignment: Alignment.center,
  // child: SizedBox(
  // width: _bannerAd!.size.width.toDouble(),
  // height: _bannerAd!.size.height.toDouble(),
  // child: AdWidget(ad: _bannerAd!),
  // ),
  // );
  // }
  // return Container();
  // }

  @override
  Widget build(BuildContext context) {
    Widget title = Container();
    Widget description = Container();
    Widget header = Container();
    if (widget.admob.title.isNotEmpty) {
      title = Text(
        widget.admob.title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      );
    }
    if (widget.admob.description.isNotEmpty) {
      description = Text(
        widget.admob.description,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
    if (widget.admob.title.isNotEmpty || widget.admob.description.isNotEmpty) {
      header = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[title, description, const SizedBox(height: 8)],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,

          //  _buildBanner()
        ],
      ),
    );
  }
}
