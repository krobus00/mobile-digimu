import 'package:digium/injector/locator.dart';
import 'package:digium/models/onboard_model.dart';
import 'package:digium/services/navigation_service.dart';
import 'package:digium/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int currentIndex = 0;
  late PageController _pageController;
  final _navLocator = getIt.get<NavigationService>();

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardPageInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('OnboardPage', 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: PageView.builder(
        itemCount: screens.length,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(screens[index].bgImg),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "digium",
                      style: TextStyle(
                        fontSize: 38,
                        color: screens[index].btnColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Image(
                    image: AssetImage(screens[index].img),
                    fit: BoxFit.fill,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        screens[index].title,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: screens[index].titleColor,
                        ),
                      ),
                      Text(
                        screens[index].desc,
                        style: TextStyle(
                          fontSize: 18,
                          color: screens[index].descColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 10,
                            child: ListView.builder(
                              itemCount: screens.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 3,
                                      ),
                                      width: currentIndex == index ? 25.0 : 8.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: currentIndex == index
                                            ? screens[index].btnColor
                                            : drakenColor(
                                                screens[index].btnColor, .3),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _storeOnboardPageInfo();
                                  _navLocator.navigateAndReplaceTo(
                                    routeName: "/login",
                                  );
                                },
                                child: Text(
                                  "skip",
                                  style: TextStyle(
                                    color: screens[index].btnColor,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (index == screens.length - 1) {
                                    _storeOnboardPageInfo();
                                    _navLocator.navigateAndReplaceTo(
                                      routeName: "/login",
                                    );
                                  }
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.bounceInOut,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: screens[index].btnColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        index == screens.length - 1
                                            ? "Login"
                                            : "Next",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: screens[index].btnTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
