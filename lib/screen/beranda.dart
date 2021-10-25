import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:softwaresertifikasi/models/CashFlow.dart';
import 'package:softwaresertifikasi/screen/data/history.dart';
import 'package:softwaresertifikasi/screen/data/pemasukan.dart';
import 'package:softwaresertifikasi/screen/data/pengeluaran.dart';
import 'package:softwaresertifikasi/screen/login.dart';
import 'package:softwaresertifikasi/screen/pengaturan.dart';
import 'package:softwaresertifikasi/service/database.query/CashFlow.dart';
import 'package:softwaresertifikasi/service/database.query/UserQuery.dart';
import 'package:softwaresertifikasi/service/db_helper.dart';
import 'package:softwaresertifikasi/uitls/Typoghrapy.dart';
import 'package:softwaresertifikasi/widget/Extentions.dart';
import 'package:flutter/material.dart';
class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}


class _BerandaState extends State<Beranda> {
  List<Color> gradientColors = [
    const Color(0xffacfac4),
    const Color(0xFF51C370),
  ];
  bool showAvg = false;
  final DbHelper _helper = new DbHelper();
  List<CashFlow> _historyOrderModels = [];
  var pemasukan = 0;
  var pengeluaran = 0;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _helper.getData(CashFlowQuery.TABLE_NAME).then((value) {
      value.forEach((element) {
        CashFlow datax = CashFlow.fromJson(element);
        setState(() {
          _historyOrderModels.add(datax);
          if (element["type"] == 1) {
            var data = 0;
            try {
              data = int.parse(element["nominal"]);
            } catch (e) {
              data = 0;
            }
            pemasukan += data;
          } else {
            var data = 0;
            try {
              data = int.parse(element["nominal"]);
            } catch (e) {
              data = 0;
            }
            pengeluaran += data;
          }
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {



    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Login()));
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text("Dashboard",
                style: popins.copyWith(fontSize: 20.sp, color: Colors.black)),
          ),
          backgroundColor: Colors.white,
          body: Container(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Container(
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
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                left: 4.w, top: 2.h, right: 4.w),
                            child: Column(
                              children: [
                                Container(
                                    padding:
                                    EdgeInsets.only(top: 12.h, left: 4.w),
                                    child: Text(
                                      "Rangkuman bulan Ini",
                                      style: metropolis.copyWith(
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            top: 12.h, left: 4.w),
                                        child: Text(
                                          "Pengeluaran  ",
                                          style: popins.copyWith(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            top: 12.h, left: 4.w),
                                        child: Text(
                                          "${numberFormat(pengeluaran, true)}",
                                          style: popins.copyWith(
                                              fontSize: 15.sp,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            top: 12.h, left: 4.w),
                                        child: Text(
                                          "Pemasukan   ",
                                          style: popins.copyWith(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            top: 12.h, left: 4.w),
                                        child: Text(
                                          "${numberFormat(pemasukan, true)}",
                                          style: popins.copyWith(
                                              fontSize: 15.sp,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                // Container(
                //     padding: EdgeInsets.only(top: 12.h, left: 4.w),
                //     child: Text(
                //       "Grafik bulan Ini",
                //       style: metropolis.copyWith(
                //           fontSize: 15.sp,
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold),
                //     )),
                // Container(
                //   height: 100.h,
                //   padding: EdgeInsets.only(top: 5.h),
                //   child: Container(
                //     height: 100.h,
                //     margin: EdgeInsets.all(3.h),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.6),
                //           spreadRadius: 2,
                //           blurRadius: 20,
                //           offset: Offset(0, 3), // changes position of shadow
                //         ),
                //       ],
                //     ),
                //     child: Column(
                //       children: [
                //         Container(
                //         ),
                //         // Column(
                //         //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //         //   children: <Widget>[
                //         //     const SizedBox(
                //         //       height: 37,
                //         //     ),
                //         //     const Text(
                //         //       'Unfold Shop 2018',
                //         //       style: TextStyle(
                //         //         color: Color(0xff827daa),
                //         //         fontSize: 16,
                //         //       ),
                //         //       textAlign: TextAlign.center,
                //         //     ),
                //         //     const SizedBox(
                //         //       height: 4,
                //         //     ),
                //         //     const Text(
                //         //       'Monthly Sales',
                //         //       style: TextStyle(
                //         //         color: Colors.white,
                //         //         fontSize: 32,
                //         //         fontWeight: FontWeight.bold,
                //         //         letterSpacing: 2,
                //         //       ),
                //         //       textAlign: TextAlign.center,
                //         //     ),
                //         //     const SizedBox(
                //         //       height: 37,
                //         //     ),
                //         //     Padding(
                //         //       padding: const EdgeInsets.only(
                //         //           right: 16.0, left: 6.0),
                //         //       child: ,
                //         //     ),
                //         //     const SizedBox(
                //         //       height: 10,
                //         //     ),
                //         //   ],
                //         // ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Container(
                          margin: EdgeInsets.all(3.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 20,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 4.w, top: 2.h, right: 4.w),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                    Pemasukan()));
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Icon(
                                            Icons.monetization_on,
                                            size: 60.sp,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Tambah Pemasukan",
                                                textAlign: TextAlign.center,
                                                style: popins.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              )),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                        ],
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Container(
                          margin: EdgeInsets.all(3.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 20,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 4.w, top: 2.h, right: 4.w),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                    Pengeluaran()));
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Icon(
                                            Icons.add_circle_outline,
                                            size: 60.sp,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Tambah Pengeluaran",
                                                textAlign: TextAlign.center,
                                                style: popins.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              )),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                        ],
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Container(
                          margin: EdgeInsets.all(3.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 20,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 4.w, top: 2.h, right: 4.w),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                    History()));
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Icon(
                                            Icons.list_alt,
                                            size: 60.sp,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Detail Cash Flow",
                                                textAlign: TextAlign.center,
                                                style: popins.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              )),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                        ],
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Container(
                          margin: EdgeInsets.all(3.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                spreadRadius: 2,
                                blurRadius: 20,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Pengaturan()));
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 4.w, top: 2.h, right: 4.w),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Icon(
                                          Icons.settings,
                                          size: 60.sp,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Pengaturan",
                                              textAlign: TextAlign.center,
                                              style: popins.copyWith(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 21.h,
                ),
              ],
            ),
          ),
        ));
  }


// LineChartData mainData() {
//   return LineChartData(
//     gridData: FlGridData(
//       show: true,
//       drawVerticalLine: true,
//       getDrawingHorizontalLine: (value) {
//         return FlLine(
//           color: const Color(0xff37434d),
//           strokeWidth: 1,
//         );
//       },
//       getDrawingVerticalLine: (value) {
//         return FlLine(
//           color: const Color(0xff37434d),
//           strokeWidth: 1,
//         );
//       },
//     ),
//     titlesData: FlTitlesData(
//       show: true,
//       rightTitles: SideTitles(showTitles: false),
//       topTitles: SideTitles(showTitles: false),
//       bottomTitles: SideTitles(
//         showTitles: true,
//         reservedSize: 22,
//         interval: 1,
//         getTextStyles: (context, value) =>
//         const TextStyle(
//             color: Color(0xffffffff),
//             fontWeight: FontWeight.bold,
//             fontSize: 16),
//         getTitles: (value) {
//           switch (value.toInt()) {
//             case 2:
//               return 'MAR';
//             case 5:
//               return 'JUN';
//             case 8:
//               return 'SEP';
//           }
//           return '';
//         },
//         margin: 8,
//       ),
//       leftTitles: SideTitles(
//         showTitles: true,
//         interval: 1,
//         getTextStyles: (context, value) =>
//         const TextStyle(
//           color: Color(0xffffffff),
//           fontWeight: FontWeight.bold,
//           fontSize: 15,
//         ),
//         getTitles: (value) {
//           switch (value.toInt()) {
//             case 1:
//               return '10k';
//             case 3:
//               return '30k';
//             case 5:
//               return '50k';
//           }
//           return '';
//         },
//         reservedSize: 32,
//         margin: 12,
//       ),
//     ),
//     borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d), width: 1)),
//     minX: 0,
//     maxX: 11,
//     minY: 0,
//     maxY: 6,
//     lineBarsData: [
//       LineChartBarData(
//         spots: [
//           FlSpot(0, 3),
//           FlSpot(2.6, 2),
//           FlSpot(4.9, 5),
//           FlSpot(6.8, 3.1),
//           FlSpot(8, 4),
//           FlSpot(9.5, 3),
//           FlSpot(11, 4),
//         ],
//         isCurved: true,
//         colors: gradientColors,
//         barWidth: 5,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: true,
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           colors:
//           gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//         ),
//       ),
//     ],
//   );
// }}
}