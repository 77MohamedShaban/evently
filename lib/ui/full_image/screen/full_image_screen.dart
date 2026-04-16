import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  static const String routeName = "/full_image_screen";
  final String? imageUrl;
  final String? imageGoogle;


  const FullImageScreen({super.key, required this.imageUrl, required this.imageGoogle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: InteractiveViewer(
          child:
              Image.asset(imageUrl!)
              ,
        ),
      ),
    );
  }
}
