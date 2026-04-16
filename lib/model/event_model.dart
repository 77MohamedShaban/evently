import '../core/resources/AssetsManager.dart';

class EventModel {
  final String title;
  final String desc;
  final String date;
  final String time;
  final String image;
  final String category;

  EventModel({
    required this.title,
    required this.desc,
    required this.date,
    required this.time,
    required this.image,
    required this.category,
  });
  static final List<EventModel> allEvents = [EventModel(title: "We’re going to play football",
      desc: "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
      date: "21 January ",
      time: "12:12 PM",
      image: AssetsManager.sport_dark, category: "meeting")
    ,EventModel(title: "We’re going to play football",
        desc: "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
        date: "21 January ",
        time: "12:12 PM",
        image: AssetsManager.sport_dark, category: "birthday")
  ];
  static final List<EventModel> sportEvents =[];
  static final List<EventModel> birthdayEvents =[];
  static final List<EventModel> meetingEvents =[];
  static final List<EventModel> bookClubEvents =[];
  static final List<EventModel> exhibitionEvents =[];
  static final List<EventModel> favoriteEvents = [EventModel(title: "We’re going to play football",
      desc: "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
      date: "21 January ",
      time: "12:12 PM",
      image: AssetsManager.sport_dark, category: "sport")];
}
