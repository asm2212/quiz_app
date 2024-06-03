import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/screen/homes_screen.dart';
import 'package:quiz_app/screen/scorescreen.dart';
import 'package:quiz_app/util/constant.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;

  List<Widget> listScreen = [
    HomeScreen(),
    ScoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: listScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: kItemSelectBottomNav,
        elevation: 5.0,
        unselectedItemColor: kItemUnSelectBottomNav,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          _buildItemBottomNav(FontAwesomeIcons.home, "Home"),
          _buildItemBottomNav(FontAwesomeIcons.history, "Point"),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildItemBottomNav(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: title,
    );
  }
}
