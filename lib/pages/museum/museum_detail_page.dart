import 'package:digium/constants/endpoint.dart';
import 'package:digium/constants/theme.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/pages/museum/about_tab.dart';
import 'package:digium/pages/museum/galleries_tab.dart';
import 'package:digium/pages/transaction/create_transaction_tab.dart';
import 'package:digium/utils/utils.dart';
import 'package:flutter/material.dart';

class MuseumDetailPage extends StatefulWidget {
  const MuseumDetailPage({Key? key}) : super(key: key);

  @override
  State<MuseumDetailPage> createState() => _MuseumDetailPageState();
}

class _MuseumDetailPageState extends State<MuseumDetailPage>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'About'),
    Tab(text: 'Galleries'),
    Tab(text: 'Buy Ticket'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as MuseumDetailArguments;
    final museum = arguments.museum;

    return Scaffold(
      body: DefaultTabController(
        length: myTabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // backgroundColor: Colors.white,
                expandedHeight: 365.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    museum.name,
                    style: title2.copyWith(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  background: Image.network(
                    getAssetURL(assetMuseumURL, museum.background),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    controller: _tabController,
                    tabs: myTabs,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              AboutTab(museum: museum),
              GalleriesTab(galleries: museum.galleries ?? []),
              CreateTransactionTab(museum: museum),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class MuseumDetailArguments {
  final MuseumModel museum;

  MuseumDetailArguments({required this.museum});
}
