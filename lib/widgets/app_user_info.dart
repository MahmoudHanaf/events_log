import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:charging_station/configs/config.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/widgets/app_placeholder.dart';

enum UserViewType { basic, information }

class AppUserInfo extends StatelessWidget {
  final UserModel? user;
  final VoidCallback? onPressed;
  final UserViewType type;

  const AppUserInfo({
    super.key,
    this.user,
    this.onPressed,
    this.type = UserViewType.basic,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case UserViewType.information:
        if (user == null) {
          return AppPlaceholder(
            child: Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 10, width: 100, color: Colors.white),
                      const SizedBox(height: 4),
                      Container(height: 10, width: 100, color: Colors.white),
                      const SizedBox(height: 4),
                      Container(height: 10, width: 150, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        Widget description = Container();
        if (user!.description.isNotEmpty) {
          description = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                user!.description,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        }
        return InkWell(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: user!.image,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Theme.of(context).dividerColor.withOpacity(0.05),
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.error),
                  );
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user!.name,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    description,
                    const SizedBox(height: 2),
                    Text(
                      user!.email,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              RotatedBox(
                quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                child: const Icon(
                  Icons.keyboard_arrow_right,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
        );

      default:
        if (user == null) {
          return AppPlaceholder(
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 10, width: 100, color: Colors.white),
                    const SizedBox(height: 4),
                    Container(height: 10, width: 150, color: Colors.white),
                  ],
                ),
              ],
            ),
          );
        }
        return InkWell(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: user!.image,
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.error),
                  );
                },
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user!.name,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user!.email,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
    }
  }
}
