import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelscape/screens/home_screen.dart';
import 'package:travelscape/widgets/auth.dart';
import 'package:travelscape/widgets/google_auth.dart';

// ignore: camel_case_types
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// ignore: camel_case_types
class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  String error = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoggingIn = false;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff7f5af0),
        body: Container(
          height: _height,
          width: _width,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/travelscape.svg",
                    height: _height * 250 / 744,
                  ),
                  Container(
                    width: _width,
                    height: _height * (685 - 250) / 685,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: Color(0xff16161a),
                    ),
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 38,
                    ),
                    margin: EdgeInsets.all(0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 313 / 375 * _width,
                          child: Text(
                            "Log In",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Color(0xfffffffe),
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.83 / 812 * _height),
                        Container(
                          width: 300,
                          height: 40,
                          child: TextField(
                            controller: emailController,
                            style: GoogleFonts.poppins(
                              color: Color(0xffd5d7d9),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            obscureText: false,
                            decoration: InputDecoration(
                              // errorText: error,
                              labelText: "Email",
                              labelStyle: GoogleFonts.poppins(
                                color: Color(0xffd5d7d9),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              fillColor: Color(0x3f000000),
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 21 / 812 * _height),
                        Container(
                          width: 300,
                          height: 40,
                          child: TextField(
                            controller: passwordController,
                            style: GoogleFonts.poppins(
                              color: Color(0xffd5d7d9),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              // errorText: error,
                              labelText: "Password",
                              labelStyle: GoogleFonts.poppins(
                                color: Color(0xffd5d7d9),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              fillColor: Color(0x3f000000),
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 21 / 812 * _height),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     error,
                        //     style: GoogleFonts.poppins(
                        //       color: Colors.red,
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () async {
                            try {
                              setState(() {
                                isLoggingIn = true;
                              });
                              dynamic result = await _auth.signIn(
                                  emailController.text,
                                  passwordController.text);
                              if (result == "Enter A Valid Email-Id") {
                                setState(() {
                                  error = "Enter a Stronger Password";
                                  isLoggingIn = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "$error",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ));
                                });
                              } else if (result == "Incorrect Password")
                                setState(() {
                                  error = "Incorrect Password";
                                  isLoggingIn = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "$error",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ));
                                });
                              else if (result == "User Not Found")
                                setState(() {
                                  error = "User Not Found";
                                  isLoggingIn = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "$error",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ));
                                });
                              else if (result == "User diasbled")
                                setState(() {
                                  error = "User diasbled";
                                  isLoggingIn = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "$error",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ));
                                });
                              else if (result == "Too many requests")
                                setState(() {
                                  error = "Too many requests";
                                  isLoggingIn = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "$error",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ));
                                });
                              else if (result == "Unknown error")
                                setState(() {
                                  error = "Unknown error";
                                  isLoggingIn = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "$error",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                  ));
                                });
                              else {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                    (route) => false);
                              }
                            } catch (e) {
                              print(e.toString());
                              setState(() {
                                error = e.toString();
                              });
                            }
                          },
                          child: isLoggingIn == false
                              ? Container(
                                  width: 150 / 375 * _width,
                                  height: 40 / 812 * _height,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 150 / 375 * _width,
                                        height: 40 / 812 * _height,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Color(0x3f000000),
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 13,
                                          top: 7,
                                          bottom: 10,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Log In",
                                              style: GoogleFonts.poppins(
                                                color: Color(0xfffffffe),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        SizedBox(height: 21 / 812 * _height),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color(0xfffffffe),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.google,
                                    size: 30,
                                    color: Color(0xff16161a),
                                  ),
                                ),
                                onTap: () {
                                  signInWithGoogle().then(
                                    (value) {
                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user != null) {
                                        Navigator.pushNamed(context, '/home');
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 21 / 812 * _height),
                        Container(
                          width: 331,
                          height: 2,
                          color: Color(0x7f94a1b2),
                        ),
                        SizedBox(height: 21 / 812 * _height),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/");
                          },
                          child: Text(
                            "Don't have an account? Create Account",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Color(0xfffffffe),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
