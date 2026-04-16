import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/remote/network/firestore_manager.dart';
import 'package:evently/core/resources/AppConstance.dart';
import 'package:evently/core/resources/AssetsManager.dart';
import 'package:evently/model/user.dart';
import 'package:evently/ui/details/widgets/action_btn.dart';
import 'package:evently/ui/details/widgets/show_date.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/resources/UiUtils.dart';
import '../../../core/reusable_component/btn_appbar.dart';
import '../../../model/event.dart';
import '../../../providers/theme_provider.dart';
import '../../edit_event/screen/edit_event_screen.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = "/details";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Event event;
  User? author;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    event = ModalRoute.of(context)!.settings.arguments as Event;
    if (!isLoaded) {
      loadAuthor();
      isLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final local = context.locale.toString();

    return Scaffold(
      appBar: AppBar(
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
                  StringsManager.eventDetails,
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
        actions: [
          if (auth.FirebaseAuth.instance.currentUser!.uid == event.userId) ...[
            ActionBtn(
              iconPath: AssetsManager.edit,
              iconColor: Theme.of(context).colorScheme.primary,
              onClick: () {
                Navigator.pushNamed(
                  context,
                  EditEventScreen.routeName,
                  arguments: event,
                );
              },
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 16, start: 8),
              child: ActionBtn(
                iconPath: AssetsManager.trash,
                iconColor: Colors.red,
                onClick: () async {
                  await UIUtils.deleteEvent(context, event);
                },
              ),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Row(
                children: [
                  Text(
                    StringsManager.createdBy.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),Icon(Icons.account_box_rounded , size: 20,
                    color: Theme.of(context).colorScheme.primary,),
                  author == null
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(start: 40),
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          ),
                        )
                      : Text(
                          author!.name!,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ).animate().shimmer(
                          delay: 800.ms,
                          duration: 1500.ms,
                          color: Theme.of(context).colorScheme.primaryContainer,
                          stops: [0.0, 0.2, 0.4],
                        ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppConstance.getEventImage(
                    event.category!,
                    themeProvider.mode == ThemeMode.dark,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                event.title ?? "",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              ShowDate(
                date: DateFormat.yMMMd(local).format(event.dateAndTime!.toDate()),
                time: DateFormat.jm(local)
                    .format(event.dateAndTime!.toDate())
                    .toUpperCase(),
              ),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringsManager.desc,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        event.desc ?? "",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadAuthor() async {
    try {
      author = await FirestoreManager.getSpecificUser(event.userId!);
      setState(() {});
    } on auth.FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(StringsManager.somethingWentWrong)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(StringsManager.somethingWentWrong)),
      );
    }
  }
}
