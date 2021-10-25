
import 'package:flutter/material.dart';
import 'package:softwaresertifikasi/uitls/ColorResources.dart';
import 'package:softwaresertifikasi/uitls/Typoghrapy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softwaresertifikasi/widget/Extentions.dart';

class BottomSheetFeedback {
  const BottomSheetFeedback();

  static Future showError(BuildContext context,
      String title, String description) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    hideKeyboard(context);
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60.sp,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: metropolis.copyWith(color: ColorResources.COLOR_LIGHT_BLACK, fontSize: 25.sp,fontWeight: FontWeight.w600),
                ),
                Container(
                    margin: EdgeInsets.only(top:5.h),
                    child: Text(description,
                      textAlign: TextAlign.center,
                      style: popins.copyWith( fontSize: 17.sp),
                    ))
              ],
            ),
          );
        });
    return;
  }

  static Future show_success(BuildContext context,String title, String description) async {
    double _screenWidth = MediaQuery.of(context).size.width;
    hideKeyboard(context);
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screenWidth * (15 / 100),
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7.5 / 2),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Icon(
                  Icons.check_circle,
                  color: ColorResources.COLOR_PRIMARY,
                  size: 60.h,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: metropolis.copyWith(color: ColorResources.COLOR_LIGHT_BLACK, fontSize: 25.sp,fontWeight: FontWeight.w600),
                ),
                Container(
                    margin: EdgeInsets.only(top:5.h),
                    child: Text(description,
                      textAlign: TextAlign.center,
                      style: popins.copyWith(fontSize: 17.sp),
                    ))
              ],
            ),
          );
        });
    return;
  }
}
