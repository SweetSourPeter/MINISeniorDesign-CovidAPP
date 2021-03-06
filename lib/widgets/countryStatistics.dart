import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidapp/models/countrySummary.dart';
import 'package:covidapp/models/timeSeries.dart';
import 'package:covidapp/pages/contants/contant.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:timeago/timeago.dart' as timeago;

class CountryStatistics extends StatelessWidget {
  final List<CountrySummaryModel> summaryList;

  CountryStatistics({@required this.summaryList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildCard(
          "CONFIRMED",
          summaryList[summaryList.length - 1].confirmed,
          kConfirmedColor,
          "ACTIVE",
          summaryList[summaryList.length - 1].active,
          kActiveColor,
        ),
        buildCard(
          "RECOVERED",
          summaryList[summaryList.length - 1].recovered,
          kRecoveredColor,
          "DEATH",
          summaryList[summaryList.length - 1].death,
          kDeathColor,
        ),
        buildCardChart(summaryList),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "Statistics updated " + timeago.format(summaryList[1].date),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCard(String leftTitle, int leftValue, Color leftColor,
      String rightTitle, int rightValue, Color rightColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          color: whiteAndGray,
          borderRadius: BorderRadius.circular(15.0),
        ),

        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    leftTitle,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    "Total",
                    style: TextStyle(
                      color: leftColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  AutoSizeText(
                    leftValue.toString().replaceAllMapped(reg, mathFunc),
                    style: TextStyle(
                      color: leftColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    rightTitle,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    "Total",
                    style: TextStyle(
                      color: rightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  AutoSizeText(
                    rightValue.toString().replaceAllMapped(reg, mathFunc),
                    style: TextStyle(
                      color: rightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardChart(List<CountrySummaryModel> summaryList) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 1,
      child: Container(
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Chart(
          _createData(summaryList),
          animate: false,
        ),
      ),
    );
  }

  static List<charts.Series<TimeSeriesCases, DateTime>> _createData(
      List<CountrySummaryModel> summaryList) {
    List<TimeSeriesCases> confirmedData = [];
    List<TimeSeriesCases> activeData = [];
    List<TimeSeriesCases> recoveredData = [];
    List<TimeSeriesCases> deathData = [];

    for (var item in summaryList) {
      confirmedData.add(TimeSeriesCases(item.date, item.confirmed));
      activeData.add(TimeSeriesCases(item.date, item.active));
      recoveredData.add(TimeSeriesCases(item.date, item.recovered));
      deathData.add(TimeSeriesCases(item.date, item.death));
    }

    return [
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kConfirmedColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmedData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Active',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kActiveColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: activeData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Recovered',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kRecoveredColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: recoveredData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Death',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kDeathColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: deathData,
      ),
    ];
  }
}

class Chart extends StatelessWidget {
  final List<charts.Series<TimeSeriesCases, DateTime>> seriesList;
  final bool animate;

  Chart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      domainAxis: charts.EndPointsTimeAxisSpec(),
    );
  }
}
