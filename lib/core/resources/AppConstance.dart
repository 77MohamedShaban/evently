import 'package:evently/providers/theme_provider.dart';

import '../../model/tab_model.dart';
import 'AssetsManager.dart';
import 'StringsManager.dart';

abstract final class AppConstance {
  static const List<String> categories = [
    "Sport",
    "Birthday",
    "Meeting",
    "Book Club",
    "Exhibition",
  ];

  static List<TabModel> get tabHomeList => [
    TabModel(iconPath: AssetsManager.allIcon, text: StringsManager.all),
    TabModel(iconPath: AssetsManager.sportIcon, text: StringsManager.sport),
    TabModel(
      iconPath: AssetsManager.birthdayIcon,
      text: StringsManager.birthday,
    ),
    TabModel(iconPath: AssetsManager.meetingIcon, text: StringsManager.meeting),
    TabModel(iconPath: AssetsManager.bookIcon, text: StringsManager.bookClub),
    TabModel(
      iconPath: AssetsManager.exhibitionIcon,
      text: StringsManager.exhibition,
    ),
  ];

  static List<TabModel> get tabAddList => [
    TabModel(iconPath: AssetsManager.sportIcon, text: StringsManager.sport),
    TabModel(
      iconPath: AssetsManager.birthdayIcon,
      text: StringsManager.birthday,
    ),
    TabModel(iconPath: AssetsManager.meetingIcon, text: StringsManager.meeting),
    TabModel(iconPath: AssetsManager.bookIcon, text: StringsManager.bookClub),
    TabModel(
      iconPath: AssetsManager.exhibitionIcon,
      text: StringsManager.exhibition,
    ),
  ];

  static String getEventImage(String category, bool isDark) {
    switch (category) {
      case "Sport":
        return isDark ? AssetsManager.sport_dark : AssetsManager.sport_light;

      case "Birthday":
        return isDark
            ? AssetsManager.birthday_dark
            : AssetsManager.birthday_light;

      case "Book Club":
        return isDark ? AssetsManager.book_dark : AssetsManager.book_light;

      case "Exhibition":
        return isDark
            ? AssetsManager.exhibition_dark
            : AssetsManager.exhibition_light;

      case "Meeting":
        return isDark
            ? AssetsManager.meeting_dark
            : AssetsManager.meeting_light;

      default:
        return AssetsManager.sport_light;
    }
  }
}
