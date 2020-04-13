import 'package:corona_app/config/AppConfig.dart';
import 'package:corona_app/config/ReliefText.dart';
import 'package:corona_app/config/ReliefURL.dart';
import 'package:corona_app/scopped_models/fund_scoped_model.dart';
import 'package:corona_app/views/base_view.dart';
import 'package:corona_app/views/tracker_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../locator.dart';

class FundPage extends StatefulWidget {
  FundPage({Key key}) : super(key: key);
  // final String title;

  @override
  _FundPageState createState() {
    return _FundPageState();
  }
}

class _FundPageState extends State<FundPage> {
  
  AppConfig conf = locator.get<AppConfig>();
  ReliefText reliefText = locator.get<ReliefText>();
  ReliefURL reliefURL = locator.get<ReliefURL>();

  @override
  Widget build(BuildContext context) {
    return BaseView<FundScopedModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          title: Text('Donations'),
        ),
        body: Container(
          decoration: new BoxDecoration(
              color: conf.backgroundColor,
            ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ReliefCard(reliefText.pmcares, reliefURL.pmcares),
                    ReliefCard(reliefText.pmNAT, reliefURL.pmNAT),
                    ReliefCard(reliefText.cmAP, reliefURL.cmAP),
                    ReliefCard(reliefText.cmArP, reliefURL.cmArP),
                    ReliefCard(reliefText.cmAS, reliefURL.cmAS),
                    ReliefCard(reliefText.cmBIH, reliefURL.cmBIH),
                    ReliefCard(reliefText.cmCHATT, reliefURL.cmCHATT),
                    ReliefCard(reliefText.cmDEL, reliefURL.cmDEL),
                    ReliefCard(reliefText.cmGOA, reliefURL.cmGOA),
                    ReliefCard(reliefText.cmGUJ, reliefURL.cmGUJ),
                    ReliefCard(reliefText.cmHAR, reliefURL.cmHAR),
                    ReliefCard(reliefText.cmHP, reliefURL.cmHP),
                    ReliefCard(reliefText.cmJAR, reliefURL.cmJAR),
                    ReliefCard(reliefText.cmKAR, reliefURL.cmKAR),
                    ReliefCard(reliefText.cmMP, reliefURL.cmMP),
                    ReliefCard(reliefText.cmMAH, reliefURL.cmMAH),
                    ReliefCard(reliefText.cmMAN, reliefURL.cmMAN),
                    ReliefCard(reliefText.cmMEG, reliefURL.cmMEG),
                    ReliefCard(reliefText.cmMIZ, reliefURL.cmMIZ),
                    ReliefCard(reliefText.cmNAG, reliefURL.cmNAG),
                    ReliefCard(reliefText.cmODI, reliefURL.cmODI),
                    ReliefCard(reliefText.cmPUN, reliefURL.cmPUN),
                    ReliefCard(reliefText.cmRAJ, reliefURL.cmRAJ),
                    ReliefCard(reliefText.cmTN, reliefURL.cmTN),
                    ReliefCard(reliefText.cmTEL, reliefURL.cmTEL),
                    ReliefCard(reliefText.cmTRI, reliefURL.cmTRI),
                    ReliefCard(reliefText.cmUP, reliefURL.cmUP),
                    ReliefCard(reliefText.cmUTT, reliefURL.cmUTT),
                    ReliefCard(reliefText.cmWB, reliefURL.cmWB),
                    ReliefCard(reliefText.cmJK, reliefURL.cmJK),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class ReliefCard extends StatelessWidget {
  final String txt;
  final String url;

  const ReliefCard(this.txt, this.url);

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
                          style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                          textScaleFactor: 1.3),
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
                          "Donate",
                          style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                          textScaleFactor: 1.3,
                        ),
                        onTap: () async {
                          if (isNumeric(url)) {
                            buildShowDialog(context, url);
                          } else {
                            if (await canLaunch(url)) launch(url);
                          }
                        },
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => PayPage(url)));
                        // },
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

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future buildShowDialog(BuildContext context, String url) {
    String details;
    if (url == "3")
      details =
          "Chief Minister Relief Fund, Andhra Pradesh\n\nBank: Andhra Bank, Vijayawada\nAccount Number: 110310100029039\nIFSC Code: ANDB0003079";
    else if (url == "4")
      details =
          "Chief Minister's Relief Fund, Arunachal Pradesh\n\nBank: State Bank of India\nAccount Number: 10940061389\nIFSC Code: SBIN0006091";
    else if (url == "5")
      details =
          "Assam Arogya Nidhi, Assam\n\nAccount Name:  Assam Arogya Nidhi\nAccount Number: 32124810101\nIFSC Code: SBIN0010755";
    else if (url == "6")
      details =
          "Chief Minister's Bihar Relief Fund\n\nBank: IDBI Bank\nAccount Number: 2065104000002257\nIFSC Code: IBKL0002065";
    else if (url == "7")
      details =
          "CM's Relief Fund for Corona, Chhattisgarh\n\nAccount Number: 30198873179\nIFSC Code: SBIN0004286";
    else if (url == "8")
      details =
          "Delhi CM Relief Fund\n\nBank: Syndicate Bank\nAccount Number: 91042150000237\nIFSC Code: SYNB0009104";
    else if (url == "9")
      details =
          "CM's Covid Relief Fund, Goa\n\nBank: State Bank of India\nAccount Number: 39235546238\nIFSC Code: SBIN0010719";
    else if (url == "10")
      details =
          "Chief Minister's Relief Fund, Gujrat\n\nBank: State Bank of India\nAccount Number: 10354901554\nIFSC Code: SBIN0008434";
    else if (url == "11")
      details =
          "Haryana Corona Relief Fund\n\nBank: State Bank of India\nAccount Number: 39234755902\nIFSC Code: SBIN0001509";
    else if (url == "12")
      details =
          "Himachal Pradesh Covid-19 Solidarity Response Fund\n\nBank:  HDFC Bank\nAccount Number: 50100340267282\nIFSC Code: HDFC0004116";
    else if (url == "13")
      details =
          "Chief Minister Relief Fund, Jharkhand\n\nBank: State Bank of India\nAccount Number: 11049021058\nIFSC Code: SBIN0000167";
    else if (url == "14")
      details =
          "Chief Minister Relief Fund Covid-19, Karnataka\n\nBank: State Bank of India\nAccount Number: 39234923151\nIFSC Code: SBIN0040277";
    else if (url == "15")
      details =
          "Chief Minister Relief Fund (Covid19), Madhya Pradesh\n\nBank: State Bank of India\nAccount Number: 10078152483\nIFSC Code: SBIN0001056";
    else if (url == "16")
      details =
          "Chief Minister's Relief Fund- COVID 19, Maharashtra\n\nBank: State Bank of India\nAccount Number: 39239591720\nIFSC Code: SBIN0000300";
    else if (url == "17")
      details =
          "Chief Minister's Covid-19 Relief Fund, Manipur\n\nBank: Manipur State Co-operative Bank Limited\nAccount Number: 70600875695\nIFSC Code: YESB0MSCB01";
    else if (url == "18")
      details =
          "Meghalaya CM's Relief Fund\n\nBank: State Bank of India\nAccount Number: 38617186405\nIFSC Code: SBIN0006320";
    else if (url == "19")
      details =
          "Chief Minister's Relief Fund, Mizoram\n\nBank: HDFC Bank\nAccount Number: 18141450000025\nIFSC Code: HDFC0001814";
    else if (url == "20")
      details =
          "Chief Minister's Relief Fund, Nagaland\n\nBank: State Bank of India\nAccount Number: 10530527879\nIFSC Code: SBIN0000214";
    else if (url == "21")
      details =
          "Chief Minister Relief Fund (For-Covid 19), Odisha\n\nBank: State Bank of India\nAccount Number: 39235504967\nIFSC Code: SBIN0010236";
    else if (url == "22")
      details =
          "Punjab Chief Minister Relief Fund - Covid 19\n\nBank: HDFC Bank\nAccount Number: 50100333026124\nIFSC Code: HDFC0000213";
    else if (url == "23")
      details =
          "Rajasthan CMRF Covid-19 Mitigation Fund\n\nBank: State Bank of India\nAccount Number: 39233225397\nIFSC Code: SBIN0031031";
    else if (url == "24")
      details =
          "Government of Tamil Nadu CM's Public Relief Fund (CMPRF)\n\nBank: Indian Overseas Bank\nAccount Number: 11720 10000 00070\nIFSC Code: IOBA0001172";
    else if (url == "25")
      details =
          "Telangana Chief Minister Relief Fund\n\nSend cheque to- \nCM Relief Fund,\nRevenue (CMRF) Department\n3rd Floor, D Block\nTelangana Secretariat Hyderabad,\n500022";
    else if (url == "26")
      details =
          "Chief Minister's Relief Fund, Tripura\n\nBank: State Bank of India\nAccount Number: 37939987790\nIFSC Code: SBIN0016355";
    else if (url == "27")
      details =
          "Chief Minister Distress Relief Fund, Uttar Pradesh\n\nBank: Central Bank of India\nAccount Number: 1378820696\nIFSC Code: CBIN0281571";
    else if (url == "28")
      details =
          "Mukhya Mantri Rahat Kosh Uttarakhand\n\nBank: State Bank of India\nAccount Number: 30395954328\nIFSC Code: SBIN0010164";
    else if (url == "29")
      details =
          "West Bengal State Emergency Relief Fund\n\nBank: ICICI Bank\nAccount Number: 628005501339\nIFSC Code: ICIC0006280";
    else if (url == "30")
      details =
          "J& K Relief Fund\n\nBank: J & K Bank\nAccount Number: 0110010100000016\nIFSC Code: JAKA0MOVING\nDemand Draft/Bank Draft: J& K Relief Fund";

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.donut_large,
                size: 70,
                color: Colors.green,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Text("BANK DETAILS\n\n",
                        style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                        textScaleFactor: 1.2),
                    Text(details,
                        style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                        textScaleFactor: 1.0),
                  ],
                ),
              ),
              RaisedButton(
                  child: Text(
                    "Back",
                    style: GoogleFonts.lato(fontStyle: FontStyle.normal),
                    textScaleFactor: 1.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ));
        });
  }
}
