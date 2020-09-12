import 'package:covidapp/models/globalSummary.dart';
import 'package:covidapp/pages/contants/contant.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class GlobalStatistics extends StatelessWidget {
  final GlobalSummaryModel summary;

  GlobalStatistics({@required this.summary});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildCard("CONFIRMED", summary.totalConfirmed, summary.newConfirmed,
              kConfirmedColor),
          buildCard(
              "ACTIVE",
              summary.totalConfirmed -
                  summary.totalRecovered -
                  summary.totalDeaths,
              summary.newConfirmed - summary.newRecovered - summary.newDeaths,
              kActiveColor),
          buildCard("RECOVERED", summary.totalRecovered, summary.newRecovered,
              kRecoveredColor),
          buildCard(
              "DEATH", summary.totalDeaths, summary.newDeaths, kDeathColor),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Text(
              "Statistics updated " + timeago.format(summary.date),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, int totalCount, int todayCount, Color color) {
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        totalCount.toString().replaceAllMapped(reg, mathFunc),
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Today",
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        todayCount.toString().replaceAllMapped(reg, mathFunc),
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
