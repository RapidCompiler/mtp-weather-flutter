import 'myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'package:page_transition/page_transition.dart';
import 'network.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'ad_manager.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          leading: GestureDetector(
              onTap: () {
                SystemNavigator.pop();
              },
              child: Icon(Icons.close)),
        ),
        body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseUser user;
  TextEditingController controller = new TextEditingController();

  BannerAd _bannerAd;

  // void _loadBannerAd() {
  //   _bannerAd
  //     ..load()
  //     ..show(anchorType: AnchorType.bottom);
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bannerAd.show(anchorType: AnchorType.bottom);
    });
    FirebaseAdMob.instance.initialize(appId: AdManager.bannerAdUnitId);
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    )..load();
  }

  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  void click() {
    signInWithGoogle().then((user) => {
          this.user = user,
          this.dispose(),
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: myHomePage()))
        });
  }

  Widget googleLoginButton() {
    return OutlineButton(
        onPressed: this.click,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        splashColor: Colors.grey,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 25),
                Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Sign in with Google",
                        style: TextStyle(color: Colors.grey, fontSize: 20)))
              ]),
        ));
  }

  Widget noNetwork() {
    return Container(
        alignment: Alignment(0, -0.1),
        child: Text(
            "Your device is not connected to the Internet. Please close the app and try again.",
            style: TextStyle(fontSize: 20)));
  }

  Widget checkNetwork() {
    return Column(children: <Widget>[
      Expanded(child: Image(image: AssetImage('assets/816.gif')))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new FutureBuilder(
            future: checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data) {
                  return Container(
                      alignment: Alignment(0, -0.15),
                      child: googleLoginButton());
                } else {
                  return noNetwork();
                }
              } else {
                return checkNetwork();
              }
            }));
  }
}
