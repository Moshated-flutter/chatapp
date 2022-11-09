import 'package:flutter/material.dart';

Widget bottombackgroun(double screenwidth) {
  return Container(
    width: 1.5 * screenwidth,
    height: 1.5 * screenwidth,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment(0.6, -1.1),
        end: Alignment(0.7, 0.8),
        colors: [
          Color(0xDB4BE8CC),
          Color(0x005CBdCF),
        ],
      ),
    ),
  );
}
