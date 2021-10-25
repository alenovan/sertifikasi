import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:softwaresertifikasi/models/CashFlow.dart';
import 'package:softwaresertifikasi/screen/beranda.dart';
import 'package:softwaresertifikasi/service/database.query/CashFlow.dart';
import 'package:softwaresertifikasi/service/db_helper.dart';
import 'package:softwaresertifikasi/uitls/ColorResources.dart';
import 'package:softwaresertifikasi/uitls/Typoghrapy.dart';
import 'package:softwaresertifikasi/widget/BottomSheetFeedback.dart';
import 'package:softwaresertifikasi/widget/Button.dart';
import 'package:intl/intl.dart';
import 'package:softwaresertifikasi/widget/Extentions.dart';
import 'package:softwaresertifikasi/widget/LoadingDialog.dart';

class Pemasukan extends StatefulWidget {
  const Pemasukan({Key? key}) : super(key: key);

  @override
  _PemasukanState createState() => _PemasukanState();
}

class _PemasukanState extends State<Pemasukan> {
  late FocusNode _tanggalFocus;
  late FocusNode _nominalFocus;
  late FocusNode _keteranganFocus;
  DateTime selectedDate = DateTime.now();
  late DateTime _datePicked = DateTime.now();
  TextEditingController nominalController = new TextEditingController();
  TextEditingController tanggalController = new TextEditingController();
  TextEditingController keteranganController = new TextEditingController();
  final DbHelper _helper = new DbHelper();

  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _datePicked = value;
        tanggalController.text = DateFormat('yyyy-MM-dd').format(_datePicked);
      });
    });
  }
  void simpan() async{
    if(tanggalController.text.length < 1 || nominalController.text.length < 1 || keteranganController.text.length < 1){
      BottomSheetFeedback.showError(
          context, "Mohon Maaf", "pastikan data terisi semua");
    }else{

      LoadingDialog.show(context, "Loading");
      try{
        var insert = await _helper.insert(CashFlowQuery.TABLE_NAME, {"date":"${tanggalController.text.toString()}","nominal":"${nominalController.text.toString()}","keterangan":"${keteranganController.text.toString()}","type":1});
        popScreen(context);
        BottomSheetFeedback.show_success(
            context, "Terimakasih","Data tersimpan");
      }catch(e){
        BottomSheetFeedback.showError(
            context, "Mohon Maaf", e.toString());
      }
    }
  }

  @override
  void initState() {
    _tanggalFocus = FocusNode();
    _nominalFocus = FocusNode();
    _keteranganFocus = FocusNode();
    _nominalFocus.addListener(_onOnFocusPassEvent);
    _tanggalFocus.addListener(_onOnFocusPassEvent);
    _keteranganFocus.addListener(_onOnFocusPassEvent);

    _helper.getData(CashFlowQuery.TABLE_NAME).then((value) {
      value.forEach((element) {
        CashFlow data = CashFlow.fromJson(element);
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => Beranda()));
          return true;
        },
        child:Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text("Tambah Pemasukan",
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
                "Tanggal",
                style: popins.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                    color: ColorResources.greyTextVisi),
              ),
            ),
            SizedBox(height: 10.h,),
            Container(
              child: TextFormField(
                controller: tanggalController,
                readOnly: true,
                onTap: (){
                  _showDatePicker();
                },
                focusNode: _tanggalFocus,
                decoration: InputDecoration(
                  fillColor: ColorResources.greyInputJudul,
                  filled: true,
                  labelStyle:
                  popins.copyWith(fontSize: _tanggalFocus.hasFocus?15.sp:13.sp, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  hintStyle: popins.copyWith(color: ColorResources.greyText, fontSize: 8.sp),
                  contentPadding: EdgeInsets.only(left: 10.w,top: 20.h),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                style: popins.copyWith(fontSize: 13.sp),
              ),
            ),
            SizedBox(height: 10.h,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nominal",
                style: popins.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                    color: ColorResources.greyTextVisi),
              ),
            ),
            SizedBox(height: 10.h,),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: nominalController,
                focusNode: _nominalFocus,
                decoration: InputDecoration(
                  fillColor: ColorResources.greyInputJudul,
                  filled: true,
                  labelStyle:
                  popins.copyWith(fontSize: _nominalFocus.hasFocus?15.sp:13.sp, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  hintStyle: popins.copyWith(color: ColorResources.greyText, fontSize: 8.sp),
                  contentPadding: EdgeInsets.only(left: 10.w,top: 20.h),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                style: popins.copyWith(fontSize: 13.sp),
              ),
            ),
            SizedBox(height: 10.h,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "keterangan",
                style: popins.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                    color: ColorResources.greyTextVisi),
              ),
            ),
            SizedBox(height: 10.h,),
            Container(
              child: TextFormField(
                maxLines: 10,
                controller: keteranganController,
                textAlignVertical: TextAlignVertical.top,
                focusNode: _keteranganFocus,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  fillColor: ColorResources.greyInputJudul,
                  filled: true,
                  labelStyle:
                  popins.copyWith(fontSize: _keteranganFocus.hasFocus?15.sp:13.sp, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  hintStyle: popins.copyWith(color: ColorResources.greyText, fontSize: 8.sp),
                  contentPadding: EdgeInsets.only(left: 10.w,top: 20.h),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorResources.primaryColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                style: popins.copyWith(fontSize: 13.sp),
              ),
            ),
            SizedBox(height: 10.h,),
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
            SizedBox(height: 10.h,),
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
          ],
        ),
    )));
  }
}
