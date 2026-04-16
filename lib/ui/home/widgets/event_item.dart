import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/remote/network/firestore_manager.dart';
import 'package:evently/core/resources/AppConstance.dart';
import 'package:evently/core/resources/AssetsManager.dart';
import 'package:evently/core/resources/UiUtils.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../providers/theme_provider.dart';
import '../../details/screen/details_screen.dart';

class EventItem extends StatefulWidget {
  final Event event;

  const EventItem({super.key, required this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var orientation = MediaQuery.of(context).orientation;
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    bool isFav = chekEventInFavorite(userProvider);
    final local = context.locale.toString();

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: widget.event,
        );
      },
      child: Container(
        height: orientation == Orientation.landscape
            ? heightScreen * 0.5
            : heightScreen * .24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.outline,
          ),
          image: DecorationImage(
            image: AssetImage(
              AppConstance.getEventImage(
                widget.event.category!,
                themeProvider.mode == ThemeMode.dark,
              ),
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widthScreen * 0.02,
            vertical: heightScreen * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(heightScreen * 0.01),
                      child: Text(
                        DateFormat.MMMd(local).format(
                          widget.event.dateAndTime!.toDate(),
                        ),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                  if (currentUserId == widget.event.userId)
                    Icon(Icons.verified, color: Colors.pink, size: 30),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(heightScreen * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.event.title ?? "",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (isFav) {
                            userProvider.currentUser?.favoriteEvents?.remove(
                              widget.event.id!,
                            );
                            setState(() {});
                            await FirestoreManager.deleteEventFromFavorite(
                              widget.event.id!,
                            );
                            UIUtils.showToastMessage(
                              context,
                              StringsManager.removedFromFavorites,
                            );
                          } else {
                            userProvider.currentUser?.favoriteEvents?.add(
                              widget.event.id!,
                            );
                            setState(() {});
                            await FirestoreManager.addEventToFavorite(
                              widget.event,
                            );
                            UIUtils.showToastMessage(
                              context,
                              StringsManager.addedToFavorites,
                            );
                          }
                          await FirestoreManager.updateFavoritesListToUser(
                            userProvider.currentUser?.favoriteEvents ?? [],
                          );
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              ),
                          child: SvgPicture.asset(
                            isFav
                                ? AssetsManager.heart_selected
                                : AssetsManager.heart,
                            key: ValueKey(isFav),
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool chekEventInFavorite(UserProvider userProvider) {
    if (userProvider.currentUser?.favoriteEvents?.contains(widget.event.id) ??
        false) {
      return true;
    } else {
      return false;
    }
  }
}
