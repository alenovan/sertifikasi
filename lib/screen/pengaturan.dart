import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:softwaresertifikasi/models/User.dart';
import 'package:softwaresertifikasi/screen/beranda.dart';
import 'package:softwaresertifikasi/service/database.query/UserQuery.dart';
import 'package:softwaresertifikasi/service/db_helper.dart';
import 'package:softwaresertifikasi/uitls/ColorResources.dart';
import 'package:softwaresertifikasi/uitls/Typoghrapy.dart';
import 'package:softwaresertifikasi/widget/BottomSheetFeedback.dart';
import 'package:softwaresertifikasi/widget/Button.dart';
import 'package:intl/intl.dart';
import 'package:softwaresertifikasi/widget/Extentions.dart';
import 'package:softwaresertifikasi/widget/LoadingDialog.dart';


class Pengaturan extends StatefulWidget {
  const Pengaturan({Key? key}) : super(key: key);

  @override
  _PengaturanState createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  late FocusNode _passlamaFocus;
  late FocusNode _passbaruFocus;
  TextEditingController passbaruController = new TextEditingController();
  TextEditingController passlamaController = new TextEditingController();
  final DbHelper _helper = new DbHelper();
  List<User> _userModels = [];
  @override
  void initState() {
    _passlamaFocus = FocusNode();
    _passbaruFocus = FocusNode();
    passbaruController.addListener(_onOnFocusPassEvent);
    passlamaController.addListener(_onOnFocusPassEvent);

    _helper.getData(UserQuery.TABLE_NAME).then((value) {
      value.forEach((element) {
        User data = User.fromJson(element);
        print(data.toJson());
      });
    });

    super.initState();
  }

  _onOnFocusNodeEvent() {
    setState(() {});
  }

  _onOnFocusPassEvent() {
    setState(() {});
  }

  void simpan() async{
    if(passlamaController.text.length < 1 || passbaruController.text.length < 1 ){
      BottomSheetFeedback.showError(
          context, "Mohon Maaf", "pastikan data terisi semua");
    }else{
      await _helper.getDataSingleUser(UserQuery.TABLE_NAME,"user").then((value) {
        value.forEach((element) {
          User data = User.fromJson(element);
          _userModels.add(data);
        });
      });
      if(_userModels.length >= 1){
        LoadingDialog.show(context, "Loading");
        try{
          var insert = await _helper.update(UserQuery.TABLE_NAME, {"password":"${passbaruController.text.toString()}"},1);
          popScreen(context);
          BottomSheetFeedback.show_success(
              context, "Terimakasih","Data tersimpan");
        }catch(e){
          BottomSheetFeedback.showError(
              context, "Mohon Maaf", e.toString());
        }
      }else{
        BottomSheetFeedback.showError(
            context, "Mohon Maaf", "password lama salah");
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Beranda()));
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 2,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              title: Text("Pengaturan",
                  style: popins.copyWith(fontSize: 20.sp, color: Colors.black)),
            ),
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.only(top: 20.h),
              margin: EdgeInsets.all(3.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password Lama",
                      style: popins.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp,
                          color: ColorResources.greyTextVisi),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: TextFormField(
                      obscureText: true,
                      controller: passlamaController,
                      focusNode: _passlamaFocus,
                      decoration: InputDecoration(
                        fillColor: ColorResources.greyInputJudul,
                        filled: true,
                        labelStyle: popins.copyWith(
                            fontSize: _passlamaFocus.hasFocus ? 15.sp : 13.sp,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintStyle: popins.copyWith(
                            color: ColorResources.greyText, fontSize: 8.sp),
                        contentPadding: EdgeInsets.only(left: 10.w, top: 20.h),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorResources.primaryColor, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      style: popins.copyWith(fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password baru",
                      style: popins.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp,
                          color: ColorResources.greyTextVisi),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: TextFormField(
                      obscureText: true,
                      controller: passbaruController,
                      focusNode: _passbaruFocus,
                      decoration: InputDecoration(
                        fillColor: ColorResources.greyInputJudul,
                        filled: true,
                        labelStyle: popins.copyWith(
                            fontSize: _passbaruFocus.hasFocus ? 15.sp : 13.sp,
                            color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        hintStyle: popins.copyWith(
                            color: ColorResources.greyText, fontSize: 8.sp),
                        contentPadding: EdgeInsets.only(left: 10.w, top: 20.h),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorResources.primaryColor, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      style: popins.copyWith(fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      child: GestureDetector(
                          child: Button(
                    functionClick: () {
                      simpan();
                    },
                    topLeftRound: 10.w,
                    topRightRound: 10.w,
                    bottomRightRound: 10.w,
                    bottomLeftRound: 10.w,
                    borderColor: ColorResources.primaryColor,
                    textColor: Colors.white,
                    buttonColor: ColorResources.primaryColor,
                    height: 40.h,
                    child: Text(
                      "Simpan",
                      style: metropolis.copyWith(
                          color: ColorResources.whiteText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ))),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      child: GestureDetector(
                          child: Button(
                    functionClick: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Beranda()));
                    },
                    topLeftRound: 10.w,
                    topRightRound: 10.w,
                    bottomRightRound: 10.w,
                    bottomLeftRound: 10.w,
                    borderColor: ColorResources.greyText,
                    textColor: Colors.white,
                    buttonColor: ColorResources.greyText,
                    height: 40.h,
                    child: Text(
                      "Kembali",
                      style: metropolis.copyWith(
                          color: ColorResources.whiteText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ))),
                  SizedBox(
                    height: 90.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network("https://avatars.githubusercontent.com/u/27724482?v=4",width: 100.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ABOUT THIS APP",
                              style: popins.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: ColorResources.greyTextVisi),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Aplikasi ini di buat",
                              style: popins.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13.sp,
                                  color: ColorResources.greyTextVisi),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Alenovan Wiradhika Putra",
                              style: popins.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: ColorResources.greyTextVisi),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "NIm 1741720065",
                              style: popins.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: ColorResources.greyTextVisi),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "25 - 10 -2021",
                              style: popins.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15.sp,
                                  color: ColorResources.greyTextVisi),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
