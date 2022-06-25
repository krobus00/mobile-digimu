import 'package:digium/widgets/museum_card.dart';
import 'package:flutter/material.dart';
import 'package:digium/constants/theme.dart';
import 'package:provider/provider.dart';
import 'package:digium/providers/museum_provider.dart';
import 'package:digium/widgets/header_museum.dart';
import 'package:digium/widgets/search_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late ScrollController _controller;
  final int _paginate = 10;
  int _page = 1;
  bool _isLoading = false;

  void _loadMore() async {
    if (!_isLoading) {
      _page += 1;
      MuseumProvider _museumProvider =
          Provider.of<MuseumProvider>(context, listen: false);
      setState(() {
        _isLoading = true;
      });
      bool hasNext = await _museumProvider.getMuseums(
        search: _museumProvider.search,
        firstFetch: false,
        page: _page,
        paginate: _paginate,
      );
      if (!hasNext) {
        _page -= 1;
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _handleLoadData();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  _handleLoadData() async {
    MuseumProvider _museumProvider =
        Provider.of<MuseumProvider>(context, listen: false);
    await _museumProvider.getMuseums(
      firstFetch: true,
      page: _page,
      paginate: _paginate,
      search: _museumProvider.search,
    );
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    MuseumProvider _museumProvider = Provider.of<MuseumProvider>(context);

    Widget listMuseums() {
      return SliverPadding(
        padding: EdgeInsets.all(defaultMargin),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1,
          ),
          delegate: SliverChildListDelegate(
            _museumProvider.museums
                .map(
                  (m) => MuseumCard(museum: m),
                )
                .toList(),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _handleLoadData();
      },
      child: CustomScrollView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        semanticChildCount: _museumProvider.museums.length,
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: MuseumHeader(
              icon: Icons.terrain,
              title: 'Digium',
              search: const Search(),
            ),
          ),
          listMuseums(),
        ],
      ),
    );
  }
}
