import 'package:digium/constants/endpoint.dart';
import 'package:digium/injector/locator.dart';
import 'package:digium/models/museum_model.dart';
import 'package:digium/pages/museum/museum_detail_page.dart';
import 'package:digium/providers/museum_provider.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/constants/theme.dart';
import 'package:digium/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MuseumCard extends StatelessWidget {
  final MuseumModel museum;

  const MuseumCard({Key? key, required this.museum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MuseumProvider _museumProvider = Provider.of<MuseumProvider>(context);
    final _navLocator = getIt.get<NavigationService>();
    return GestureDetector(
      onTap: () async {
        var isSuccess = await _museumProvider.getMuseum(museumId: museum.id);
        if (isSuccess) {
          _navLocator.navigateTo(
            routeName: "/museum",
            arguments: MuseumDetailArguments(museum: _museumProvider.museum!),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          image: DecorationImage(
            image: NetworkImage(getAssetURL(assetMuseumURL, museum.background)),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            gradient: cardGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      museum.name,
                      maxLines: 2,
                      style: cardTitle1.copyWith(
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
