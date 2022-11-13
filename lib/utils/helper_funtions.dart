import 'package:flutter/material.dart';

class HellperFunctions {
  static Widget wrapwithAnimationBuilder(
      {required Animation<Offset> animation, required Widget child}) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
          translation: animation.value,
          child: child,
        );
      },
    );
  }
}
