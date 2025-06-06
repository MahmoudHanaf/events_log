import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charging_station/blocs/bloc.dart';
import 'package:charging_station/configs/config.dart';
import 'package:charging_station/models/model.dart';
import 'package:charging_station/repository/repository.dart';
import 'package:charging_station/screens/profile/profile_header.dart';
import 'package:charging_station/screens/profile/profile_tab.dart';
import 'package:charging_station/utils/utils.dart';
import 'package:charging_station/widgets/widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class Profile extends StatefulWidget {
  final UserModel user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  StreamSubscription? _submitSubscription;
  StreamSubscription? _reviewSubscription;
  final _profileCubit = ProfileCubit();
  final _scrollController = ScrollController();
  final _textSearchController = TextEditingController();
  final _endReachedThreshold = 500;

  bool _isOwner = false;
  FilterModel _filter = FilterModel.fromDefault();
  TabController? _tabController;
  String _currentTab = 'listing';
  UserModel? user;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _isOwner = widget.user.id == AppBloc.userCubit.state?.id;
    _tabController = TabController(length: _isOwner ? 3 : 2, vsync: this);
    _scrollController.addListener(_onScroll);
    _reviewSubscription = AppBloc.reviewCubit.stream.listen((state) {
      if (state is ReviewSuccess && state.id != null) {
        _onRefresh();
      }
    });
    _onRefresh();
  }

  @override
  void dispose() {
    _submitSubscription?.cancel();
    _reviewSubscription?.cancel();
    _profileCubit.close();
    _scrollController.dispose();
    _textSearchController.dispose();
    super.dispose();
  }

  ///On Refresh
  Future<void> _onRefresh() async {
    _profileCubit.page = 1;
    await _profileCubit.onLoad(
      filter: _filter,
      keyword: _textSearchController.text,
      userID: widget.user.id,
      currentTab: _currentTab,
    );
  }

  ///Handle load more
  void _onScroll() async {
    if (_scrollController.position.extentAfter > _endReachedThreshold) return;
    final state = _profileCubit.state;
    if (state is ProfileSuccess && state.canLoadMore && !_loadingMore) {
      _loadingMore = true;
      _profileCubit.page += 1;
      await _profileCubit.onLoad(
        filter: _filter,
        keyword: _textSearchController.text,
        userID: widget.user.id,
        currentTab: _currentTab,
      );
      Future.delayed(const Duration(milliseconds: 250), () {
        _loadingMore = false;
      });
    }
  }

  ///On Change Tab
  void _onTap(int index) {
    Map<int, String> routes = {0: 'listing', 1: 'review'};
    if (_isOwner) {
      routes = {0: 'listing', 1: 'pending', 2: 'review'};
    }
    _currentTab = routes[index]!;
    _onRefresh();
  }

  ///On Search
  void _onSearch(String text) {
    _profileCubit.onSearch(
      filter: _filter,
      keyword: _textSearchController.text,
      userID: widget.user.id,
      currentTab: _currentTab,
    );
  }

  ///On Preview Profile
  void _onProfile(UserModel user) {
    Navigator.pushNamed(context, Routes.profile, arguments: user);
  }

  ///On Scan QR
  void _onQRCode() async {
    if (user != null) {
      final result = await showModalBottomSheet<String?>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          final id = '${user!.id}';
          final link = 'listar://qrcode?type=profile&action=view&id=$id';
          return SafeArea(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    left: 16,
                    right: 16,
                  ),
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
                      Column(
                        children: [
                          Row(
                            children: [
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
                                children: [
                                  Text(
                                    user!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    Translate.of(
                                      context,
                                    ).translate('share_qr_profile'),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    AppButton(
                                      Translate.of(context).translate('share'),
                                      mainAxisSize: MainAxisSize.max,
                                      size: ButtonSize.small,
                                      type: ButtonType.outline,
                                      onPressed: () {
                                        Navigator.pop(context, "share");
                                      },
                                    ),
                                    AppButton(
                                      Translate.of(context).translate('copy'),
                                      mainAxisSize: MainAxisSize.max,
                                      size: ButtonSize.small,
                                      onPressed: () {
                                        Navigator.pop(context, "copy");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 150,
                                child: QrImageView(
                                  data: link,
                                  size: 150,
                                  backgroundColor: Colors.white,
                                  errorStateBuilder: (cxt, err) {
                                    return const Text(
                                      "Uh oh! Something went wrong...",
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                  padding: EdgeInsets.zero,
                                  embeddedImage: NetworkImage(user!.image),
                                  embeddedImageStyle:
                                      const QrEmbeddedImageStyle(
                                        size: Size(24, 24),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
      if (result == 'share') {
        _onShare(user!.url);
      } else if (result == 'copy') {
        _onCopy();
      }
    }
  }

  ///On change filter
  void _onFilter() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.filter,
      arguments: _filter.clone(),
    );
    if (result != null && result is FilterModel) {
      setState(() {
        _filter = result;
      });
      _onRefresh();
    }
  }

  ///On Change Sort
  void _onSort() async {
    final result = await showModalBottomSheet<SortModel?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AppBottomPicker(
          picker: PickerModel(
            selected: [_filter.sort],
            data: Application.setting.sort,
          ),
        );
      },
    );
    if (result != null) {
      _filter.sort = result;
      _onRefresh();
    }
  }

  ///Action Item
  void _onSheetAction(ProductModel item) async {
    final result = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        Widget bookingItem = Container();
        Widget editItem = Container();
        Widget removeItem = Container();
        if (item.priceDisplay.isNotEmpty) {
          bookingItem = AppListTitle(
            title: Translate.of(context).translate("booking"),
            leading: const Icon(Icons.pending_actions_outlined),
            onPressed: () {
              Navigator.pop(context, "booking");
            },
          );
        }
        if (_isOwner) {
          editItem = AppListTitle(
            title: Translate.of(context).translate("edit"),
            leading: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.pop(context, "edit");
            },
          );
          removeItem = AppListTitle(
            title: Translate.of(context).translate("remove"),
            leading: const Icon(Icons.delete_outline),
            onPressed: () {
              Navigator.pop(context, "remove");
            },
          );
        }
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: IntrinsicHeight(
              child: Container(
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
                    Column(
                      children: [
                        bookingItem,
                        editItem,
                        removeItem,
                        AppListTitle(
                          title: Translate.of(context).translate("share"),
                          leading: const Icon(Icons.share_outlined),
                          onPressed: () {
                            Navigator.pop(context, "share");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (!mounted) return;

    switch (result) {
      case "booking":
        Navigator.pushNamed(context, Routes.booking, arguments: item.id);
        break;
      case "remove":
        _onRemove(item);
        break;
      case "share":
        _onShare(item.link);
        break;
      case "edit":
        _onEdit(item);
        break;
      default:
        break;
    }
  }

  ///On Remove
  void _onRemove(ProductModel item) async {
    await ListRepository.removeProduct(item.id);
    _onRefresh();
  }

  ///On Share
  void _onShare(String link) {
    Share.share(link, subject: 'PassionUI');
  }

  void _onCopy() {
    Clipboard.setData(ClipboardData(text: user!.url));
    AppBloc.messageBloc.add(MessageEvent(message: "listing_link_copied"));
  }

  ///On Edit
  void _onEdit(ProductModel item) {
    Navigator.pushNamed(context, Routes.submit, arguments: item);
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On navigate submit form
  void _onSubmit() {
    Navigator.pushNamed(context, Routes.submit);
  }

  ///Build Content
  Widget _buildContent({
    List<ProductModel>? listProduct,
    List<ProductModel>? listProductPending,
    List<CommentModel>? listComment,
    required bool canLoadMore,
  }) {
    ///Loading List Product
    Widget content = SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: AppProductItem(type: ProductViewType.small),
        );
      }, childCount: 15),
    );

    ///Loading List Review
    if (_currentTab == 'review') {
      content = SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: AppCommentItem(),
          );
        }, childCount: 15),
      );
    }

    ///Build List Product
    if (listProduct != null && _currentTab == 'listing') {
      List list = List.from(listProduct);

      ///Empty List
      content = SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.sentiment_satisfied),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    Translate.of(context).translate('list_is_empty'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      if (canLoadMore) {
        list.add(null);
      }
      if (list.isNotEmpty) {
        content = SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = list[index];

            ///Listing
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppProductItem(
                item: item,
                type: ProductViewType.small,
                trailing: IconButton(
                  enableFeedback: true,
                  icon: const Icon(Icons.more_vert_outlined),
                  onPressed: () {
                    _onSheetAction(item);
                  },
                ),
                onPressed: () {
                  _onProductDetail(item);
                },
              ),
            );
          }, childCount: list.length),
        );
      }
    }

    ///Build List Product Pending
    if (listProductPending != null && _currentTab == 'pending') {
      List list = List.from(listProductPending);

      ///Empty List
      content = SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.sentiment_satisfied),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    Translate.of(context).translate('list_is_empty'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      if (canLoadMore) {
        list.add(null);
      }
      if (list.isNotEmpty) {
        content = SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = list[index];

            ///Listing
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppProductItem(
                item: item,
                type: ProductViewType.small,
                trailing: IconButton(
                  enableFeedback: true,
                  icon: const Icon(Icons.more_vert_outlined),
                  onPressed: () {
                    _onSheetAction(item);
                  },
                ),
                onPressed: () {
                  _onProductDetail(item);
                },
              ),
            );
          }, childCount: list.length),
        );
      }
    }

    ///Build List Comment
    if (listComment != null && _currentTab == 'review') {
      List list = List.from(listComment);

      ///Empty List
      content = SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.sentiment_satisfied),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    Translate.of(context).translate('list_is_empty'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      if (canLoadMore) {
        list.add(null);
      }
      if (list.isNotEmpty) {
        content = SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = list[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCommentItem(
                item: item,
                onPressUser: () {
                  _onProfile(item.user);
                },
                showPostName: true,
              ),
            );
          }, childCount: list.length),
        );
      }
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> action = [];

    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: _profileCubit,
      builder: (context, profile) {
        List<ProductModel>? listProduct;
        List<ProductModel>? listProductPending;
        List<CommentModel>? listComment;
        bool showFilter =
            (_currentTab == 'listing' || (_currentTab == 'review' && _isOwner));
        List<Widget> tabs = [
          Tab(text: Translate.of(context).translate('listing')),
          Tab(text: Translate.of(context).translate('review')),
        ];
        bool canLoadMore = false;
        if (profile is ProfileSuccess) {
          user = profile.user;
          listProduct = profile.listProduct;
          listProductPending = profile.listProductPending;
          listComment = profile.listComment;
          canLoadMore = profile.canLoadMore;
        }
        if (_isOwner) {
          if (profile is ProfileSuccess && profile.user.submit == true) {
            action = [
              AppButton(
                Translate.of(context).translate('add'),
                onPressed: _onSubmit,
                type: ButtonType.text,
              ),
            ];
          }
          tabs = [
            Tab(text: Translate.of(context).translate('listing')),
            Tab(text: Translate.of(context).translate('pending')),
            Tab(text: Translate.of(context).translate('review')),
          ];
        }
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: <Widget>[
              SliverAppBar(
                centerTitle: true,
                title: Text(Translate.of(context).translate('profile')),
                actions: action,
                pinned: true,
              ),
              SliverPersistentHeader(
                delegate: ProfileHeader(
                  height: 100,
                  user: user,
                  showQR: _isOwner,
                  onQRCode: _onQRCode,
                ),
                floating: false,
                pinned: false,
              ),
              SliverPersistentHeader(
                delegate: ProfileTab(
                  height: 160,
                  showFilter: showFilter,
                  tabs: tabs,
                  tabController: _tabController,
                  onTap: _onTap,
                  textSearchController: _textSearchController,
                  onSearch: _onSearch,
                  onFilter: _onFilter,
                  onSort: _onSort,
                ),
                pinned: true,
                floating: false,
              ),
              CupertinoSliverRefreshControl(onRefresh: _onRefresh),
              SliverSafeArea(
                top: false,
                sliver: SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: _buildContent(
                    listProduct: listProduct,
                    listProductPending: listProductPending,
                    listComment: listComment,
                    canLoadMore: canLoadMore,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
