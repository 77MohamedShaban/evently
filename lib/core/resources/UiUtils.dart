import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/reusable_component/btn_main.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../model/event.dart';
import '../../providers/user_provider.dart';
import '../../ui/full_image/screen/full_image_screen.dart';
import '../../ui/start/widgets/settings_btn.dart';
import '../remote/network/fire_auth_manager.dart';
import '../remote/network/firestore_manager.dart';
import 'StringsManager.dart';

abstract final class UIUtils {
  static void openLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SettingsBtn(
                  text: StringsManager.english,
                  isSelected: context.locale.languageCode == "en",
                  onTap: () {
                    context.setLocale(const Locale("en"));
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                SettingsBtn(
                  text: StringsManager.arabic,
                  isSelected: context.locale.languageCode == "ar",
                  onTap: () {
                    context.setLocale(const Locale("ar"));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void openLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringsManager.logout,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                StringsManager.logoutMessage,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        StringsManager.cancel,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BtnMain(
                      text: StringsManager.logout,
                      onClick: () async {
                        try {
                          showLoading(context);
                          await FireAuthManager.signOut();
                          hideLoading(context);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.routeName,
                            (route) => false,
                          );
                          showToastMessage(
                            context,
                            StringsManager.loggedOutSuccessfully,
                          );
                        } catch (e) {
                          hideLoading(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                StringsManager.somethingWentWrong,
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                            ),
                          );
                        }
                      },
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: LoadingAnimationWidget.beat(
            color: Theme.of(context).colorScheme.primary,
            size: 120,
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showVerifyDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null && user.emailVerified) return;
              try {
                await user?.delete();
              } catch (e) {
                print("Error deleting user: $e");
              }
            }
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.email_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  StringsManager.verifyYourEmail,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(StringsManager.contentVerifyYourEmail),
                const SizedBox(height: 16),
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.currentUser?.delete();
                  } catch (e) {
                    print("Error deleting user: $e");
                  }
                  Navigator.pop(context);
                },
                child: Text(StringsManager.goBack),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await user.sendEmailVerification();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(StringsManager.verificationEmailResent),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(StringsManager.requestNewEmail)),
                    );
                  }
                },
                child: Text(StringsManager.resend),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showToastMessage(
    BuildContext context,
    String message,
  ) async {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 4,
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static Future<void> deleteEvent(BuildContext context, Event event) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.delete, color: Colors.red, size: 30),
              const SizedBox(width: 8),
              Text(
                StringsManager.deleteEvent,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(StringsManager.deleteEventWarning)],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text(StringsManager.goBack),
            ),
            TextButton(
              onPressed: () async {
                showLoading(context);
                await FirestoreManager.deleteEvent(event.id!);
                await FirestoreManager.deleteEventFromFavorite(event.id!);
                await FirestoreManager.deleteEventFromMyEvents(event.id!);
                var userProvider = Provider.of<UserProvider>(
                  context,
                  listen: false,
                );
                List<String> favoriteEvents =
                    userProvider.currentUser?.favoriteEvents ?? [];
                favoriteEvents.remove(event.id);
                await FirestoreManager.updateFavoritesListToUser(favoriteEvents);
                hideLoading(context);
                Navigator.pop(context);
                Navigator.pop(context);
                UIUtils.showToastMessage(context, StringsManager.eventDeleted);
              },
              child: Text(StringsManager.confirm),
            ),
          ],
        );
      },
    );
  }
}
