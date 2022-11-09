import 'dart:math' as math;
import 'package:flutter/material.dart';

Widget topbackgroundwidget(double screenwidth) {
  return Transform.rotate(
    angle: -35 * math.pi / 180,
    child: Container(
      width: 1.2 * screenwidth,
      height: 1.2 * screenwidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        gradient: LinearGradient(
          begin: Alignment(-0.2, -0.8),
          end: Alignment.bottomCenter,
          colors: [
            Color(0x007CBFCF),
            Color(0xB316BFC4),
          ],
        ),
      ),
    ),
  );
}
