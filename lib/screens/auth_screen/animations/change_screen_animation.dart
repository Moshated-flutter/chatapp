import 'package:chatapp/screens/auth_screen/components/login_content.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class ChangeScreenAnimations {
  static var isplaying = false;
  static var currentScreen = Screens.createAccount;
  static late final AnimationController toptextconroller;
  static late final Animation<Offset> toptextanimations;
  static late final AnimationController bottomtextconroller;
  static late final Animation<Offset> bottomtextanimations;

  static final List<AnimationController> createaccountController = [];
  static final List<Animation<Offset>> createAccountAnimation = [];
  static final List<AnimationController> loginController = [];
  static final List<Animation<Offset>> loginAnimation = [];

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
      duration: Duration(milliseconds: 200),
    );
    toptextanimations = _createanimation(
      begin: Offset.zero,
      end: Offset(-1.8, 0),
      parent: toptextconroller,
    );
    bottomtextconroller = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: 200),
    );
    bottomtextanimations = _createanimation(
      begin: Offset.zero,
      end: Offset(0, 1.7),
      parent: bottomtextconroller,
    );
    for (var i = 0; i < createaccontItems; i++) {
      createaccountController.add(AnimationController(
        vsync: vsync,
        duration: Duration(milliseconds: 200),
      ));
      createAccountAnimation.add(
        _createanimation(
          begin: Offset.zero,
          end: Offset(-1, 0),
          parent: createaccountController[i],
        ),
      );
    }
    for (var i = 0; i < loginitem; i++) {
      loginController.add(AnimationController(
        vsync: vsync,
        duration: Duration(milliseconds: 200),
      ));
      loginAnimation.add(
        _createanimation(
          begin: Offset(1, 0),
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
      controller.dispose();
    }
  }

  static Future<void> forward() async {
    isplaying = true;
    toptextconroller.forward();
    await bottomtextconroller.forward();
    for (final controller in [...createaccountController, ...loginController]) {
      controller.forward();
      await Future.delayed(Duration(milliseconds: 50));
    }

    bottomtextconroller.reverse();
    await toptextconroller.reverse();

    isplaying = false;
  }

  static Future<void> reverse() async {
    isplaying = true;
    toptextconroller.forward();
    await bottomtextconroller.forward();
    for (final controller in [
      ...loginController.reversed,
      ...createaccountController.reversed,
    ]) {
      controller.reverse();
      await Future.delayed(Duration(milliseconds: 50));
    }

    bottomtextconroller.reverse();
    await toptextconroller.reverse();

    isplaying = false;
  }
}
