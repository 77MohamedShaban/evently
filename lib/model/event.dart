import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String eventCollection = "Events";
  String? id;
  String? userId;
  String? title;
  String? desc;
  String? category;
  Timestamp? dateAndTime;

  Event({
    this.id,
    this.userId,
    this.title,
    this.desc,
    this.category,
    this.dateAndTime,
  });

  Event.fromFirestore(Map<String, dynamic>? data) {
    id = data?["id"];
    userId = data?["userId"];
    title = data?["title"];
    desc = data?["desc"];
    category = data?["category"];
    dateAndTime = data?["dateAndTime"];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "desc": desc,
      "category": category,
      "dateAndTime": dateAndTime,
    };
  }
}
