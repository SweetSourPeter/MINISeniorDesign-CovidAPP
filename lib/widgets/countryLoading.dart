import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryLoading extends StatelessWidget {
  final bool inputTextLoading;

  CountryLoading({@required this.inputTextLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // inputTextLoading ? loadingInputCard() : Container(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Global Corona Virus Cases",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ],
          ),
        ),
        loadingCard(),
        loadingCard(),
        loadingChartCard(),
      ],
    );
  }

  Widget loadingCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingInputCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: 105,
        padding: EdgeInsets.all(24),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: double.infinity,
            height: 57,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget loadingChartCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: 180,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
