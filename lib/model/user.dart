class User {
  static const String usersCollection = "Users";
  String? id;
  String? name;
  String? email;
  List<String>? favoriteEvents;

  User({this.id, this.name, this.email});

  User.fromFirestore(Map<String, dynamic>? data) {
    id = data?["id"];
    name = data?["name"];
    email = data?["email"];
    favoriteEvents = List.from(data?["favoriteEvents"] ?? []);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "favoriteEvents": favoriteEvents,
    };
  }
}
