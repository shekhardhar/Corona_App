import 'dart:math';

import 'package:corona_app/config/AppConfig.dart';
import 'package:corona_app/locator.dart';
import 'package:corona_app/scopped_models/reminder_scoped_model.dart';
import 'package:corona_app/views/base_view.dart';
import 'package:corona_app/views/custom_reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  AppConfig conf = locator.get<AppConfig>();
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return BaseView<ReminderScopedModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('Reminder'),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(children: [
                    Text('Enable Reminder'),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          _modifyUpcomingNotif(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ]),
                ),
                AbsorbPointer(
                  absorbing: !isSwitched,
                  child: Opacity(
                    opacity: isSwitched ? 1.0 : 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              child: _buildRowCard(
                                  context,
                                  "assets/handwash.png",
                                  Colors.blue,
                                  'Wash your Hands Reminder     '),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomReminder(
                                              reminderRole: 0,
                                            )));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Expanded(
                            child: InkWell(
                              child: _buildRowCard(
                                  context,
                                  "assets/citricfruit.png",
                                  Colors.orange,
                                  'Eat Citric Food Reminder'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomReminder(
                                              reminderRole: 1,
                                            )));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AbsorbPointer(
                  absorbing: !isSwitched,
                  child: Opacity(
                    opacity: isSwitched ? 1.0 : 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              child: _buildRowCard(
                                  context,
                                  "assets/drinkwater.png",
                                  Colors.pink,
                                  'Drink Water Reminder'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomReminder(
                                              reminderRole: 2,
                                            )));
                              },
                            ),
                          ),
                          Expanded(
                            child: Opacity(
                              opacity: 0,
                              child: _buildRowCard(
                                  context,
                                  "assets/drinkwater.png",
                                  Colors.blue,
                                  'Wash your Hands Reminder'),
                            ),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowCard(context, String imagePath, Color color, String title) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  backgroundColor: color,
                  foregroundColor: Colors.white70,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle.copyWith(
                      // color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            )
          ],
        ),
      ),
      color: Colors.white10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  Future<void> _modifyUpcomingNotif(bool isSwitched) async {
    if (isSwitched == false) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.cancelAll();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      for (var role = 0; role < 3; role++) {
        var stringList = prefs.getStringList('timeList' + role.toString());
        if (stringList != null) {
          prefs.setStringList('timeList' + role.toString(), null);
        }
      }
    }
  }
}
