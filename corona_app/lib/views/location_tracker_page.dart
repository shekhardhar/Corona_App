import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationTracker extends StatefulWidget {
  @override
  _LocationTrackerState createState() => _LocationTrackerState();
}

class _LocationTrackerState extends State<LocationTracker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(8.0),
          child: Text('Add Relative Emails:',
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    // color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
        ),
        RaisedButton(
          child: Text('+ Add more time'),
          onPressed: () {},
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 4, itemBuilder: (context, index) => _buildRow(index)),
        ),
      ],
    );
  }

  _buildRow(int index) {
    return Card(
      child: ListTile(
          leading: Text('At Time: '),
          title: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: RaisedButton(
              child: Text('email'),
              onPressed: () async {
                var _time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                setState(() {
                  if (_time != null) {
                    // timeList[index] = _time.toString();
                  }
                  // setSharedPref();
                });
              },
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // timeList.removeAt(index);
              //TODO: implement cancel notification for the removed
              setState(() {
                // setSharedPref();
              });
            },
          )),
    );
  }
}
