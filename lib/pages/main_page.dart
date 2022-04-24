import 'package:digium/pages/home/explore_page.dart';
import 'package:digium/pages/home/home_page.dart';
import 'package:digium/pages/home/profile_page.dart';
import 'package:digium/pages/home/transaction_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget cartButton() {
      return FloatingActionButton(onPressed: () {});
    }

    Widget customBottomNav() {
      return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
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
      switch (_currentIndex) {
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
