import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';
import 'package:social_media_buttons/social_media_buttons.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool firstEyeClicked = false, secondEyeClicked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  _showSnackBar(String text, Color color) {
    //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),), elevation: 3, backgroundColor: color,));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Coming soon..',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      elevation: 3,
      backgroundColor: color,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF8185E2);
    final accentColor = Color(0xFF3C6ED0);
    final deviceWidth = MediaQuery.of(context).size.width > 1034
        ? 1034
        : MediaQuery.of(context).size.width < 862
            ? 862
            : MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    print(deviceHeight);
    print(deviceWidth);

    return Scaffold(
      key: _scaffoldKey,
      /*backgroundColor: primaryColor,*/
      body: Center(
        child:
            /*Container(
          height: 2320,
          width: 1080,
          child: */
            Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.topRight,
                      begin: Alignment.bottomLeft,
                      colors: [
                    Color(0xFF8185E2),
                    Color(0xFF28B8D5),
                  ])),
            )),
            Positioned(
                top: 70,
                child: Container(
                  height: 70,
                  width: /*deviceWidth<=1080?*/ deviceWidth * 0.25 /*:810*/,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                )),
            Positioned(
                top: 85,
                child: Container(
                  height: /*deviceHeight<=2280?*/ deviceHeight * .8 /*:1620*/,
                  width: /*deviceWidth<=1080?*/ deviceWidth * 0.3 /*:972*/,
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 45,
                            ),
                            Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: primaryColor),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: emailController,
                              style:
                                  TextStyle(color: accentColor, fontSize: 19),
                              decoration: InputDecoration(
                                hintText: 'Email Address',
                                hintStyle:
                                    TextStyle(color: accentColor, fontSize: 19),
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: primaryColor,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: accentColor.withOpacity(0.5)),
                                ),
                              ),
                              validator: (text) {
                                if (text.trim().isEmpty) return 'Required!';
                                if (!text.trim().contains('@') ||
                                    !text.trim().contains('.'))
                                  return 'This email is not valid!';
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: passwordController,
                              style:
                                  TextStyle(color: accentColor, fontSize: 19),
                              obscureText: !firstEyeClicked,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: accentColor, fontSize: 19),
                                  prefixIcon: Icon(Icons.lock_outline,
                                      color: primaryColor),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        firstEyeClicked = !firstEyeClicked;
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: firstEyeClicked
                                          ? primaryColor
                                          : accentColor.withOpacity(.5),
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: accentColor.withOpacity(.5)),
                                  )),
                              validator: (text) {
                                if (text.trim().isEmpty) return 'Required!';
                                if (text.length < 6)
                                  return 'Password must be 6 characters or more';
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                backgroundColor: primaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: deviceWidth * 0.1,
                                    vertical: 15),
                              ),
                              onPressed: () {
                                if (!_formKey.currentState.validate()) return;
                                AppBloc.authenticationBloc.add(OnAuthLogin(
                                    emailController.text,
                                    passwordController.text));
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Or using social media',
                              style: TextStyle(color: primaryColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[800]),
                                    child: SocialMediaButton.facebook(
                                      url: null,
                                      onTap: () => _showSnackBar(
                                          'Facebook', Colors.blue[800]),
                                      color: Colors.white,
                                      size: 15,
                                    )),
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[200]),
                                    child: SocialMediaButton.twitter(
                                      url: null,
                                      onTap: () => _showSnackBar(
                                          'Twitter', Colors.blue[200]),
                                      color: Colors.white,
                                      size: 15,
                                    )),
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red[400]),
                                    child: SocialMediaButton.google(
                                      url: null,
                                      onTap: () => _showSnackBar(
                                          'Google', Colors.red[400]),
                                      color: Colors.white,
                                      size: 15,
                                    )),
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue[500]),
                                    child: SocialMediaButton.linkedin(
                                      url: null,
                                      onTap: () => _showSnackBar(
                                          'Linked In', Colors.blue[500]),
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                      color: primaryColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => AppBloc.authScreensBloc
                                        .add(OnAuthScreensRegister()),
                                    child: Text(
                                      '  Sign Up',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'You can try it',
                                    style: TextStyle(
                                      color: primaryColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => AppBloc.authenticationBloc
                                        .add(OnAuthAnonymous()),
                                    child: Text(
                                      '  Try now',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            /*Positioned(
                bottom: 110,
                child: Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () =>
                            AppBloc.authScreensBloc.add(
                                OnAuthScreensRegister()),
                        child: Text(
                          '  Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )),*/
            /*Positioned(
                bottom: 50,
                child: Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'You can try it',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () =>
                            AppBloc.authenticationBloc.add(OnAuthAnonymous()),
                        child: Text(
                          '  Try now',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ))*/
          ],
        ),
        /*),*/
      ),
    );
  }
}
