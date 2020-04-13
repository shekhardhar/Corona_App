import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_app/config/AppConfig.dart';
import 'package:corona_app/config/RedirectText.dart';
import 'package:corona_app/config/RedirectURL.dart';
import 'package:corona_app/locator.dart';
import 'package:corona_app/scopped_models/home_scoped_model.dart';
import 'package:corona_app/views/base_view.dart';
import 'package:corona_app/views/tracker_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:store_redirect/store_redirect.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  RedirectURL redirectURL = locator.get<RedirectURL>();
  final databaseRef = Firestore.instance;
  List imageList = [];
  @override
  void initState() {
    super.initState();
    // Fetching List of image links from FireStore
    databaseRef
        .collection('covid19InfoImage')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      setState(() {
        snapshot.documents
            .forEach((f) => imageList.add(f.data['link'].toString()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppConfig conf = locator.get<AppConfig>();
    RedirectText redirectText = locator.get<RedirectText>();
    RedirectURL redirectURL = locator.get<RedirectURL>();
    return BaseView<HomeScopedModel>(
      builder: (context, child, model) => Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: SafeArea(
          child: Container(
            decoration: new BoxDecoration(
              color: conf.backgroundColor,
            ),
            child: ListView(
              children: <Widget>[
                imageList.isEmpty
                    ? Center(
                        child: Container(
                          padding: EdgeInsets.all(50),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.greenAccent,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Stack(children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CarouselSlider(
                              autoPlay: true,
                              items: imageList.map((i) {
                                try {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        // padding: EdgeInsets.all(8.0),
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: i,
                                          fit: BoxFit.fill,
                                          // width: MediaQuery.of(context).size.width * .6,
                                          alignment: Alignment.center,
                                        ),
                                      );
                                    },
                                  );
                                } catch (e) {
                                  print(
                                      '---Exception in home_page.dart in memoryNetwork image load');
                                }
                              }).toList(),
                            ),
                          ),
                        ]),
                      ),
                GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width / 2 -
                                          100,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/whologo.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const ListTile(
                                  title: Text(
                                      'CORONAVIRUS DISEASE (COVID-19)\nGENERAL ADVICE FOR PUBLIC'),
                                  subtitle: Text('\nWORLD HEALTH ORGANIZARION'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TrackerPage(url: redirectURL.general)));
                  },
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CupertinoButton(
                          child: Container(
                            height: MediaQuery.of(context).size.width / 2 - 35,
                            width: MediaQuery.of(context).size.width / 2 - 35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/setu.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            StoreRedirect.redirect(
                                androidAppId: "nic.goi.aarogyasetu",
                                iOSAppId: "1505825357");
                          },
                        ),
                        GestureDetector(
                          child: Text("Aarogya Setu App\nDownload\n",
                              style:
                                  GoogleFonts.lato(fontStyle: FontStyle.normal),
                              textScaleFactor: 1.3),
                          onTap: () {
                            StoreRedirect.redirect(
                                androidAppId: "nic.goi.aarogyasetu",
                                iOSAppId: "1505825357");
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        CupertinoButton(
                          child: Container(
                            height: MediaQuery.of(context).size.width / 2 - 35,
                            width: MediaQuery.of(context).size.width / 2 - 35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/whotwitter.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text("WHO Official Twitter Handle",
                                style: GoogleFonts.lato(
                                    fontStyle: FontStyle.normal),
                                textScaleFactor: 1.3),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrackerPage(
                                        url: redirectURL.whotwitter)));
                          },
                        ),
                        GestureDetector(
                          child: Text("WHO Official Twitter\nFeed\n",
                              style:
                                  GoogleFonts.lato(fontStyle: FontStyle.normal),
                              textScaleFactor: 1.3),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrackerPage(
                                        url: redirectURL.whotwitter)));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    CupertinoButton(
                      child: Container(
                        height: MediaQuery.of(context).size.width / 2 - 35,
                        width: MediaQuery.of(context).size.width / 2 - 35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/mohfwtwitter.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("WHO Official Twitter Handle",
                            style:
                                GoogleFonts.lato(fontStyle: FontStyle.normal),
                            textScaleFactor: 1.3),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TrackerPage(url: redirectURL.whotwitter)));
                      },
                    ),
                    GestureDetector(
                      child: Text(
                          "Ministry of Health and Family Welfare\nOfficial Twitter Feed\n",
                          style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                          textScaleFactor: 1.3),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrackerPage(
                                    url: redirectURL.mohfwtwitter)));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      'Covid-19 TRACKERS',
                      style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                      textScaleFactor: 1.3,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    // margin: EdgeInsets.all(10.0),
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[Text('INDIA COVID-19 TRACKER')],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackerPage(
                                url: 'https://www.covid19india.org/')));
                  },
                ),
                GestureDetector(
                  child: Card(
                    // margin: EdgeInsets.all(10.0),
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[Text('WORLD COVID-19 STATISTICS')],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackerPage(
                                url:
                                    'https://www.worldometers.info/coronavirus/')));
                  },
                ),
                GestureDetector(
                  child: Card(
                    // margin: EdgeInsets.all(10.0),
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[Text('GLOBE COVID-19 VISUALISER')],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrackerPage(
                                url: 'https://www.covidvisualizer.com/')));
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      'Links to WHO and MoHFW',
                      style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                      textScaleFactor: 1.3,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text('Ministry of Health and Family Welfare'),
                          subtitle: Text('Govt. of India'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TrackerPage(url: redirectURL.mohfw)));
                  },
                ),
                GestureDetector(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text('World Health Organization'),
                          subtitle: Text('Coronavirus disease (COVID-19)'),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TrackerPage(url: redirectURL.who)));
                  },
                ),
                SizedBox(
                  width: 10.0,
                ),
                InfoCard(redirectText.infection, redirectURL.infection),
                SizedBox(
                  width: 10.0,
                ),
                InfoCard(redirectText.institute, redirectURL.institute),
                SizedBox(
                  width: 10.0,
                ),
                InfoCard(redirectText.gather, redirectURL.gather),
                SizedBox(
                  width: 10.0,
                ),
                InfoCard(redirectText.animals, redirectURL.animals),
                SizedBox(
                  width: 10.0,
                ),
                InfoCard(redirectText.guides, redirectURL.guides),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String txt;
  final String url;

  const InfoCard(this.txt, this.url);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: <Widget>[
              // Column 1
              Expanded(
                flex: 7,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(txt,
                          style:
                              GoogleFonts.lato(fontStyle: FontStyle.normal),
                          textScaleFactor: 1.1),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: MediaQuery.of(context).size.width / 4,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          "Visit Page",
                          style:
                              GoogleFonts.lato(fontStyle: FontStyle.normal),
                          textScaleFactor: 1.1,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TrackerPage(url: url)));
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
