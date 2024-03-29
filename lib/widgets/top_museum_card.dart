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
import 'package:digium/constants/theme.dart';

class TopMuseumCard extends StatelessWidget {
  final MuseumModel museum;

  const TopMuseumCard({Key? key, required this.museum}) : super(key: key);

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
        width: 215,
        height: 170,
        margin: const EdgeInsets.only(
          right: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              getAssetURL(assetMuseumURL, museum.background),
            ),
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
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      museum.yearBuilt.year.toString(),
                      style: caption1.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      museum.name,
                      maxLines: 2,
                      style: cardTitle1.copyWith(
                        fontSize: 18,
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
