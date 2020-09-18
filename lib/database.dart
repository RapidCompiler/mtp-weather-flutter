import 'package:mongo_dart/mongo_dart.dart';

Future<dynamic> getData() async {
  var db = await Db.create(
      "mongodb+srv://flutter:revmatcher@raspberry-pi.orhc2.mongodb.net:27017/projects?");
  await db.open();
  var weather = db.collection('weather');
  var data = await weather.findOne(where.sortBy('_id', descending: true));
  print('closing db');
  await db.close();
  print(data.toString());
  return data;
}
