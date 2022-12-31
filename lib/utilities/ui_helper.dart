import 'package:flutter/material.dart';

// レスポンシブデザイン用
double wp(BoxConstraints constraints, double ratio) {
  return constraints.maxWidth * ratio / 100;
}

double hp(BoxConstraints constraints, double ratio) {
  return constraints.maxWidth * ratio / 100;
}
