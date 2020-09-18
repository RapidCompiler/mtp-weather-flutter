import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final name = TextEditingController();
  final email = TextEditingController();
  final feedback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Feedback Form")),
        body: Column(children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: Container(
                  width: 280,
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: TextField(
                      controller: name,
                      decoration:
                          InputDecoration(hintText: "Enter your Name")))),
          Container(
              width: 280,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: TextField(
                  controller: email,
                  decoration: InputDecoration(hintText: "Enter your Email"))),
          Container(
              width: 280,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  controller: feedback,
                  autocorrect: true,
                  decoration:
                      InputDecoration(hintText: "What would you like to say!")))
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (name.text != "" && email.text != "" && feedback.text != "") {
                final Email mailOptions = Email(
                  body: email.text + "\n" + feedback.text,
                  subject: name.text,
                  recipients: ['revmatcher@sanjaysuresh.com'],
                );
                FlutterEmailSender.send(mailOptions);
              }
            },
            child: Icon(Icons.send)));
  }
}
