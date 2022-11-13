import 'package:chatapp/screens/auth_screen/animations/change_screen_animation.dart';
import 'package:chatapp/screens/auth_screen/components/login_content.dart';
import 'package:chatapp/utils/constrans.dart';
import 'package:chatapp/utils/helper_funtions.dart';
import 'package:flutter/material.dart';

class BottomText extends StatefulWidget {
  const BottomText({super.key});

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  void initState() {
    ChangeScreenAnimations.bottomtextanimations.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HellperFunctions.wrapwithAnimationBuilder(
      animation: ChangeScreenAnimations.bottomtextanimations,
      child: Container(
        child: GestureDetector(
          onTap: () {
            if (!ChangeScreenAnimations.isplaying) {
              ChangeScreenAnimations.currentScreen == Screens.createAccount
                  ? ChangeScreenAnimations.forward()
                  : ChangeScreenAnimations.reverse();
              ChangeScreenAnimations.currentScreen = Screens
                  .values[1 - ChangeScreenAnimations.currentScreen.index];
            }
          },
          behavior: HitTestBehavior.opaque,
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
              children: [
                TextSpan(
                  text: ChangeScreenAnimations.currentScreen ==
                          Screens.createAccount
                      ? 'Already have an account?  '
                      : 'Do\'t have an account?',
                  style: TextStyle(
                    color: kprimarcolors,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                    text: ChangeScreenAnimations.currentScreen ==
                            Screens.createAccount
                        ? 'Log in'
                        : 'Sign in',
                    style: TextStyle(
                      color: ksecondacycolor,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
