import 'package:barcode_scan/barcode_scan.dart';
import 'package:covidapp/models/user.dart';
import 'package:covidapp/pages/contants/contant.dart';
import 'package:covidapp/pages/studentPage/covidTestReg.dart';
import 'package:covidapp/pages/studentPage/dailyReport.dart';
import 'package:covidapp/providers/userTestProvider.dart';
import 'package:covidapp/service/authenticate.dart';
import 'package:covidapp/service/authenticate_service.dart';
import 'package:covidapp/service/wrapper.dart';
import 'package:covidapp/widgets/country.dart';
import 'package:covidapp/widgets/global.dart';
import 'package:covidapp/widgets/myButton.dart';
import 'package:covidapp/widgets/qrCodeDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

final Color backgroundColor = lightBlack;

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  AuthenticateService authenticateService = new AuthenticateService();
  bool isCollapsed = true;
  bool isCollapsedAnimate = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  int initialPage = 1;
  List<String> pageTitle = ['Global Cases', 'Your Country', 'User Report'];
  List<Widget> pages = [Global(), Country(), Country()];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ScanResult qrResult;
  Future<void> _scan() async {
    setState(() async {
      qrResult = await BarcodeScanner.scan(
        options: ScanOptions(
          useCamera: camera,
        ),
      );
    });
    // ScanResult
  }

  int camera = 1;
  // Future<void> qrcodeScanner() async {
  //   setState(() async {
  //     qrResult = await BarcodeScanner.scan();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    // final user = Provider.of<User>(context);

    final covidTestInfo = Provider.of<CovidTestProvider>(context);
    final userdata = Provider.of<UserData>(context);
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: screenHeight,
              width: 0.6 * screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    // height: screenHeight * 0.25,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            userdata == null ? '' : userdata.email,
                            style: TextStyle(color: whiteAndGray),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Container(
                    // key: globalKey,
                    width: double.infinity,
                    // height: screenHeight / 0.5,
                    child: Column(
                      children: <Widget>[
                        MyButton(
                          onTap: () {
                            print('navigate to Daily Report');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MultiProvider(providers: [
                                        ChangeNotifierProvider<
                                            CovidTestProvider>.value(
                                          value: covidTestInfo,
                                        ),
                                      ], child: UserDailyReport())),
                            );
                          },
                          text: "Daily Covid Report",
                          iconData: Icons.report,
                          textSize: 16,
                          height: (screenHeight) / 10,
                        ),
                        MyButton(
                          onTap: () {
                            print('navigate to test reg');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MultiProvider(providers: [
                                        ChangeNotifierProvider<
                                            CovidTestProvider>.value(
                                          value: covidTestInfo,
                                        ),
                                      ], child: CovidTestReg())),
                            );
                          },
                          text: "Registry for Covid Test",
                          iconData: Icons.local_hospital,
                          textSize: 16,
                          height: (screenHeight) / 10,
                        ),
                        MyButton(
                          text: "Settings",
                          iconData: Icons.settings,
                          textSize: 16,
                          height: (screenHeight) / 10,
                        ),
                        MyButton(
                          onTap: () {
                            authenticateService.signOut().then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wrapper()),
                              );
                            });
                          },
                          text: "Log Out",
                          iconData: Icons.offline_bolt,
                          textSize: 16,
                          height: (screenHeight) / 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setIsCollapsedAnimate() {
    print('onend called');
    setState(() {
      isCollapsedAnimate = isCollapsed;
    });
  }

  Widget dashboard(context) {
    print(isCollapsedAnimate);
    return AnimatedPositioned(
      duration: duration,
      onEnd: setIsCollapsedAnimate,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (!isCollapsed) {
                  _controller.reverse();
                  isCollapsed = !isCollapsed;
                }
              });
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  floating: true,
                  centerTitle: true,
                  title: Text(pageTitle[initialPage],
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                  leading: IconButton(
                    iconSize: 30,
                    color: whiteAndGray,
                    padding: EdgeInsets.only(left: kDefaultPadding),
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      //TODO
                      setState(() {
                        if (isCollapsed)
                          _controller.forward();
                        else
                          _controller.reverse();
                        isCollapsedAnimate = !isCollapsedAnimate;
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                        iconSize: 30,
                        color: whiteAndGray,
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        icon: Icon(Icons.camera),
                        onPressed: () {
                          print('cam called');
                          //TODO
                          _scan();
                          print(qrResult); // The barcode content
                        })
                  ],
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Text(pageTitle[initialPage],
                        //         style: TextStyle(
                        //             fontSize: 24, color: Colors.white)),
                        //     Icon(Icons.camera, color: Colors.white),
                        //   ],
                        // ),
                        SizedBox(height: 20),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: kDefaultPadding),
                          child: AspectRatio(
                            aspectRatio: isCollapsedAnimate ? 0.75 : 0.4,
                            child: PageView.builder(
                              onPageChanged: (value) {
                                setState(() {
                                  initialPage = value;
                                  print('page changes $initialPage');
                                });
                              },
                              // controller: _pageController,
                              physics: ClampingScrollPhysics(),
                              itemCount: 3, // 2 covid senarials
                              itemBuilder: (context, index) => pages[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
