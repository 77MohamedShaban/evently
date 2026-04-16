import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/event.dart';
import 'package:evently/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FirestoreManager {
  static CollectionReference<User> getUsersCollection() {
    CollectionReference<User> collection = FirebaseFirestore.instance
        .collection(User.usersCollection)
        .withConverter(
          fromFirestore: (snapshot, options) {
            User user = User.fromFirestore(snapshot.data());
            return user;
          },
          toFirestore: (user, options) {
            return user.toFirestore();
          },
        );
    return collection;
  }

  static Future<void> saveUser(User user) {
    var collection = getUsersCollection();
    var document = collection.doc(user.id);
    return document.set(user);
  }

  static Future<User?> getUser() async {
    var collection = getUsersCollection();
    var document = collection.doc(auth.FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await document.get();
    var user = snapshot.data();
    return user;
  }

  static Future<User?> getSpecificUser(String id) async {
    var collection = getUsersCollection();
    var document = collection.doc(id);
    var snapshot = await document.get();
    var user = snapshot.data();
    return user;
  }

  static CollectionReference<Event> getEventCollection() {
    CollectionReference<Event> collection = FirebaseFirestore.instance
        .collection(Event.eventCollection)
        .withConverter(
          fromFirestore: (snapshot, options) {
            Event event = Event.fromFirestore(snapshot.data());
            return event;
          },
          toFirestore: (event, options) {
            return event.toFirestore();
          },
        );
    return collection;
  }

  static Future<String> saveEvent(Event event) async {
    var collection = getEventCollection();
    var document = collection.doc();
    event.id = document.id;
    await document.set(event);
    return document.id;
  }
  static Future<void> updateEvent(Event event) {
    var collection = getEventCollection();
    var document = collection.doc(event.id);
    return document.set(event);
  }
  static Future<void> deleteEvent(String eventId) {
    var collection = getEventCollection();
    var document = collection.doc(eventId);
    return document.delete();
  }

  /// Future
  static Future<List<Event>> getAllEvents() async {
    var collection = getEventCollection();
    var querySnapshot = await collection.get();
    var docsList = querySnapshot.docs;
    List<Event> events = docsList.map((document) => document.data()).toList();
    return events;
  }

  /// Future
  static Future<List<Event>> getFilteredEvents(String category) async {
    var collection = getEventCollection().where(
      "category",
      isEqualTo: category,
    );
    var querySnapshot = await collection.get();
    var docsList = querySnapshot.docs;
    List<Event> events = docsList.map((document) => document.data()).toList();
    return events;
  }

  static Stream<List<Event>> getAllEventsStream() {
    var collection = getEventCollection().orderBy(
      "dateAndTime",
      descending: false,
    );
    var querySnapshotStream = collection.snapshots();
    var docsStream = querySnapshotStream.map(
      (querySnapshot) => querySnapshot.docs,
    );
    Stream<List<Event>> events = docsStream.map(
      (docsList) => docsList.map((document) => document.data()).toList(),
    );
    return events.asBroadcastStream();
  }

  static Stream<List<Event>> getFilteredEventsStream(String category) {
    var collection = getEventCollection()
        .where("category", isEqualTo: category)
        .orderBy("dateAndTime", descending: false);
    var querySnapshotStream = collection.snapshots();
    var docsStream = querySnapshotStream.map(
      (querySnapshot) => querySnapshot.docs,
    );
    Stream<List<Event>> events = docsStream.map(
      (docsList) => docsList.map((document) => document.data()).toList(),
    );
    return events.asBroadcastStream();
  }

  static CollectionReference<Event> getFavoriteCollection() {
    var userCollection = getUsersCollection();
    var userDocument = userCollection.doc(
      auth.FirebaseAuth.instance.currentUser!.uid,
    );
    var favoriteCollection = userDocument
        .collection("Favorite")
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Event.fromFirestore(snapshot.data());
          },
          toFirestore: (event, options) {
            return event.toFirestore();
          },
        );
    return favoriteCollection;
  }

  static Future<void> addEventToFavorite(Event event) {
    var collection = getFavoriteCollection();
    var document = collection.doc(event.id);
    return document.set(event);
  }

  static Future<void> deleteEventFromFavorite(String eventId) {
    var collection = getFavoriteCollection();
    var document = collection.doc(eventId);
    return document.delete();
  }

  static Future<void> updateFavoritesListToUser(List<String> favoriteEvents){
    var userCollection = getUsersCollection();
    var userDocument = userCollection.doc(
      auth.FirebaseAuth.instance.currentUser!.uid,
    );
   return userDocument.update({
      "favoriteEvents": favoriteEvents
    });
  }
  static Future<void> updateEventINFavoriteCollection(Event event) {
    var collection = getFavoriteCollection();
    var document = collection.doc(event.id);
    return document.set(event);
  }
  static Stream<List<Event>> getFavoriteEventsStream() {
    var collection = getFavoriteCollection().orderBy(
      "dateAndTime",
      descending: false,
    );
    var querySnapshotStream = collection.snapshots();
    var docsStream = querySnapshotStream.map(
          (querySnapshot) => querySnapshot.docs,
    );
    Stream<List<Event>> events = docsStream.map(
          (docsList) => docsList.map((document) => document.data()).toList(),
    );
    return events.asBroadcastStream();
  }

/////////////////////////////  My Evens
  static CollectionReference<Event> getMyEventsCollection() {
    var userCollection = getUsersCollection();
    var userDocument = userCollection.doc(
      auth.FirebaseAuth.instance.currentUser!.uid,
    );
    var myEventsCollection = userDocument
        .collection("MyEvents")
        .withConverter(
      fromFirestore: (snapshot, options) {
        return Event.fromFirestore(snapshot.data());
      },
      toFirestore: (event, options) {
        return event.toFirestore();
      },
    );
    return myEventsCollection;
  }

  static Future<void> addEventToMyEvent(Event event) {
    var collection = getMyEventsCollection();
    var document = collection.doc(event.id);
    return document.set(event);
  }

  static Stream<List<Event>> getMyEventsStream() {
    var collection = getMyEventsCollection().orderBy(
      "dateAndTime",
      descending: false,
    );
    var querySnapshotStream = collection.snapshots();
    var docsStream = querySnapshotStream.map(
          (querySnapshot) => querySnapshot.docs,
    );
    Stream<List<Event>> events = docsStream.map(
          (docsList) => docsList.map((document) => document.data()).toList(),
    );
    return events.asBroadcastStream();
  }

  static Future<void> deleteEventFromMyEvents(String eventId) {
    var collection = getMyEventsCollection();
    var document = collection.doc(eventId);
    return document.delete();
  }
  static Future<void> updateEventINMyEventsCollection(Event event) {
    var collection = getMyEventsCollection();
    var document = collection.doc(event.id);
    return document.set(event);
  }

}
