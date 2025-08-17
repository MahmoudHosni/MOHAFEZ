import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mohafez/core/theme/dark_mode/themes/custom_themedata_ext.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/Constants.dart';
import '../cache/DataPreference.dart';
import '../entity/player/Reader.dart';
import '../entity/quran/Sora.dart';
import '../theme/dark_mode/cubit/theme_cubit.dart';

extension RectExtension on Rect {
  Rect applyScale(double scale) {
    return Rect.fromLTRB(
        this.left * scale, top * scale, this.right * scale, bottom * scale);
  }

  bool isInside(int x, int y) {
    if ((x >= (this.left) &&
        x <= (this.right) &&
        y >= (this.top) &&
        y <= (this.bottom))) return true;

    return false;
  }
}

extension SP on double {
  toValue(BuildContext context) {
    if (context.getDeviceType() == DeviceType.Phone) {
      return this;
    } else {
      return this + 7;
    }
  }

  toDimansionValue(BuildContext context) {
    if (context.getDeviceType() == DeviceType.Phone) {
      return this;
    } else if(context.isAndroid && context.getDeviceType() == DeviceType.Tablet){
       return this + 18.0;
    } else if (context.isIOS && context.getDeviceType() == DeviceType.Tablet) {
      return this + 20.0;
    }
  }

  toDimansionValueLandscape(BuildContext context) {
    if (context.getDeviceType() == DeviceType.Phone) {
      return this;
    } else if(context.isAndroid && context.getDeviceType() == DeviceType.Tablet){
        return this + 14.0;
    } else if (context.isIOS && context.getDeviceType() == DeviceType.Tablet) {
      return this + 14.0;
    }
  }

  toSmallValue(BuildContext context) {
    if (context.getDeviceType() == DeviceType.Phone) {
      return this;
    } else {
      return this + 2;
    }
  }
}

enum DeviceType { Phone, Tablet ,Fold }

extension BuildContextExtension on BuildContext {
  DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550 ? DeviceType.Phone : DeviceType.Tablet;
  }

  Orientation? getOrentation() {
    if (this != null) {
      return MediaQuery.of(this!).orientation;
    }
    return null;
  }

  bool isNightMode() {
    return ThemeCubit.get(this).isDark;
  }

  DeviceType getDeviceTabletType(bool isPortrait) {
    if(isAndroid && getDeviceType() == DeviceType.Tablet){
        return DeviceType.Tablet;
    } else if (isIOS && getDeviceType() == DeviceType.Tablet) {
      return DeviceType.Tablet;
    }else{
      return DeviceType.Tablet;
    }
  }

  double getScaleRatio() {
    double ratio = 0.0;
    if(getDeviceType()==DeviceType.Tablet){
      if (platform == TargetPlatform.iOS) {
        ratio = 0.8250;
      } else {
        if (getDeviceTabletType(ContextExtensions(this).isPortrait) == DeviceType.Fold) {
          ratio = 0.870;
        } else {
          ratio = 0.7350;
        }
      }
    }else{
      ratio = ContextExtensions(this).isPortrait ? 1.05 : 0.915;
    }

    return ratio;
  }

  bool isPlatformAndroid() {
    return Platform.isAndroid;
  }

  bool isLanguageArabic() {
    return (DataPreference.getPreference()?.getString(Constants.Locale) ?? "ar") !=  "ar";
  }

  bool isDoublePages() {
     if(getDeviceType() == DeviceType.Phone) {
       return false;
     } else {
       return DataPreference.getPreference()?.getBool(Constants.DoublePages)??true;
     }
  }

  void changeDoublePages(bool value){
    DataPreference.getPreference()?.setBool(Constants.DoublePages,value);
  }
}

extension ListRectExtension on List<Rect> {
  int isInside(int x, int y) {
    for (var i = 0; i < this.length; i++) {
      if ((x >= (this[i].left) &&
          x <= (this[i].right) &&
          y >= (this[i].top) &&
          y <= (this[i].bottom))) return i;
    }
    return -1;
  }

  Rect unified() {
    Rect bigRect = Rect.fromLTRB(0, 0, 0, 0);
    if (isNotEmpty) {
      double minLeft = this[0].left;
      double minTop = this[0].top;
      double maxRight = this[0].right;
      double maxBottom = this[0].bottom;
      for (final tempElement in this) {
        if (tempElement.left < minLeft) {
          minLeft = tempElement.left;
        }
        if (tempElement.top < minTop) {
          minTop = tempElement.top;
        }
        if (tempElement.right > maxRight) {
          maxRight = tempElement.right;
        }
        if (tempElement.bottom > maxBottom) {
          maxBottom = tempElement.bottom;
        }
      }
      return Rect.fromLTRB(minLeft, minTop, maxRight, maxBottom);
    }
    return bigRect;
  }

  List<Rect> coalesced(int threshold) {
    var rects = this.toList();
    List<Rect> mapValues1 = [];
    HashMap<double, List<Rect>> tempMap1 =
    rects.groupedRoughlyByMinY(threshold);
    tempMap1.forEach((key, value) {
      mapValues1.add(value.unified());
    });
    mapValues1.sort((a, b) => a.top.compareTo(b.top));
    mapValues1.sort((a, b) => a.left.compareTo(b.left));
    rects = mapValues1;

    List<Rect> mapValues2 = [];
    HashMap<Rect, List<Rect>> tempMap2 =
    rects.groupedRoughlyByLeftAndRight(threshold);
    tempMap2.forEach((key, value) {
      mapValues2.add(value.unified());
    });
    mapValues2.sort((a, b) => a.top.compareTo(b.top));
    mapValues2.sort((a, b) => a.left.compareTo(b.left));
    rects = mapValues2;
    return rects.edgesRegulated(threshold);
  }

  HashMap<double, List<Rect>> groupedRoughlyByMinY(int threshold) {
    var grouped = HashMap<double, List<Rect>>();
    for (final rect in this) {
      var isNewGroup = true;
      for (final key in grouped.keys) {
        if ((rect.top - key).abs() <= threshold) {
          isNewGroup = false;
          grouped[key]?.add(rect);
          break;
        }
      }
      if (isNewGroup) {
        List<Rect> list = [];
        list.add(rect);
        grouped[rect.top] = list;
      }
    }
    return grouped;
  }

  HashMap<Rect, List<Rect>> groupedRoughlyByLeftAndRight(int threshold) {
    var grouped = HashMap<Rect, List<Rect>>();
    for (final rect in this) {
      var isNewGroup = true;
      for (final key in grouped.keys) {
        if (((rect.left - key.left).abs() <= threshold &&
            (rect.right - key.right).abs() <= threshold) &&
            ((rect.top - key.bottom).abs() <= threshold ||
                (rect.bottom - key.top).abs() <= threshold)) {
          isNewGroup = false;
          grouped[key]?.add(rect);
          List<Rect>? temp = grouped[key];
          grouped.remove(key);
          //todo check expandToInclude instead of union
          key.expandToInclude(rect);
          grouped[key] = temp!;
          break;
        }
      }
      if (isNewGroup) {
        List<Rect> list = [];
        list.add(rect);
        grouped[rect] = list;
      }
    }

    return grouped;
  }

  List<Rect> edgesRegulated(int threshold) {
    var result = this.toList();
    // Regulate horizontal edges.
    for (final rect1 in result) {
      var minX = rect1.left;
      var maxX = rect1.right;
      for (final rect2 in result) {
        if ((rect1.left - rect2.left).abs() <= threshold) {
          minX = min(minX, rect2.left);
        }
        if ((rect1.right - rect2.right).abs() <= threshold) {
          maxX = max(maxX, rect2.right);
        }
      }

      for (Rect rect in result) {
        if ((minX - rect.left).abs() <= threshold) {
          rect = Rect.fromLTRB(minX, rect.top, rect.right, rect.bottom);
        }

        if ((maxX - rect.right).abs() <= threshold) {
          rect = Rect.fromLTRB(rect.left, rect.top, maxX, rect.bottom);
        }
      }
    }

    // Regulate vertical edges.
    if (result.length > 1) {
      for (var i = 1; i < result.length - 1; i++) {
        if (result[i].top < result[i - 1].bottom) {
          // if (result[i - 1].width < result[i].width) {
          //   result[i] = Rect.fromLTRB(result[i].left,
          //       result[i - 1].bottom, result[i].right, result[i].bottom);
          // } else {
          //   result[i] = Rect.fromLTRB(result[i].left,
          //       result[i - 1].bottom, result[i].right, result[i].bottom);
          // }

          result[i] = Rect.fromLTRB(result[i].left, result[i - 1].bottom,
              result[i].right, result[i].bottom);
        } else if (result[i].top > result[i - 1].bottom) {
          if (result[i - 1].width < result[i].width) {
            result[i - 1] = Rect.fromLTRB(
                result[i - 1].left,
                result[i - 1].top,
                result[i - 1].right,
                result[i - 1].bottom +
                    (result[i - 1].bottom - result[i].top).abs());
          } else {
            result[i] = Rect.fromLTRB(result[i].left, result[i - 1].bottom,
                result[i].right, result[i].bottom);
          }
        }
      }
    }
    return result;
  }
}

extension WidgetExtension on Widget {
  BoxDecoration getBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).whiteGray,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      boxShadow: const [
        BoxShadow(
          blurRadius: 2,
          blurStyle: BlurStyle.outer,
          color: Colors.black45,
          offset: Offset.zero,
          spreadRadius: 0,
        ),
      ], // Rounded corners
    );
  }

  BoxDecoration getBoxDecorationWithoutShadow(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).blue,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      boxShadow: const [
        BoxShadow(
          blurRadius: 1.2,
          blurStyle: BlurStyle.outer,
          color: Colors.black45,
          offset: Offset.zero,
          spreadRadius: 0,
        ),
      ], // Rounded corners
    );
  }

  BoxDecoration getBoxDecorationWhiteWithoutShadow(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).whiteGray,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      boxShadow: const [
        BoxShadow(
          blurRadius: 0,
          blurStyle: BlurStyle.outer,
          color: Colors.black26,
          offset: Offset.zero,
          spreadRadius: 0,
        ),
      ], // Rounded corners
    );
  }

  BoxDecoration getBoxDecorationWithShadow(Color? colors) {
    return BoxDecoration(boxShadow: const [
      BoxShadow(
        color: Colors.grey, // Subtle shadow color
        spreadRadius: 1, // Shadow spread
        blurRadius: 25, // Shadow blur
        offset: Offset(0, 8),
      ),
    ], color: colors);
  }

  BoxDecoration getBoxDecorationWithShadowBottomOnly(Color? colors) {
    return BoxDecoration(boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        // Subtle shadow color
        spreadRadius: 2,
        // Shadow spread
        blurRadius: 15,
        // Shadow blur
        blurStyle: BlurStyle.normal,
        offset: Offset.zero,
        // offset: Offset(0, 8),
      ),
    ], color: colors);
  }
}