import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/remote/network/firestore_manager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/reusable_component/btn_appbar.dart';
import '../../../model/event.dart';
import '../../home/widgets/event_item.dart';

class MyEventsScreen extends StatelessWidget {
  static const String routeName = "/myEvents";

  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Center(
            child: BtnAppbar(
              onClick: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title:
            Text(
                  StringsManager.myEvents,
                  style: Theme.of(context).textTheme.titleMedium,
                )
                .animate()
                .fade(duration: 800.ms, curve: Curves.easeOut)
                .slideX(
                  begin: 0.2,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOutCubic,
                )
                .shimmer(
                  delay: 800.ms,
                  duration: 1500.ms,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  stops: [0.0, 0.2, 0.4],
                ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: heightScreen * 0.02,
          left: heightScreen * 0.02,
          right: heightScreen * 0.02,
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirestoreManager.getMyEventsStream(),
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
                  List<Event> myEvents = snapshot.data ?? [];
                  if(myEvents.isEmpty){
                    return Center(child: Text(StringsManager.noEventsYet));
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) =>
                        EventItem(event: myEvents[index]),
                    itemCount: myEvents.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: heightScreen * 0.02),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
