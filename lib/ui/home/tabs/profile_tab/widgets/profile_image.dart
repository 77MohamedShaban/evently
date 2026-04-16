import 'dart:io';

import 'package:evently/core/resources/UiUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/resources/AssetsManager.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (selectedImage != null) {
      imageWidget = Image.file(selectedImage!, fit: BoxFit.cover);
    } else if (FirebaseAuth.instance.currentUser?.photoURL != null) {
      imageWidget = Image.network(
        FirebaseAuth.instance.currentUser!.photoURL!,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = SvgPicture.asset(AssetsManager.profile_selected, fit: BoxFit.cover);
    }

    return GestureDetector(
      onTap: () async {
        // final  image = await UIUtils.chooseImageProfileBottomSheet(context
        //   ,AssetsManager.profile);

        // if (image != null) {
        //   setState(() {
        //     selectedImage = image;
        //   });
        // }
      },
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: SizedBox(width: 110, height: 110, child: imageWidget),
        ),
      ),
    );
  }
}
