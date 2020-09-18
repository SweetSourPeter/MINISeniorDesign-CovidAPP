# COVID-App

COVID-App is a tiny cross-platform mobile app developed using [Flutter](https://github.com/flutter/flutter) to report and track your daily symptoms (or your status if you are not ill) in order to slow the spread of [COVID-19 (click to view COVID-19 from CDC)](https://www.cdc.gov/coronavirus/2019-ncov/index.html). It also provides an Admin-Dashboard to monitor symptoms.

And here's why you might want to use it:

* You want to keep an eye on the latest COVID data in your country.
* You want to help slow down this pandemic by self-reporting your symptoms.
* You are a school administrator and want to monitor students daily status.
* You are a Flutter engineer and you want to see the difference between your team and the best Flutter team in the world.


## Agile Development

### Sprints

Following are the 3 main sprints we went through:
1. App basic structure setup. 
We divided our work into two: The sign-in page and the user `MainMenu`. This would include basic functions such as Email sign-up/sign-in, user main dashboard to view COVID-19 cases. This work is done in the first three days after the project assigned. 
2. Additional functions into the app. 
In the login page, we added a google sign-in option and two providers for user state management. Whereas for the main user page, we added test registration and daily symptom reports both connected to firebase. We spend two days testing these features as well as moving on to the next stage.
3. Finalize the app. 
[Hanming](https://github.com/labmem008) starts to sums up the entire projects by writing a comprehensible Readme. [Peter](https://github.com/SweetSourPeter) keeps on working the user/admin dashboard with additional functions such as `health kit`, `qr_code` generator/scanner, user’s own submitted reports review, and admin test/reports review.

### Team work division
User/admin login, sign-up, README.md by [Hanming](https://github.com/labmem008).
User main page, admin main page, additional functions, provider design by [Peter](https://github.com/SweetSourPeter).

## App Structure
The following picture shows the widget tree.
![COVID-App Widget Tree](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/structure.png)

### Folders and Files

All of our files are organized and put into different folders.
`provider` folder holds all of our flutter providers, which we will discuss later in details.
`pages` folder includes all the app pages that can are visible to our app users.
`serives` folder includes our implementation of app back-end services like authentication and COVID-API data support and such.

### Models

In our sub-folder `models`, we create several classes to store our special data types, for example, in `user.dart`:

```dart
class User {
  final String uid;
  final bool admin;
  User({this.uid, this.admin});
}
```

Many of these classes in `models` include data transformation. To obtain data from or store data into Firebase, we need a way to convert data inside the class to Firebase readable data.

```dart
factory GlobalSummaryModel.fromJson(Map<String, dynamic> json) {
    return GlobalSummaryModel(
      json["Global"]["NewConfirmed"],
      json["Global"]["TotalConfirmed"],
      json["Global"]["NewDeaths"],
      json["Global"]["TotalDeaths"],
      json["Global"]["NewRecovered"],
      json["Global"]["TotalRecovered"],
      DateTime.parse(json["Date"]),
    );
  }
```

### Provider
[Provider](https://github.com/rrousselGit/provider) is a powerful state management tool for Flutter. 
> Flutter is declarative. This means that Flutter builds its user interface to reflect the current state of your app.
> A provider is a wrapper around [InheritedWidget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html) to make them easier to use and more reusable.

Quoted from [https://github.com/rrousselGit/provider.](https://github.com/rrousselGit/provider) 
```dart
Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(create: (context) => AuthenticateService().user),
        ChangeNotifierProvider(create: (context) => CovidTestProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid Demo',
        home: Wrapper(),
      ),
    );
  }
```

Inherited widgets deeply down the widget tree can easily use the data inside providers simultaneously with the help of `provider` package. In our case, each page can have access to the authenticate status and show different pages based on if the user is authenticated or not. It also separate a user login and an administrator login.

## App Functions Demo

In this section, we demonstrate our deliveries via showing the main functions of the app along with images and possibly GIFs for effectiveness purposes.

### Sign-in Methods

We support totally 3 major sign-in methods including by pure email/password or by **SSO** (with Google and Facebook being supported).

![Sign-in Page](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/login.png)

* You can sign-in with only an email and a password:

![Password Sign-in](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/ep.gif)

* You can sign-in with your Facebook account **in the future**! Ta dah!
[Subscribe us](https://www.na-cc.com/) if you want to login with your Facebook account!

![Facebook](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/fac.png)

* You can definitely sign in with your Google account:

![Google Sign-in](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/gog.gif)

### User Main Page (with outside COVID data source!)
Our main page contains three sub-pages, including a sideway panel, a world-wide COVID data, and a COVID data page in your own country. It is set to your current location but you can change your location if you wish. The data came from [https://api.covid19api.com/summary](https://api.covid19api.com/summary). See `lib/service/covid19APIService.dart` in case you wonder how we implement it.

![User Main Page](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/mu.gif)

Clicking the sideway panel, students are then be able to submit a daily symptoms report, and we've made it **very convenient** that a QR square is generated containing the daily report!

![Daily Report](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/dr.gif)

Besides, students can schedule for a COVID test if they think it's necessary:

![Register Test](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/ct.gif)

Notice that when you are inside this page, you will be asked to provide your Google account information. This is because we have [**GoogleFit**](https://www.google.com/fit/) fully integrated in our app (via [`flutter health package`](https://pub.dev/packages/health))! Currently, we don't have any data yet, but the database of GoogleFit is connected to our app with a return value of `null` for now.

![Register Test](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/hk1.gif)

```dart
  Future.delayed(Duration(seconds: 2), () async {
      _isAuthorized = await FlutterHealth.requestAuthorization();
      if (_isAuthorized)
        _gfDataList
            .addAll(await FlutterHealth.getGFAllData(startDate, endDate));
      setState(() {});

      if (_isAuthorized)
        _hkDataList.addAll(
            await FlutterHealth.getHKBodyTemperature(startDate, endDate));
      setState(() {});
    });
```

### Admin Dashboard
We support an admin dashboard to monitor scheduled tests, students status, and more.
Currently, a user can only be authenticated to be an administrator by changing the user data `bool admin` from our Firebase back-end, that is, all users has a `false` value of `admin` by default. 

![Firebase Backend](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/fb.png)

Want to learn Flutter with Firebase from scratch? We've found [this tutorial](https://www.youtube.com/watch?v=sfA3NWDBPZ4&list=PL4cUxeGkcC9j--TKIdkb3ISfRbJeJYQwC) on YouTube useful for beginners.

![Admin Dashboard](https://github.com/SweetSourPeter/MINISeniorDesign-CovidAPP/blob/master/lib/mdimg/asd.gif)

## Authors

Made by [@Yaopu, aka Peter](https://github.com/SweetSourPeter) and [@Hanming](https://github.com/labmem008) who are in turn powered by :fries:, :hamburger: and :cake:.
See our official website [North America Classmate Connect](https://www.na-cc.com/).
We are open to new members!