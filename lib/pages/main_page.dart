import 'package:digium/pages/home/explore_page.dart';
import 'package:digium/pages/home/home_page.dart';
import 'package:digium/pages/home/profile_page.dart';
import 'package:digium/pages/home/transaction_page.dart';
import 'package:digium/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    Widget cartButton() {
      return FloatingActionButton(onPressed: () {});
    }

    Widget customBottomNav() {
      return BottomNavigationBar(
        currentIndex: menuProvider.currentIndex,
        onTap: (value) {
          setState(() {
            menuProvider.currentIndex = value;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      );
    }

    Widget body() {
      switch (menuProvider.currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const ExplorePage();
        case 2:
          return const TransactionPage();
        case 3:
          return const ProfilePage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: cartButton(),
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
