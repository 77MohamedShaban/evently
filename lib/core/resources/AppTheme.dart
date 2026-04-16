import 'package:flutter/material.dart';
import 'ColorsManager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.backgroundColor,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: ColorsManager.onPrimaryColor,
      hourMinuteTextColor: ColorsManager.primaryColor,
      dialHandColor: ColorsManager.darkPrimaryColor,
      dialBackgroundColor: ColorsManager.backgroundColor,
      entryModeIconColor: ColorsManager.primaryColor,
      dayPeriodTextColor: ColorsManager.primaryColor,
      dayPeriodColor: ColorsManager.backgroundColor,
      helpTextStyle: TextStyle(
        color: ColorsManager.secondaryColor,
        fontSize: 16,
      ),
      dialTextColor: ColorsManager.secondaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: ColorsManager.primaryColor,
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 65,
      indicatorColor: Colors.transparent,
      backgroundColor: ColorsManager.onPrimaryColor,
      labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorsManager.primaryColor,
          );
        }
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorsManager.unselectedTab,
        );
      }),
    ),
    colorScheme: ColorScheme.light(
      primary: ColorsManager.primaryColor,
      onPrimaryContainer: ColorsManager.primaryColor,
      onPrimary: ColorsManager.onPrimaryColor,
      secondary: ColorsManager.primaryColor,
      onTertiary: ColorsManager.darkBackgroundColor,
      outline: ColorsManager.fieldBorder,
      error: Colors.red,
      secondaryContainer: ColorsManager.backgroundColor,
      onSecondary: ColorsManager.unselectedTab,
      primaryContainer: ColorsManager.backgroundColor,

    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: .w600,
        color: ColorsManager.secondaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: .w400,
        color: ColorsManager.teritaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: .w500,
        color: ColorsManager.primaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: .w600,
        color: ColorsManager.primaryColor,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.primaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: .w600,
        color: ColorsManager.primaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: .w400,
        color: ColorsManager.teritaryColor,
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        fontWeight: .w500,
        color: ColorsManager.secondaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: ColorsManager.secondaryColor,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: .w500,
        color: ColorsManager.unselectedTab,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.darkBackgroundColor,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: ColorsManager.darkBackgroundColor,
      hourMinuteTextColor: ColorsManager.darkPrimaryColor,
      dialBackgroundColor: ColorsManager.darkUnselected,
      entryModeIconColor: ColorsManager.darkPrimaryColor,
      helpTextStyle: TextStyle(
        color: ColorsManager.darkSecondaryColor,
        fontSize: 16,
      ),
      dialTextColor: ColorsManager.darkSecondaryColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: ColorsManager.darkPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      scrolledUnderElevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 65,
      indicatorColor: Colors.transparent,
      backgroundColor: ColorsManager.darkUnselected,
      labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorsManager.darkPrimaryColor,
          );
        }
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorsManager.unselectedTab,
        );
      }),
    ),
    colorScheme: ColorScheme.dark(
      primary: ColorsManager.darkPrimaryColor,
      onPrimaryContainer: ColorsManager.darkOnPrimaryContainerColor,
      onPrimary: ColorsManager.darkUnselected,
      secondary: ColorsManager.onPrimaryColor,
      onTertiary: ColorsManager.primaryColor,
      outline: ColorsManager.fieldBorderDark,
      secondaryContainer: ColorsManager.darkBackgroundColor,
      error: Colors.red,
      onSecondary: ColorsManager.backgroundColor,
      primaryContainer: ColorsManager.darkBackgroundColor,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: .w600,
        color: ColorsManager.darkSecondaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: .w400,
        color: ColorsManager.darkTeritaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: .w500,
        color: ColorsManager.darkSecondaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: .w600,
        color: ColorsManager.darkPrimaryColor,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.darkPrimaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: .w600,
        color: ColorsManager.darkPrimaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: .w400,
        color: ColorsManager.hintTextColor,
      ),
      displayMedium: TextStyle(
        fontSize: 16,
        fontWeight: .w500,
        color: ColorsManager.darkPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: .w400,
        color: ColorsManager.darkTeritaryColor,
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: .w500,
        color: ColorsManager.darkTeritaryColor,
      ),
    ),
  );
}
