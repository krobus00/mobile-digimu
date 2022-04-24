import 'package:digium/providers/museum_provider.dart';
import 'package:digium/theme.dart';
import 'package:digium/widgets/museum_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MuseumProvider museumProvider =
        Provider.of<MuseumProvider>(context, listen: true);
    museumProvider.getMuseums(null, true, null, null, null);

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
            // const SizedBox(height: 4),
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
                  onPressed: () {},
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
                .map((m) => MuseumCard(
                      museum: m,
                    ))
                .toList(),
          ),
        ),
      );
    }

    return ListView(
      children: [
        popularMuseumTitle(),
        popularMuseum(),
        museumListTitle(),
      ],
    );
  }
}
