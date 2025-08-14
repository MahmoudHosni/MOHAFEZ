import 'package:flutter/material.dart';
import '../../../../core/theme/color_manager.dart';

BoxDecoration buildAyaNumUnSelected() {
  return BoxDecoration(
    shape: BoxShape.circle,
    color: ColorManager.white,
    border: Border.all(
      width: 1,
      color: ColorManager.lightGrey,
      style: BorderStyle.solid,
    ),
  );
}
