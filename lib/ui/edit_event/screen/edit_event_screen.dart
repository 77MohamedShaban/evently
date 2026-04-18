import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/remote/network/firestore_manager.dart';
import '../../../core/resources/AppConstance.dart';
import '../../../core/resources/AppValidator.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/ColorsManager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/resources/UiUtils.dart';
import '../../../core/reusable_component/bottom_row.dart';
import '../../../core/reusable_component/btn_appbar.dart';
import '../../../core/reusable_component/btn_main.dart';
import '../../../core/reusable_component/custom_field.dart';
import '../../../core/reusable_component/tab_item.dart';
import '../../../core/reusable_component/tab_view.dart';
import '../../../model/event.dart';
import '../../../model/tab_model.dart';
import '../../../providers/user_provider.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = "/editEvent";

  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen>
    with SingleTickerProviderStateMixin {
  final List<TabModel> tabAddList = AppConstance.tabAddList;
  int selectedTab = 0;
  late TabController _tabController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Event event;
  late bool isInitialized;

  @override
  void initState() {
    super.initState();
    isInitialized = false;
    event = Event();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _tabController = TabController(length: tabAddList.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTab = _tabController.index;
      });
    });
  }

  @override
  void didChangeDependencies() {
    event = ModalRoute.of(context)!.settings.arguments as Event;
    if (!isInitialized) {
      titleController.text = event.title ?? "";
      descriptionController.text = event.desc ?? "";

      int eventIndex = tabAddList.indexWhere(
        (tab) => tab.text == event.category,
      );
      if (eventIndex != -1) {
        _tabController.index = eventIndex;
        selectedTab = eventIndex;
      }
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final local = context.locale.toString();

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
                  StringsManager.eventEdite,
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
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                SizedBox(
                  height: heightScreen * 0.25,
                  child: TabView(tabController: _tabController),
                ),
                TabBar(
                  controller: _tabController,
                  onTap: (value) {
                    setState(() {
                      selectedTab = value;
                    });
                  },
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  dividerHeight: 0,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: widthScreen * 0.02,
                  ),
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.transparent,
                  tabs: List.generate(tabAddList.length, (index) {
                    final eventData = tabAddList[index];
                    return TabItem(
                      selectedColor: Theme.of(context).colorScheme.primary,
                      unSelectedColor: Theme.of(context).colorScheme.onPrimary,
                      selectedBorderColor: Colors.transparent,
                      unSelectedBorderColor: Theme.of(
                        context,
                      ).colorScheme.outline,
                      isSelected: selectedTab == index,
                      eventName: eventData.text,
                      selectedTextStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.onPrimaryColor,
                      ),
                      unSelectedTextStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ) ??
                          const TextStyle(),
                      iconPath: eventData.iconPath,
                    );
                  }).toList(),
                ),
                Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringsManager.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      hintText: event.title ?? "",
                      validator: AppValidator.eventTitleValidator,
                    ),
                  ],
                ),
                Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringsManager.desc,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      hintText: event.desc ?? "",
                      maxLines: 5,
                      validator: AppValidator.eventDescriptionValidator,
                    ),
                  ],
                ),
                BottomRow(
                  iconPath: AssetsManager.date,
                  titleText: StringsManager.eventDate,
                  chooseText: selectedDate != null
                      ? DateFormat.yMMMd(local).format(selectedDate!)
                      : DateFormat.yMMMd(
                          local,
                        ).format(event.dateAndTime!.toDate()),
                  onPress: () async {
                    await chooseEventDate();
                  },
                ),
                BottomRow(
                  iconPath: AssetsManager.time,
                  titleText: StringsManager.eventTime,
                  chooseText: selectedTime != null
                      ? selectedTime!.format(context)
                      : DateFormat.jm(
                          local,
                        ).format(event.dateAndTime!.toDate()).toUpperCase(),
                  onPress: () async {
                    await chooseEventTime();
                  },
                ),
                AnimatedBuilder(
                  animation: Listenable.merge([
                    titleController,
                    descriptionController,
                  ]),
                  builder: (context, _) {
                    return BtnMain(
                      text: StringsManager.eventUpdate,
                      onClick: hasChanges()
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  UIUtils.showLoading(context);
                                  await FirestoreManager.updateEvent(
                                    Event(
                                      id: event.id,
                                      title: titleController.text,
                                      desc: descriptionController.text,
                                      category: AppConstance
                                          .categories[_tabController.index],
                                      userId: FirebaseAuth
                                          .instance
                                          .currentUser!
                                          .uid,
                                      dateAndTime: Timestamp.fromDate(
                                        DateTime(
                                          (selectedDate ??
                                                  event.dateAndTime!.toDate())
                                              .year,
                                          (selectedDate ??
                                                  event.dateAndTime!.toDate())
                                              .month,
                                          (selectedDate ??
                                                  event.dateAndTime!.toDate())
                                              .day,
                                          (selectedTime ??
                                                  TimeOfDay.fromDateTime(
                                                    event.dateAndTime!.toDate(),
                                                  ))
                                              .hour,
                                          (selectedTime ??
                                                  TimeOfDay.fromDateTime(
                                                    event.dateAndTime!.toDate(),
                                                  ))
                                              .minute,
                                        ),
                                      ),
                                    ),
                                  );
                                  await FirestoreManager.updateEventINMyEventsCollection(
                                    Event(
                                      id: event.id,
                                      title: titleController.text,
                                      desc: descriptionController.text,
                                      category: AppConstance
                                          .categories[_tabController.index],
                                      userId: FirebaseAuth
                                          .instance
                                          .currentUser!
                                          .uid,
                                      dateAndTime: Timestamp.fromDate(
                                        DateTime(
                                          (selectedDate ??
                                                  event.dateAndTime!.toDate())
                                              .year,
                                          (selectedDate ??
                                                  event.dateAndTime!.toDate())
                                              .month,
                                          (selectedDate ??
                                                  event.dateAndTime!.toDate())
                                              .day,
                                          (selectedTime ??
                                                  TimeOfDay.fromDateTime(
                                                    event.dateAndTime!.toDate(),
                                                  ))
                                              .hour,
                                          (selectedTime ??
                                                  TimeOfDay.fromDateTime(
                                                    event.dateAndTime!.toDate(),
                                                  ))
                                              .minute,
                                        ),
                                      ),
                                    ),
                                  );
                                  if (userProvider.currentUser?.favoriteEvents
                                          ?.contains(event.id) ??
                                      false) {
                                    await FirestoreManager.updateEventINFavoriteCollection(
                                      Event(
                                        id: event.id,
                                        title: titleController.text,
                                        desc: descriptionController.text,
                                        category: AppConstance
                                            .categories[_tabController.index],
                                        userId: FirebaseAuth
                                            .instance
                                            .currentUser!
                                            .uid,
                                        dateAndTime: Timestamp.fromDate(
                                          DateTime(
                                            (selectedDate ??
                                                    event.dateAndTime!.toDate())
                                                .year,
                                            (selectedDate ??
                                                    event.dateAndTime!.toDate())
                                                .month,
                                            (selectedDate ??
                                                    event.dateAndTime!.toDate())
                                                .day,
                                            (selectedTime ??
                                                    TimeOfDay.fromDateTime(
                                                      event.dateAndTime!
                                                          .toDate(),
                                                    ))
                                                .hour,
                                            (selectedTime ??
                                                    TimeOfDay.fromDateTime(
                                                      event.dateAndTime!
                                                          .toDate(),
                                                    ))
                                                .minute,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  UIUtils.hideLoading(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  UIUtils.showToastMessage(
                                    context,
                                    StringsManager.editEventSuccessfully,
                                  );
                                } catch (e) {
                                  UIUtils.hideLoading(context);
                                  print("Error : ${e.toString()}");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        StringsManager.somethingWentWrong,
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  Future<void> chooseEventDate() async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: selectedDate ?? DateTime.now(),
    );
    if (dateTime != null) {
      setState(() {
        selectedDate = dateTime;
      });
    }
  }

  TimeOfDay? selectedTime;

  Future<void> chooseEventTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  bool hasChanges() {
    bool isTitleChanged = titleController.text != (event.title ?? "");
    bool isDescChanged = descriptionController.text != (event.desc ?? "");
    bool isCategoryChanged =
        selectedTab !=
        tabAddList.indexWhere((tab) => tab.text == event.category);
    bool isDateChanged =
        selectedDate != null && selectedDate != event.dateAndTime!.toDate();
    bool isTimeChanged =
        selectedTime != null &&
        selectedTime != TimeOfDay.fromDateTime(event.dateAndTime!.toDate());

    return isTitleChanged ||
        isDescChanged ||
        isCategoryChanged ||
        isDateChanged ||
        isTimeChanged;
  }
}
