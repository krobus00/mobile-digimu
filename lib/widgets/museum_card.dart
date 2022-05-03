import 'package:digium/constants/endpoint.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/pages/museum/museum_detail_page.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/theme.dart';
import 'package:digium/utils.dart';
import 'package:flutter/material.dart';

class MuseumCard extends StatelessWidget {
  final MuseumModel museum;

  const MuseumCard({Key? key, required this.museum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navLocator = getIt.get<NavigationService>();
    return GestureDetector(
      onTap: () {
        _navLocator.navigateTo(
          routeName: "/museum",
          arguments: MuseumDetailArguments(museum: museum),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              getAssetURL(assetMuseumURL, museum.background),
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: cardGradient,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      museum.name,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: semiBold,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
