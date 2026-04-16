import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/remote/network/firestore_manager.dart';
import 'package:evently/core/resources/AssetsManager.dart';
import 'package:evently/core/resources/UiUtils.dart';
import 'package:evently/core/reusable_component/btn_main.dart';
import 'package:evently/core/reusable_component/custom_field.dart';
import 'package:evently/core/reusable_component/tab_view.dart';
import 'package:evently/model/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/resources/AppConstance.dart';
import '../../../core/resources/AppValidator.dart';
import '../../../core/resources/ColorsManager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/reusable_component/btn_appbar.dart';
import '../../../core/reusable_component/tab_item.dart';
import '../../../model/tab_model.dart';
import '../../../core/reusable_component/bottom_row.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "/addEvent";

  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen>
    with SingleTickerProviderStateMixin {
  final List<TabModel> tabAddList = AppConstance.tabAddList;
  int selectedTab = 0;
  late TabController _tabController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
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
                  StringsManager.addEvent,
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
                  height: heightScreen * 0.26,
                  child: TabView(tabController: _tabController),
                ),
                TabBar(
                  controller: _tabController,
                  onTap: (value) {
                    setState(() {
                      selectedTab = value;
                      print(selectedTab);
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
                      hintText: StringsManager.eventTitle,
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
                      hintText: StringsManager.eventDesc,
                      maxLines: 5,
                      validator: AppValidator.eventDescriptionValidator,
                    ),
                  ],
                ),
                BottomRow(
                  iconPath: AssetsManager.date,
                  titleText: StringsManager.eventDate,
                  chooseText: selectedDate != null
                      ? DateFormat.yMMMd().format(selectedDate!)
                      : StringsManager.chooseDate,
                  onPress: () async {
                    await chooseEventDate();
                  },
                ),
                BottomRow(
                  iconPath: AssetsManager.time,
                  titleText: StringsManager.eventTime,
                  chooseText: selectedTime != null
                      ? selectedTime!.format(context)
                      : StringsManager.chooseTime,
                  onPress: () async {
                    await chooseEventTime();
                  },
                ),
                BtnMain(
                  text: StringsManager.addEvent,
                  onClick: () async {
                    if (_formKey.currentState!.validate()) {
                      if (selectedDate == null || selectedTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(StringsManager.chooseDateAndTime),
                          ),
                        );
                      } else {
                        try {
                          UIUtils.showLoading(context);
                          String eventId = await FirestoreManager.saveEvent(
                            Event(
                              title: titleController.text,
                              desc: descriptionController.text,
                              category: tabAddList[_tabController.index].text,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              dateAndTime: Timestamp.fromDate(
                                DateTime(
                                  selectedDate!.year,
                                  selectedDate!.month,
                                  selectedDate!.day,
                                  selectedTime!.hour,
                                  selectedTime!.minute,
                                ),
                              ),
                            ),
                          );
                          await FirestoreManager.addEventToMyEvent(
                            Event(
                              id: eventId,
                              title: titleController.text,
                              desc: descriptionController.text,
                              category: tabAddList[_tabController.index].text,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              dateAndTime: Timestamp.fromDate(
                                DateTime(
                                  selectedDate!.year,
                                  selectedDate!.month,
                                  selectedDate!.day,
                                  selectedTime!.hour,
                                  selectedTime!.minute,
                                ),
                              ),
                            ),
                          );
                          UIUtils.hideLoading(context);
                          Navigator.pop(context);
                          UIUtils.showToastMessage(
                            context,
                            StringsManager.addEventSuccessfully,
                          );
                        } catch (e) {
                          UIUtils.hideLoading(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(StringsManager.somethingWentWrong),
                            ),
                          );
                        }
                      }
                    }
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
}
