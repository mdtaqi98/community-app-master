import 'package:firebase_database/firebase_database.dart';

class Post {
  static const KEY = "key";
  static const DATE = "date";
  static const TITLE = "title";

  static const DESCRIPTION = "description";
  static const POSTCODE = "postcode";
  static const CATEGORY = "category";

  int date;
  String key;
  String title;
  String description;
  String postcode;
  String category;

  Post(this.date, this.title, this.description, this.postcode, this.category);

  Post.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key,
        this.description = snap.value[DESCRIPTION],
        this.postcode = snap.value[POSTCODE],
        this.category = snap.value[CATEGORY],
        this.date = snap.value[DATE],
        this.title = snap.value[TITLE];

  Map toMap() {
    return {
      CATEGORY: category,
      DESCRIPTION: description,
      POSTCODE: postcode,
      TITLE: title,
      DATE: date,
      KEY: key
    };
  }
}
