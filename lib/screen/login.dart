import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:softwaresertifikasi/models/User.dart';
import 'package:softwaresertifikasi/screen/beranda.dart';
import 'package:softwaresertifikasi/service/database.query/UserQuery.dart';
import 'package:softwaresertifikasi/service/db_helper.dart';
import 'package:softwaresertifikasi/uitls/ColorResources.dart';
import 'package:softwaresertifikasi/uitls/Typoghrapy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softwaresertifikasi/widget/BottomSheetFeedback.dart';
import 'package:softwaresertifikasi/widget/Button.dart';
import 'package:softwaresertifikasi/widget/Extentions.dart';
import 'package:softwaresertifikasi/widget/LoadingDialog.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late FocusNode _passFocus;
  late FocusNode _usernameFocus;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  final DbHelper _helper = new DbHelper();
  List<User> _userModels = [];
  List<User> _userModelsLogin = [];

  @override
  void initState() {
    _passFocus = FocusNode();
    _usernameFocus = FocusNode();
    _usernameFocus.addListener(_onOnFocusPassEvent);
    _passFocus.addListener(_onOnFocusPassEvent);
    super.initState();
    _helper.getData(UserQuery.TABLE_NAME).then((value) {
      value.forEach((element) {
        User data = User.fromJson(element);
        _userModels.add(data);
        debugPrint(data.name);
      });
    });


  }

  void login() async {

    LoadingDialog.show(context, "Loading");

    if (_userModels.length <= 0) {
      var insert = _helper.insert(UserQuery.TABLE_NAME,
          {"id": "1", "name": "user", "password": "user"});
    }
    if(usernameController.text.length < 1 || passController.text.length < 1 ){
      popScreen(context);
      BottomSheetFeedback.showError(
          context, "Mohon Maaf", "pastikan data terisi semua");
    }else{
      try{
        await _helper.postLogin(UserQuery.TABLE_NAME, passController.text,usernameController.text).then((value) {
          value.forEach((element) {
            User data = User.fromJson(element);
            _userModelsLogin.add(data);
          });
        });
        popScreen(context);
        if(_userModelsLogin.length >= 1){
          BottomSheetFeedback.show_success(
              context, "Terimakasih",_userModelsLogin.length.toString());
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Beranda()));
        }else{
          BottomSheetFeedback.showError(
              context, "Mohon Maaf", "Username Password salah");
        }



      }catch(e){
        BottomSheetFeedback.showError(
            context, "Mohon Maaf", e.toString());
      }
    }

  }

  _onOnFocusNodeEvent() {
    setState(() {});
  }

  _onOnFocusPassEvent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_WHITE,
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child:   Lottie.asset('assets/animation/data.json'),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              alignment: Alignment.center,
              child: Text(
                "MY CASH BOOK v1.0",
                style: popins.copyWith(
                    fontWeight: FontWeight.w600, fontSize: 24.sp),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Keep your data safe!",
                style: popins.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                    color: ColorResources.greyTextVisi),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h),
              child: TextFormField(
                controller: usernameController,
                focusNode: _usernameFocus,
                decoration: InputDecoration(
                  labelText: 'Username',
                  fillColor: ColorResources.greyVeryYoung,
                  filled: true,
                  labelStyle: popins.copyWith(
                      fontSize: _usernameFocus.hasFocus ? 15.sp : 13.sp,
                      color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  hintStyle: popins.copyWith(
                      color: ColorResources.greyText, fontSize: 8.sp),
                  contentPadding: EdgeInsets.only(left: 10.w),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorResources.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                style: popins.copyWith(fontSize: 13.sp),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h),
              child: TextFormField(
                obscureText: true,
                controller: passController,
                focusNode: _passFocus,
                decoration: InputDecoration(
                  labelText: 'Password',
                  fillColor: ColorResources.greyVeryYoung,
                  filled: true,
                  labelStyle: popins.copyWith(
                      fontSize: _passFocus.hasFocus ? 15.sp : 13.sp,
                      color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  hintStyle: popins.copyWith(
                      color: ColorResources.greyText, fontSize: 8.sp),
                  contentPadding: EdgeInsets.only(left: 10.w),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorResources.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                style: popins.copyWith(fontSize: 13.sp),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 25.h),
                child: GestureDetector(
                    child: Button(
                  functionClick: () {
                    login();

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
                    "Login",
                    style: metropolis.copyWith(
                        color: ColorResources.whiteText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}
