import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppSearchBar extends StatelessWidget {
  final VoidCallback onSearch;
  final VoidCallback onScan;
  final String title;
  final String number;
  final IconData icon;

  const AppSearchBar({
    super.key,
    required this.onSearch,
    required this.onScan,
    required this.title,
    required this.number,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 80,
        width: 160,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withAlpha(15),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: HexColor("#3fa0cb"), size: 35),
            SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: HexColor("#3fa0cb"),
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: HexColor("#3fa0cb"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
