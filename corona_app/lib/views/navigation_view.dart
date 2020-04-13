import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:corona_app/locator.dart';
import 'package:corona_app/models/app_data.dart';
import 'package:corona_app/scopped_models/home_scoped_model.dart';
import 'package:corona_app/views/base_view.dart';
import 'package:corona_app/views/fund_page.dart';
import 'package:corona_app/views/home_page.dart';
import 'package:corona_app/views/newsList.dart';
import 'package:corona_app/views/reminder_page.dart';
import 'package:corona_app/views/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatefulWidget {
  NavigationView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<NavigationView> {
  int _currentIndex = 0;
  List _children = [
    MyHomePage(),
    // NewsPage(),
    NewsList(),
    ReminderPage(),
    FundPage(),
    SignIn(),
  ];
  AppData _appData = locator<AppData>();
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeScopedModel>(
      builder: (context, child, model) => Scaffold(
        body: SafeArea(child: _children[_currentIndex]),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: _onTapped,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.new_releases),
                title: Text('News'),
                activeColor: Colors.purpleAccent),
            BottomNavyBarItem(
                icon: Icon(Icons.alarm),
                title: Text('Reminder'),
                activeColor: Colors.pink),
            BottomNavyBarItem(
                icon: Icon(Icons.monetization_on),
                title: Text('Fund'),
                activeColor: Colors.blue),
            BottomNavyBarItem(
                icon: Icon(Icons.my_location),
                title: Text('Tracker'),
                activeColor: Colors.blue),
          ],
        ),
      ),
    );
  }

  _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
