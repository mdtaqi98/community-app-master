import 'package:analise_test/components/Post/screens/Search_Bar.dart';
import 'package:analise_test/components/Post/screens/home.dart';
import 'package:analise_test/pages/FogotPassword/index.dart';
import 'package:analise_test/pages/Login/index.dart';
import 'package:analise_test/pages/SignUp/index.dart';
import 'package:analise_test/theme/style.dart';
import 'package:flutter/material.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    "/SignUp": (BuildContext context) => new SignUpScreen(),
    "/Login": (BuildContext context) => new LoginScreen(),
    "/HomePage": (BuildContext context) => new HomePage(),
    "/ForgotPassword": (BuildContext context) => new ForgotPasswordScreen(),
    "/SearchBar": (BuildContext context) => new SearchBar(),
  };

  Routes() {
    runApp(new MaterialApp(
      title: "Analise App",
      home: new LoginScreen(),
      theme: appTheme,
      routes: routes,
    ));
  }
}
