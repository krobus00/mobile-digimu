import 'package:digium/models/banner_models.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerWidget extends StatefulWidget {
  BannerWidget({Key? key, required this.banners}) : super(key: key);

  List<BannerModel> banners;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<Widget> imageSliders() {
    return widget.banners
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item.image,
                        fit: BoxFit.cover, width: 1000.0)),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final double dw = MediaQuery.of(context).size.width;
    print("width ${(dw - 66) / 167}");
    return Container(
        child: Column(children: [
      CarouselSlider(
        items: imageSliders(),
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 342 / 140,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.banners.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            // onTap: () => print(
            //     "click ${_current} == ${entry.key} ${entry.key == _current}"),
            child: Container(
              width: 6.0,
              height: 6.0,
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]));
    ;
  }
}
