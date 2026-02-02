import 'package:flutter/material.dart';

double fontSize(BuildContext context, double fSize) {
  double screenHeight = MediaQuery.sizeOf(context).height;
  double screenWidth = MediaQuery.sizeOf(context).width;
  return (screenHeight + screenWidth) * fSize;
}
