import 'package:flutter/material.dart';
import 'database.dart';
import 'auth.dart';
import 'package:flutter/services.dart';
import 'feedback.dart';
import 'package:page_transition/page_transition.dart';

class myHomePage extends StatefulWidget {
  @override
  _myHomePageState createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new FutureBuilder<dynamic>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                    appBar: AppBar(
                        title: Text("MTP Weather"),
                        actions: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: FeedbackForm()));
                                },
                                child: Icon(Icons.feedback),
                              )),
                          Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  signOutGoogle();
                                  SystemNavigator.pop();
                                },
                                child: Icon(Icons.exit_to_app),
                              )),
                          Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                  onTap: () {
                                    SystemNavigator.pop();
                                  },
                                  child: Icon(Icons.close)))
                        ],
                        leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: Duration(seconds: 1),
                                      child: myHomePage()));
                            },
                            child: Icon(Icons.refresh))),
                    body: ListView(children: <Widget>[
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: RichText(
                            text: TextSpan(
                                text: 'Temperature : ',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data['temperature'] + " °C",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: double.parse(snapshot
                                                    .data['temperature']) >
                                                30
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ]),
                          ),
                          subtitle: Text("in Celsius",
                              style: TextStyle(fontSize: 15)),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: RichText(
                            text: TextSpan(
                                text: 'Humidity : ',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data['humidity'] + " %",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: double.parse(
                                                    snapshot.data['humidity']) >
                                                60
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ]),
                          ),
                          subtitle: Text("in Percentage",
                              style: TextStyle(fontSize: 15)),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: Text(
                            "Air Pressure : " +
                                snapshot.data['pressure'] +
                                " hPa",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          subtitle: Text("in HectoPascal",
                              style: TextStyle(fontSize: 15)),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: Text(
                            "Outside Brightness : " +
                                snapshot.data['light'] +
                                " %",
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          subtitle: Text("in Percentage",
                              style: TextStyle(fontSize: 15)),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: RichText(
                            text: TextSpan(
                                text: 'Rain : ',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data['rain'] == 'N'
                                        ? "Not Raining"
                                        : "It is Raining!",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: snapshot.data['rain'] == 'N'
                                            ? Colors.orange
                                            : Colors.blue),
                                  ),
                                ]),
                          ),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: RichText(
                            text: TextSpan(
                                text: "Soil Moisture : ",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: snapshot.data['soil'] + " %",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: double.parse(
                                                      snapshot.data['soil']) >=
                                                  70
                                              ? Colors.green
                                              : Colors.red))
                                ]),
                          ),
                          subtitle: Text("in Percentage",
                              style: TextStyle(fontSize: 15)),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: RichText(
                            text: TextSpan(
                                text: 'LPG Content : ',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data['lpg'] + " ppm",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: double.parse(
                                                    snapshot.data['lpg']) !=
                                                0.00
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ]),
                          ),
                          subtitle: Text("in Parts Per Million",
                              style: TextStyle(fontSize: 15)),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: RichText(
                              text: TextSpan(
                                  text: "CO Content : ",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: snapshot.data['co'] + " ppm",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            double.parse(snapshot.data['co']) !=
                                                    0.00
                                                ? Colors.red
                                                : Colors.green))
                              ])),
                          subtitle: Text("in Parts Per Million",
                              style: TextStyle(fontSize: 15)),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                          title: RichText(
                            text: TextSpan(
                                text: "Smoke Content : ",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: snapshot.data['smoke'] + " ppm",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: double.parse(
                                                      snapshot.data['smoke']) !=
                                                  0.00
                                              ? Colors.red
                                              : Colors.green))
                                ]),
                          ),
                          subtitle: Text("in Parts Per Million",
                              style: TextStyle(fontSize: 15)),
                        ))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                                title: RichText(
                          text: TextSpan(
                              text: "Vibration : ",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: snapshot.data['vibration'] == 'N'
                                        ? "No Movement"
                                        : "Movement detected!",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: snapshot.data['vibration'] == 'N'
                                            ? Colors.green
                                            : Colors.red))
                              ]),
                        )))
                      ])),
                      Card(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: ListTile(
                                title: Text(
                          "Data from: " + snapshot.data['timestamp'],
                          style:
                              TextStyle(fontSize: 22, color: Colors.lightBlue),
                        )))
                      ])),
                    ]));
              } else {
                return Scaffold(
                    appBar: AppBar(
                        title: Text("MTP Weather"),
                        leading: GestureDetector(
                            onTap: () {
                              SystemNavigator.pop();
                            },
                            child: Icon(Icons.close))),
                    body: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image(
                          image: AssetImage('assets/816.gif'),
                        ))
                      ],
                    ));
              }
            }));
  }
}
