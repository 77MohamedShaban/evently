import 'package:evently/core/remote/network/fire_auth_manager.dart';
import 'package:evently/core/resources/StringsManager.dart';
import 'package:evently/core/reusable_component/btn_google.dart';
import 'package:evently/core/reusable_component/btn_main.dart';
import 'package:evently/core/reusable_component/custom_field.dart';
import 'package:evently/core/reusable_component/or_divider.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/login/widgets/go_to_signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/AppValidator.dart';
import '../../../core/resources/UiUtils.dart';
import '../../forget_password/screen/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> startEmailVerificationCheck() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
       // email Verified
        await UIUtils.showToastMessage(context, StringsManager.loggedInSuccessfully);
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      } else {
        // email not Verified
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(StringsManager.verifyEmailFirst,style: TextStyle(color: Colors.white),), duration: Duration(seconds: 5),backgroundColor: Colors.black,));
        user.sendEmailVerification();
      }
    }else{
      await UIUtils.showToastMessage(context, StringsManager.loggedInSuccessfully);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          AssetsManager.logo,
          width: widthScreen * 0.4,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              StringsManager.loginToYourAcc,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 24,
                fontWeight: .w600,
              ),
            ),
            SizedBox(height: 24),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    hintText: StringsManager.enterYourEmail,
                    prefixPath: AssetsManager.email,
                    validator: AppValidator.emailValidator,
                  ),
                  SizedBox(height: 16),
                  CustomField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hintText: StringsManager.enterYourPassword,
                    prefixPath: AssetsManager.lock,
                    isPassword: true,
                    validator: AppValidator.passwordValidator,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                },
                child: Text(
                  StringsManager.forgetPassAsk,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
            SizedBox(height: heightScreen*0.08),
            BtnMain(
              text: StringsManager.login,
              onClick: () async {
                if (formKey.currentState!.validate()) {
                  // authenticate
                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    UIUtils.showLoading(context);
                    final credential = await auth.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    if (mounted) UIUtils.hideLoading(context);
                    await startEmailVerificationCheck();
                  } on FirebaseAuthException catch (e) {
                    if (mounted) UIUtils.hideLoading(context);

                    String message = StringsManager.somethingWentWrong;
                    if (e.code == 'user-not-found') {
                      message = StringsManager.noAccountFound;
                    } else if (e.code == 'wrong-password') {
                      message = StringsManager.invalidEmailOrPassword;
                    } else if (e.code == 'network-request-failed') {
                      message = StringsManager.networkRequestFailed;
                    }
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message,style: TextStyle(color: Colors.white),), duration: Duration(seconds: 5),backgroundColor: Colors.black,));
                  } catch (e) {
                    if (mounted) UIUtils.hideLoading(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(StringsManager.somethingWentWrong,style: TextStyle(color: Colors.white,backgroundColor: Colors.black),)),
                    );
                  }
                }
              },
            ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(
              duration: 1200.ms,
              color: Colors.white.withAlpha(150),
              angle: 45,
              stops: [0.4, 0.5, 0.6],
            ),
            SizedBox(height: heightScreen*0.06),
            GoToSignup(),
            SizedBox(height: heightScreen*0.06),

            OrDivider(),
            SizedBox(height: heightScreen*0.04),
            BtnGoogle(text: StringsManager.logInWithGoogle, onClick: () async {
             await FireAuthManager.signInWithGoogle(context);
            })
          ],
        ),
      ),
    );
  }
}
