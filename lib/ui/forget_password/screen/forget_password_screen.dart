import 'package:evently/core/resources/AssetsManager.dart';
import 'package:evently/core/resources/StringsManager.dart';
import 'package:evently/core/reusable_component/btn_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/resources/AppValidator.dart';
import '../../../core/reusable_component/btn_appbar.dart';
import '../../../core/reusable_component/custom_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "/forgetPassword";

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController emailController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;
    String message = StringsManager.somethingWentWrong;

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(StringsManager.checkYourEmail),
        ),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = StringsManager.ifThisEmailExists;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(color: Colors.white),),duration: Duration(seconds: 8),backgroundColor: Colors.black,),
      );
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          StringsManager.forgetPass,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
        
                  /// Image
                  Image.asset(
                    AssetsManager.forgetPass,
                    height: heightScreen*0.3,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer,
                  ),
        
                  const SizedBox(height: 30),

                  /// Description
                  Text(
                    StringsManager.enterYourEmailAndWellSend,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
        
                  const SizedBox(height: 30),
        
                  /// Email Field
                  CustomField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    hintText: StringsManager.enterYourEmail,
                    prefixPath: AssetsManager.email,
                    validator: AppValidator.emailValidator,
                  ),
                      /// EmailField
                   SizedBox(height: heightScreen*0.18),
        
                  /// Button / Loading
                  isLoading
                      ? const CircularProgressIndicator()
                      : BtnMain(
                    text: StringsManager.resetPass,
                    onClick: resetPassword,
                  ),
        
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}