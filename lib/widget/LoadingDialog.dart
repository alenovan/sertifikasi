import 'package:flutter/material.dart';
import 'package:softwaresertifikasi/uitls/ColorResources.dart';
import 'package:softwaresertifikasi/uitls/Typoghrapy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LoadingDialog {
  final BuildContext context;
  LoadingDialog.show(this.context,message) {
    this._show(message);
  }

  void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
  void _show(message) {
    hideKeyboard(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Wrap(
                children: [
                  Material(
                    elevation: 10,
                    color: ColorResources.COLOR_PRIMARY,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: EdgeInsets.all(13),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                              backgroundColor: Colors.white),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${message == null?"loading":message}",style: popins.copyWith(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
