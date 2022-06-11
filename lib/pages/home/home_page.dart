import 'package:digium/providers/menu_provider.dart';
import 'package:digium/providers/museum_provider.dart';
import 'package:digium/constants/theme.dart';
import 'package:digium/widgets/museum_card.dart';
import 'package:digium/widgets/search_header.dart';
import 'package:digium/widgets/search_widget.dart';
import 'package:digium/widgets/top_museum_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool _isScrollLimitReached = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _handleGetHomePageData();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final newState = _scrollController.offset <=
          (_scrollController.position.minScrollExtent + (5 * kToolbarHeight));

      if (newState != _isScrollLimitReached) {
        setState(() {
          _isScrollLimitReached = newState;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _handleGetHomePageData() async {
    MuseumProvider museumProvider =
        Provider.of<MuseumProvider>(context, listen: false);
    await museumProvider.getMuseums(top: true, paginate: 10, firstFetch: true);
    await museumProvider.getMuseums(
        random: true, paginate: 10, firstFetch: true);
  }

  @override
  Widget build(BuildContext context) {
    MuseumProvider museumProvider = Provider.of<MuseumProvider>(context);
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);

    Widget popularMuseumTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Popular",
              style: TextStyle(
                fontSize: 36,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Most visited Museum",
              style: TextStyle(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    Widget museumListTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Museum List",
              style: TextStyle(
                fontSize: 36,
                fontWeight: bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Here are some museums to check",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    menuProvider.currentIndex = 1;
                  },
                  child: Text(
                    "see all",
                    style: TextStyle(
                      fontWeight: semiBold,
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget popularMuseum() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: museumProvider.topMuseums
                .map(
                  (m) => TopMuseumCard(
                    museum: m,
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

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
            museumProvider.museums
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
        await _handleGetHomePageData();
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: SearchHeader(
              icon: Icons.terrain,
              title: 'Digium',
              search: const Search(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                popularMuseumTitle(),
                popularMuseum(),
                museumListTitle(),
              ],
            ),
          ),
          listMuseums(),
        ],
      ),
    );
  }
}
