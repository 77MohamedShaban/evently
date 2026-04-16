import 'package:evently/core/remote/network/firestore_manager.dart';
import 'package:evently/model/event.dart';
import 'package:flutter/material.dart';
import '../../../../../core/resources/StringsManager.dart';
import '../../../widgets/event_item.dart';

class ViewTabs extends StatelessWidget {
  final TabController controller;

  ViewTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return TabBarView(
      controller: controller,
      children: [
        StreamBuilder(
          stream: FirestoreManager.getAllEventsStream(),
          builder: (context, snapshot) {
            /// loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            /// error
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            /// success
            List<Event> allEvents = snapshot.data ?? [];
            if(allEvents.isEmpty){
              return Center(child: Text(StringsManager.noEventsYet));
            }
            return ListView.separated(
              itemBuilder: (context, index) =>
                  EventItem(event: allEvents[index]),
              itemCount: allEvents.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: heightScreen * 0.02),
            );
          },
        ),

        StreamBuilder(
          stream: FirestoreManager.getFilteredEventsStream(StringsManager.sport),
          builder: (context, snapshot) {
            /// loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            /// error
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            /// success
            List<Event> sportEvents = snapshot.data ?? [];
            if(sportEvents.isEmpty){
              return Center(child: Text(StringsManager.noEventsYet));
            }
            return ListView.separated(
              itemBuilder: (context, index) =>
                  EventItem(event: sportEvents[index]),
              itemCount: sportEvents.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: heightScreen * 0.02),
            );
          },
        ),
        StreamBuilder(
          stream: FirestoreManager.getFilteredEventsStream(StringsManager.birthday),
          builder: (context, snapshot) {
            /// loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            /// error
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            /// success
            List<Event> birthdayEvents = snapshot.data ?? [];
            if(birthdayEvents.isEmpty){
              return Center(child: Text(StringsManager.noEventsYet));
            }
            return ListView.separated(
              itemBuilder: (context, index) =>
                  EventItem(event: birthdayEvents[index]),
              itemCount: birthdayEvents.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: heightScreen * 0.02),
            );
          },
        ),
        StreamBuilder(
          stream: FirestoreManager.getFilteredEventsStream(StringsManager.meeting),
          builder: (context, snapshot) {
            /// loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            /// error
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            /// success
            List<Event> meetingEvents = snapshot.data ?? [];
            if(meetingEvents.isEmpty){
              return Center(child: Text(StringsManager.noEventsYet));
            }
            return ListView.separated(
              itemBuilder: (context, index) =>
                  EventItem(event: meetingEvents[index]),
              itemCount: meetingEvents.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: heightScreen * 0.02),
            );
          },
        ),
        StreamBuilder(
          stream: FirestoreManager.getFilteredEventsStream(StringsManager.bookClub),
          builder: (context, snapshot) {
            /// loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            /// error
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            /// success
            List<Event> bookClubEvents = snapshot.data ?? [];
            if(bookClubEvents.isEmpty){
              return Center(child: Text(StringsManager.noEventsYet));
            }
            return ListView.separated(
              itemBuilder: (context, index) =>
                  EventItem(event: bookClubEvents[index]),
              itemCount: bookClubEvents.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: heightScreen * 0.02),
            );
          },
        ),
        StreamBuilder(
          stream: FirestoreManager.getFilteredEventsStream(StringsManager.exhibition),
          builder: (context, snapshot) {
            /// loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            /// error
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            /// success
            List<Event> exhibitionEvents = snapshot.data ?? [];
            if(exhibitionEvents.isEmpty){
              return Center(child: Text(StringsManager.noEventsYet));
            }
            return ListView.separated(
              itemBuilder: (context, index) =>
                  EventItem(event: exhibitionEvents[index]),
              itemCount: exhibitionEvents.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: heightScreen * 0.02),
            );
          },
        ),
      ],
    );
  }
}
