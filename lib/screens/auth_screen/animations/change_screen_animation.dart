import 'package:chatapp/screens/auth_screen/components/login_content.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class ChangeScreenAnimations {
  static var isplaying = false;
  static var currentScreen = Screens.createAccount;
  static AnimationController? toptextconroller;
  static Animation<Offset>? toptextanimations;
  static AnimationController? bottomtextconroller;
  static Animation<Offset>? bottomtextanimations;

  static List<AnimationController> createaccountController = [];
  static List<Animation<Offset>> createAccountAnimation = [];
  static List<AnimationController> loginController = [];
  static List<Animation<Offset>> loginAnimation = [];

  static Animation<Offset> _createanimation({
    required Offset begin,
    required Offset end,
    required AnimationController parent,
  }) {
    return Tween(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: parent,
        curve: Curves.easeIn,
      ),
    );
  }

  static void initialze({
    required TickerProvider vsync,
    required int createaccontItems,
    required int loginitem,
  }) {
    toptextconroller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );
    toptextanimations = _createanimation(
      begin: Offset.zero,
      end: const Offset(-1.8, 0),
      parent: toptextconroller!,
    );
    bottomtextconroller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );
    bottomtextanimations = _createanimation(
      begin: Offset.zero,
      end: const Offset(0, 1.7),
      parent: bottomtextconroller!,
    );
    for (var i = 0; i < createaccontItems; i++) {
      createaccountController.add(AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 200),
      ));
      createAccountAnimation.add(
        _createanimation(
          begin: Offset.zero,
          end: const Offset(-1, 0),
          parent: createaccountController[i],
        ),
      );
    }
    for (var i = 0; i < loginitem; i++) {
      loginController.add(AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 200),
      ));
      loginAnimation.add(
        _createanimation(
          begin: const Offset(1, 0),
          end: Offset.zero,
          parent: loginController[i],
        ),
      );
    }
  }

  static void dispose() {
    for (final controller in [
      toptextconroller,
      bottomtextconroller,
      ...createaccountController,
      ...loginController,
    ]) {
      controller!.dispose();
    }
  }

  static Future<void> forward() async {
    isplaying = true;
    toptextconroller!.forward();
    await bottomtextconroller!.forward();
    for (final controller in [...createaccountController, ...loginController]) {
      controller.forward();
      await Future.delayed(const Duration(milliseconds: 50));
    }

    bottomtextconroller!.reverse();
    await toptextconroller!.reverse();

    isplaying = false;
  }

  static Future<void> reverse() async {
    isplaying = true;
    toptextconroller!.forward();
    await bottomtextconroller!.forward();
    for (final controller in [
      ...loginController.reversed,
      ...createaccountController.reversed,
    ]) {
      controller.reverse();
      await Future.delayed(const Duration(milliseconds: 50));
    }

    bottomtextconroller!.reverse();
    await toptextconroller!.reverse();

    isplaying = false;
  }
}
