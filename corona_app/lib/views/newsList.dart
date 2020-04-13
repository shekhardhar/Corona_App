import 'package:corona_app/config/AppConfig.dart';
import 'package:corona_app/config/constants.dart';
import 'package:corona_app/locator.dart';
import 'package:corona_app/models/newsArticle.dart';
import 'package:corona_app/services/webservice.dart';
import 'package:corona_app/views/tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsListState extends State<NewsList> {
  List<NewsArticle> _newsArticles = List<NewsArticle>();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {
    try {
      Webservice().load(NewsArticle.all).then((newsArticles) => {
            setState(() => {_newsArticles = newsArticles})
          });
    } catch (e) {
      print('---Exception in newList.dart while callig Webservice');
    }
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    try {
      return ListTile(
        title: _newsArticles[index].urlToImage == null
            ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL)
            : Image.network(_newsArticles[index].urlToImage),
        subtitle:
            Text(_newsArticles[index].title, style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                          textScaleFactor: 1.3,),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TrackerPage(url: _newsArticles[index].url)));
        },
      );
    } catch (e) {
      print('---Exception in newList.dart loading Image.Network');
    }
  }

  @override
  Widget build(BuildContext context) {
    AppConfig conf = locator.get<AppConfig>();
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: ListView.builder(
          itemCount: _newsArticles.length,
          itemBuilder: _buildItemsForListView,
        ));
  }
}

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState();
}
