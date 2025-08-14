import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:great_quran/core/cache/DataPreference.dart';
import 'package:great_quran/core/extensions/extensions.dart';
import 'package:great_quran/core/utils/Constants.dart';
import 'package:great_quran/core/utils/color_manager.dart';
import 'package:great_quran/core/utils/fonts_manager.dart';
import 'package:great_quran/core/utils/values_manager.dart';
import 'package:great_quran/features/ayat_library/presentation/extensions/screen_extension.dart';

class DragUpOrDownDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Center(
          child: Container(height: 510,
            width: context.isTablet? 655: double.infinity,
            padding: EdgeInsets.all(20.value),
            margin: EdgeInsets.all(20.value),decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.black45)],
              ),
            child:  Column(
              children: [
                Container(padding: EdgeInsets.all(6),alignment: Alignment.centerRight,child: Text("قم بالسحب لأسفل\nلتشغيل النمط الليلي",style: TextStyle(fontSize: 18,fontFamily: Fonts.IBM,color: Colors.white),)),
                Container(padding: EdgeInsets.fromLTRB(0,8,(context.mediaQuery.size.width-40)/5,8),alignment: Alignment.centerRight,child: SvgPicture.asset('assets/svg/swipe_down.svg')),
                Container(padding: EdgeInsets.fromLTRB((context.mediaQuery.size.width-40)/5,8,0,8),alignment: Alignment.centerLeft,child: SvgPicture.asset('assets/svg/swipe_up.svg')),
                Container(padding: EdgeInsets.all(6),alignment: Alignment.centerLeft,child: Text("قم بالسحب لأعلى\nلتشغيل النمط النهاري",style: TextStyle(fontSize: 18,fontFamily: Fonts.IBM,color: Colors.white),)),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppPadding.p20),
                  child: SizedBox(
                    height: 52,
                    width: double.infinity,
                    child: TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll<Color>(ColorManager.primary)),
                      child: Text(
                        'حسنــــــــــاً',
                        style: TextStyle(
                            color: ColorManager.white,
                            fontStyle: FontStyle.normal,
                            fontFamily: Constants.IBM,
                            fontSize: 17.0.toValue(context)),
                      ),
                      onPressed: () {
                        DataPreference.getPreference()?.setBool(Constants.ShowDragMSG,false);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

}