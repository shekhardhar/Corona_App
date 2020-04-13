import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_app/scopped_models/sign_in_scoped_model.dart';
import 'package:corona_app/services/auth.dart';
import 'package:corona_app/views/base_view.dart';
import 'package:corona_app/views/location_tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final databaseRef = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign in for location Tracker',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              child: CircleAvatar(
                child: Icon(Icons.location_on),
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Sign In using Google'),
                onPressed: () {
                  authService.googleSignIn().then((user) async {
                    //Shared pref store
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('userEmail', user.email.toString());

                    Firestore.instance
                        .collection('covid19Info')
                        .document()
                        .setData({
                      'email': user.email.toString(),
                      'location': '87415414'
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GetLocation(user)));
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GetLocation extends StatefulWidget {
  var user;

  GetLocation(this.user);
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  GeolocationStatus geolocationStatus;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text('Location Tracker '),
                onPressed: () async {
                  var status =
                      await Geolocator().checkGeolocationPermissionStatus();
                  setState(() {
                    geolocationStatus = status;
                  });
                  print(geolocationStatus.toString() + '----------');
                  if (geolocationStatus == GeolocationStatus.granted) {
                    Position position = await Geolocator().getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    print(position.toString());

                    //store to firebase
                    Firestore.instance.collection('users').document().setData({
                      'email': widget.user.email.toString(),
                      'location': position.toString(),
                    });
                  } else if (geolocationStatus == GeolocationStatus.disabled) {
                    _buildShowDialog(context, "Location Not Enabled",
                        "Please go to Settings and Enable the locations");
                  } else {
                    _buildShowDialog(context, "Location Permission Not Granted",
                        "Please go to Settings > Apps > AppName > Permissions > Allow Location Permission");
                  }
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => LocationTracker()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _buildShowDialog(BuildContext context, title, body) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
