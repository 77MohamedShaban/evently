import 'dart:async';
import 'package:evently/core/remote/network/firestore_manager.dart';
import 'package:evently/core/resources/AssetsManager.dart';
import 'package:evently/core/resources/UiUtils.dart';
import 'package:evently/core/reusable_component/btn_main.dart';
import 'package:evently/ui/signUp/widgets/go_to_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/remote/network/fire_auth_manager.dart';
import '../../../core/resources/AppValidator.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/reusable_component/btn_google.dart';
import '../../../core/reusable_component/custom_field.dart';
import '../../../core/reusable_component/or_divider.dart';
import '../../home/screen/home_screen.dart';
import 'package:evently/model/user.dart' as userModel;

class SignupScreen extends StatefulWidget {
  static const String routeName = "/signUp";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Timer? verifyTimer;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    verifyTimer?.cancel();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void startEmailVerificationCheck() {
    verifyTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      User? user = FirebaseAuth.instance.currentUser;

      await user?.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel();

        if (mounted) {
          FirestoreManager.saveUser(
            userModel.User(
              id: user.uid,
              name: nameController.text,
              email: emailController.text,
            ),
          );

          Navigator.pop(context); // close dialog
          await UIUtils.showToastMessage(
            context,
            "Account created successfully",
          );

          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          AssetsManager.logo,
          width: widthScreen * 0.4,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringsManager.createYourAcc,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      hintText: StringsManager.enterYourName,
                      prefixPath: AssetsManager.profile,
                      validator: AppValidator.nameValidator,
                    ),
                    const SizedBox(height: 16),
                    CustomField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      hintText: StringsManager.enterYourEmail,
                      prefixPath: AssetsManager.email,
                      validator: AppValidator.emailValidator,
                    ),
                    const SizedBox(height: 16),
                    CustomField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      hintText: StringsManager.enterYourPassword,
                      prefixPath: AssetsManager.lock,
                      isPassword: true,
                      validator: AppValidator.passwordValidator,
                    ),
                    const SizedBox(height: 16),
                    CustomField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hintText: StringsManager.confirmYourPassword,
                      prefixPath: AssetsManager.lock,
                      isPassword: true,
                      validator: (value) =>
                          AppValidator.confirmPasswordValidator(
                            value,
                            passwordController.text,
                          ),
                      isConfirmPassword: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: heightScreen * 0.08),
              BtnMain(
                    text: StringsManager.signUp,
                    onClick: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          UIUtils.showLoading(context);

                          UserCredential newUser = await auth
                              .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                          await newUser.user!.sendEmailVerification();

                          if (mounted) UIUtils.hideLoading(context);
                          UIUtils.showVerifyDialog(context);

                          startEmailVerificationCheck();
                        } on FirebaseAuthException catch (e) {
                          if (mounted) UIUtils.hideLoading(context);

                          String message = StringsManager.somethingWentWrong;
                          if (e.code == 'weak-password') {
                            message = StringsManager.weakPassword;
                          } else if (e.code == 'email-already-in-use') {
                            message = StringsManager.accountAlreadyExists;
                          } else if (e.code == 'network-request-failed') {
                            message = StringsManager.networkRequestFailed;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                message,
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.black,
                            ),
                          );
                        } catch (e) {
                          if (mounted) UIUtils.hideLoading(context);

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
                      }
                    },
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: 1200.ms,
                    color: Colors.white.withAlpha(150),
                    angle: 45,
                    stops: [0.4, 0.5, 0.6],
                  ),
              SizedBox(height: heightScreen * 0.04),

              GoToLogin(),
              SizedBox(height: heightScreen * 0.02),
              OrDivider(),
              SizedBox(height: heightScreen * 0.04),
              BtnGoogle(
                text: StringsManager.signUpWithGoogle,
                onClick: () async {
                  await FireAuthManager.signInWithGoogle(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
