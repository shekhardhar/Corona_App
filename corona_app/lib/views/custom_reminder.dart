import 'dart:math';

import 'package:corona_app/config/AppConfig.dart';
import 'package:corona_app/enums/app_enums.dart';
import 'package:corona_app/locator.dart';
import 'package:corona_app/models/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomReminder extends StatefulWidget {
  int reminderRole;
  //  ReminderRole mapping:
  //   0 means washHands
  //   1 means EatCitricFood
  //   2 means DrinkWater
  //
  CustomReminder({Key key, @required this.reminderRole}) : super(key: key);
  @override
  _CustomReminderState createState() => _CustomReminderState();
}

class _CustomReminderState extends State<CustomReminder> {
  String role;
  AppData _appData = locator<AppData>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  TimeOfDay _pickedTime = TimeOfDay.now();

  List<String> timeList = [];
  String label = '';

  @override
  void initState() {
    super.initState();
    role = widget.reminderRole.toString();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosSetting = IOSInitializationSettings();
    var initSettings = InitializationSettings(androidSetting, iosSetting);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: null);
    getSharedPref();
  }

  void setSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('timeList' + role) == null) {
      setState(() {
        label = _appData.labels[widget.reminderRole];
      });
      prefs.setString('label' + role, label);
      prefs.setStringList('timeList' + role, _appData.initialTimeList);
    } else {
      prefs.setString('label' + role, label);
      prefs.setStringList('timeList' + role, timeList);
    }
    _setSheduledNotif();
  }

  getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('timeList' + role) == null) {
      setState(() {
        label = _appData.labels[widget.reminderRole];
        timeList = _appData.initialTimeList;
      });
      prefs.setString('label' + role, label);
      prefs.setStringList('timeList' + role, timeList);
    } else {
      setState(() {
        label = prefs.getString('label' + role);
        timeList = prefs.getStringList('timeList' + role);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppConfig conf = locator.get<AppConfig>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _appData.labels[widget.reminderRole].substring(8) + ' Reminder'),
      ),
      // backgroundColor: Colors.black,
      body: Container(
        decoration: new BoxDecoration(
              color: conf.backgroundColor,
            ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(8.0),
                child: Text('Repeat timing in a day:',
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          // color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Label:  ', style: TextStyle(fontSize: 18)),
                    Flexible(
                        child: TextFormField(
                      initialValue: label == ''
                          ? _appData.labels[widget.reminderRole]
                          : label,
                      onChanged: (text) {
                        label = text;
                      },
                    )),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('+ Add more time'),
                onPressed: () {
                  setState(() {
                    timeList.add(TimeOfDay.now().toString());
                    // _scheduleNotification();
                  });
                  print(timeList);
                  setSharedPref();
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: timeList.length,
                    itemBuilder: (context, index) => this._buildRow(index)),
              ),
              InkWell(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.deepOrange,
                  child: Center(
                      child: Text(
                    'Done',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  )),
                ),
                onTap: () {
                  setState(() {
                    setSharedPref();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildRow(int index) {
    return Card(
      child: ListTile(
          leading: Text('At Time: '),
          title: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: RaisedButton(
              child: Text(to12HourFormat(timeList[index].toString())),
              onPressed: () async {
                var _time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                setState(() {
                  if (_time != null) {
                    timeList[index] = _time.toString();
                  }
                  setSharedPref();
                });
              },
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              timeList.removeAt(index);
              //TODO: implement cancel notification for the removed
              setState(() {
                setSharedPref();
              });
            },
          )),
    );
  }

  Future<void> _cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  _scheduleDaily(id, _label, h, m) async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 1));
    print(scheduledNotificationDateTime.toString());
    //  var scheduledNotificationDateTime =
    // DateTime.now().add(Duration(seconds: 20));
    // var vibrationPattern = Int64List(4);
    // vibrationPattern[0] = 0;
    // vibrationPattern[1] = 1000;
    // vibrationPattern[2] = 5000;
    // vibrationPattern[3] = 2000;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        id.toString(), _label, 'your other channel description',

        // icon: 'secondary_icon',
        // sound: 'slow_spring_board',
        // largeIcon: 'sample_large_icon',
        largeIconBitmapSource: BitmapSource.Drawable,
        // vibrationPattern: vibrationPattern,
        enableLights: true,
        priority: Priority.Max,
        importance: Importance.Max,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.schedule(0, _label, 'scheduled body',
    //     scheduledNotificationDateTime, platformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        _label,
        'Fight with Corona Virus.\n ' + _label,
        Time(h, m, 0),
        platformChannelSpecifics);
    print(Time(h, m, 0).hour);
  }

  String to12HourFormat(String time) {
    var t = time.substring(10, 15);
    var h = int.parse(time.substring(10, 12));
    var m = t.substring(3, 5);

    if (h < 12 || h == 0) {
      if (h == 0) h = 12;
      return h.toString() + ':' + m + ' AM';
    } else {
      h = h - 12;
      return h.toString() + ':' + m + ' PM';
    }
  }

  void _setSheduledNotif() {
    for (var i in timeList) {
      var h = int.parse(i.substring(10, 12));
      var m = int.parse(i.substring(13, 15));
      // print(h.toString() + ':' + m.toString() + '-------------------');
      var id = pow(h, 2) + pow(m, 3) + widget.reminderRole;
      _scheduleDaily(id, label, h, m);
      print(id.toString());
    }
  }
}
