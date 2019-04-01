import 'package:analise_test/api/authentication.dart';
import 'package:analise_test/api/validations.dart';
import 'package:analise_test/pages/SignUp/style.dart';
import 'package:analise_test/theme/Buttons/roundedButton.dart';
import 'package:analise_test/theme/Buttons/textButton.dart';
import 'package:analise_test/theme/TextFields/inputField.dart';
import 'package:analise_test/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => new LoginScreenState();
}
//final DocumentReference docRefUsers = Firestore.instance.collection("$uid").document('User Details');
//String userName = 'John Doe';
//String userEmail = 'your_email@example.com';
//int userScore = 0;

class LoginScreenState extends State<LoginScreen> {
  BuildContext context;
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();
  UserData user = new UserData();
  UserAuth userAuth = new UserAuth();
  bool autovalidate = false;
  Validations validations = new Validations();

  onPressed(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      userAuth.verifyUser(user).then((onValue) {
        if (onValue == "Login Successfull") {
          Navigator.pushNamed(context, "/HomePage");
          form.reset();
        } else
          showInSnackBar(onValue);
      }).catchError((PlatformException onError) {
        showInSnackBar(onError.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final Size screenSize = MediaQuery.of(context).size;
    //print(context.widget.toString());
    Validations validations = new Validations();
    return new Scaffold(
      key: _scaffoldKey,
      body: new SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.all(16.0),
          decoration: new BoxDecoration(image: backgroundImage),
          child: new Column(
            children: <Widget>[
              new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFF18D191)),
                    child: new Icon(
                      Icons.local_offer,
                      color: Colors.white,
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(right: 50.0, top: 50.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFFFC6A7F)),
                    child: new Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 30.0, top: 50.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFFFFCE56)),
                    child: new Icon(
                      Icons.local_car_wash,
                      color: Colors.white,
                    ),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 90.0, top: 40.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFF45E0EC)),
                    child: new Icon(
                      Icons.place,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              new Container(
                height: screenSize.height / 1,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Form(
                      key: formKey,
                      autovalidate: autovalidate,
                      child: new Column(
                        children: <Widget>[
                          new InputField(
                              hintText: "Email",
                              obscureText: false,
                              textInputType: TextInputType.text,
                              textStyle: textStyle,
                              icon: Icons.mail_outline,
                              iconColor: Colors.white,
                              bottomMargin: 20.0,
                              validateFunction: validations.validateEmail,
                              onSaved: (String email) {
                                user.email = email;
                              }),
                          new InputField(
                              hintText: "Password",
                              obscureText: true,
                              textInputType: TextInputType.text,
                              textStyle: textStyle,
                              icon: Icons.lock_open,
                              iconColor: Colors.white,
                              bottomMargin: 30.0,
                              validateFunction: validations.validatePassword,
                              onSaved: (String password) {
                                user.password = password;
                              }),
                          new RoundedButton(
                            buttonName: "Login",
                            onTap: () {
                              _handleSubmitted();
                            },
                            width: screenSize.width,
                            height: 50.0,
                            bottomMargin: 10.0,
                            borderWidth: 0.0,
                            buttonColor: primaryColor,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new TextButton(
                                  buttonName: "Create Account",
                                  onPressed: () => onPressed("/SignUp"),
                                  buttonTextStyle: buttonTextStyle),
                              new TextButton(
                                  buttonName: "Forgot Password?",
                                  onPressed: () => onPressed("/ForgotPassword"),
                                  buttonTextStyle: buttonTextStyle)
                            ],
                          ),
                          new Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 5.0, top: 10.0),
                                      child: new Container(
                                        alignment: Alignment.center,
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                            color: Color(0xFF4364A1),
                                            borderRadius:
                                                new BorderRadius.circular(9.0)),
                                        child: new Container(
                                          height: 60.0,
                                          width: 60.0,
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                new BorderRadius.circular(50.0),
                                          ),
                                          child: new IconButton(
                                              // Use the FontAwesomeIcons class for the IconData
                                              icon: new Icon(
                                                  FontAwesomeIcons.facebook),
                                              onPressed: () {
                                                print(
                                                    "enter email and password to login");
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 20.0, top: 10.0),
                                      child: new Container(
                                        alignment: Alignment.center,
                                        height: 60.0,
                                        decoration: new BoxDecoration(
                                            color: Color(0xFFDF513B),
                                            borderRadius:
                                                new BorderRadius.circular(9.0)),
                                        child: new IconButton(
                                            // Use the FontAwesomeIcons class for the IconData
                                            icon: new Icon(
                                                FontAwesomeIcons.google),
                                            onPressed: () {
                                              print(
                                                  "enter email and password to login");
                                            }),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
