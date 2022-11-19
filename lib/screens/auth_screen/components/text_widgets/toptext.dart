import 'package:chatapp/screens/auth_screen/animations/change_screen_animation.dart';
import 'package:chatapp/screens/auth_screen/components/login_content.dart';
import 'package:chatapp/utils/helper_funtions.dart';
import 'package:flutter/material.dart';

class TopText extends StatefulWidget {
  TopText({super.key});

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  void initState() {
    ChangeScreenAnimations.toptextanimations!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HellperFunctions.wrapwithAnimationBuilder(
      animation: ChangeScreenAnimations.toptextanimations!,
      child: Text(
        ChangeScreenAnimations.currentScreen == Screens.createAccount
            ? 'Create\nAccount'
            : 'Wellcome\nBack',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
