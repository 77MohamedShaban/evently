import 'package:evently/core/reusable_component/custom_field.dart';
import 'package:flutter/material.dart';
import '../../../../core/remote/network/firestore_manager.dart';
import '../../../../core/resources/StringsManager.dart';
import '../../../../model/event.dart';
import '../../widgets/event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: heightScreen * 0.02,
          left: heightScreen * 0.02,
          right: heightScreen * 0.02,
        ),
        child: Column(
          children: [
            CustomField(
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              hintText: StringsManager.searchHint,
              isSearch: true,
              prefixPath: '',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: FirestoreManager.getFavoriteEventsStream(),
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
                  List<Event> favoriteEvents = snapshot.data ?? [];
                  return ListView.separated(
                    itemBuilder: (context, index) =>
                        EventItem(event: favoriteEvents[index]),
                    itemCount: favoriteEvents.length,
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
