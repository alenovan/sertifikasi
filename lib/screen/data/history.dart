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
import 'package:softwaresertifikasi/widget/Button.dart';
import 'package:intl/intl.dart';
import 'package:softwaresertifikasi/widget/Extentions.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final DbHelper _helper = new DbHelper();
  List<CashFlow> _historyOrderModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _helper.getData(CashFlowQuery.TABLE_NAME).then((value) {
      value.forEach((element) {
        CashFlow data = CashFlow.fromJson(element);
        setState(() {
          _historyOrderModels.add(data);
        });
        print(data.toJson());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Beranda()));
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              elevation: 2,
              backgroundColor: Colors.white,
              title: Text("Detail Cash Flow",
                  style: popins.copyWith(fontSize: 20.sp, color: Colors.black)),
            ),
            backgroundColor: Colors.white,
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: _historyOrderModels.length,
                itemBuilder: (c, i) {
                  var nominal = "";
                  var icon;
                  var color;

                  var data  = 0;
                  try{
                    data = int.parse(_historyOrderModels[i].nominal.toString());
                  }catch(e){
                    data = 0;
                  }

                  if (_historyOrderModels[i].type == 1) {
                    nominal = "[+]" + numberFormat(data, true);
                    icon = Icons.arrow_forward;
                    color = ColorResources.COLOR_GREEN_TEXT;
                  } else {

                    nominal = "[-]" + numberFormat(data, true);
                    icon = Icons.arrow_back_outlined;
                    color = ColorResources.COLOR_RED_LOVE_IG;
                  }
                  return Container(
                    padding: EdgeInsets.all(10.h),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${nominal}",
                                style: popins.copyWith(
                                  fontWeight: FontWeight.w600,
                                    fontSize: 15.sp, color: Colors.black)),
                            Text("${_historyOrderModels[i].keterangan}",
                                style: popins.copyWith(
                                    fontSize: 13.sp, color: Colors.black)),
                            Text("${_historyOrderModels[i].date}",
                                style: popins.copyWith(
                                    fontSize: 13.sp, color: Colors.black))
                          ],
                        ),
                        Container(
                          child: Icon(
                            icon,
                            color: color,
                            size: 60.sp,
                          ),
                        )
                      ],
                    ),
                  );
                })));
  }
}
