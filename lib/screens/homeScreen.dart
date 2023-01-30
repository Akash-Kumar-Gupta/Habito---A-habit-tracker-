// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:habito/constants/routes.dart';
import 'package:habito/utils/date_utils.dart' as date_util;
import 'package:habito/utils/colors_util.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          date_util.DateUtils.months[currentDateTime.month - 1] +
              ' ' +
              currentDateTime.year.toString(),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return Container(
      height: 60,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Container(
            width: 60,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: (currentMonthList[index].day != currentDateTime.day)
                        ? [
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.7),
                            Colors.white.withOpacity(0.6)
                          ]
                        : [
                            Color.fromRGBO(141, 74, 248, 100),
                            Color.fromRGBO(141, 74, 248, 100),
                            Color.fromRGBO(141, 74, 248, 100)
                          ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black12,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  currentMonthList[index].day.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? HexColor("465876")
                              : Colors.white),
                ),
                Text(
                  date_util
                      .DateUtils.weekdays[currentMonthList[index].weekday - 1],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? HexColor("465876")
                              : Colors.white),
                )
              ],
            ),
          ),
        ));
  }

  Widget calendarList() {
    return Container(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        titleView(),
        hrizontalCapsuleListView(),
      ]),
    );
  }

  Widget progressBar() {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 50),
      margin: EdgeInsets.fromLTRB(5, 7, 5, 7),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 300,
            lineWidth: 10.0,
            percent: 0.4,
            progressColor: Color.fromRGBO(141, 74, 248, 50),
            backgroundColor: Color.fromRGBO(141, 74, 248, 70),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String greeting(givenHour) {
      String localGreet = "";
      if (givenHour > 3 && givenHour <= 12) {
        localGreet = "Good Morning";
      } else if ((givenHour > 12) && (givenHour <= 16)) {
        localGreet = "Good Afternoon";
      } else if ((givenHour > 16) && (givenHour <= 20)) {
        localGreet = "Good Evening";
      } else {
        localGreet = "Good Night";
      }
      return localGreet;
    }

    var time = DateTime.now();
    var hour = time.hour.toInt();
    // var hour = 11;
    print(hour.runtimeType);
    String greet = greeting(hour);

    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5, right: 7, left: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [
                      Color.fromRGBO(141, 74, 248, 70),
                      Color.fromRGBO(141, 74, 248, 50),
                      Color.fromRGBO(141, 74, 248, 30)
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text("Hello, Sampad", style: TextStyle(fontSize: 21)),
                      Icon(
                        Icons.notifications,
                        size: 30,
                      )
                    ],
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '$greet',
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      )),
                ],
              ),
            ),
            calendarList()
          ],
        ),
      ),
    ));
  }
}
