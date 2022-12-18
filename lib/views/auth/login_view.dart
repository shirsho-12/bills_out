import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_out/services/auth/auth_exceptions.dart';
import 'package:bills_out/services/auth/auth_service.dart';
import 'package:bills_out/services/auth/bloc/auth_bloc.dart';
import 'package:bills_out/services/auth/bloc/auth_event.dart';
import 'package:bills_out/services/auth/bloc/auth_state.dart';

import '../../utilities/dialog/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  final AuthService authService = AuthService.firebase();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
                context, "Cannot find a user with the given credentials");
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, "Wrong credentials");
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, "Authentication Error");
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 3.5,
                child: Image.asset('assets/images/logo_no_caption.PNG'),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              // color: Colors.black,
                            ),
                            child: TextField(
                              controller: _email,
                              // style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  // color: Colors.white,
                                ),
                                hintText: 'Email',
                                // hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Password',
                            style: TextStyle(
                              // color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              // color: Colors.black,
                            ),
                            child: TextField(
                              controller: _password,
                              // style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  // color: Colors.white,
                                ),
                                hintText: 'Password',
                                // hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          ElevatedButton(
                            onPressed: () async {
                              final email = _email.text;
                              final password = _password.text;
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEventLogIn(email, password));
                            },
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  ' Log In',
                                  style: TextStyle(
                                    // color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          const Center(
                            child: Text(
                              '- Or Sign In with -',
                              style: TextStyle(
                                // color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(const AuthEventGoogleSignIn());
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    // color: Colors.white38,
                                  ),
                                  child:
                                      Image.asset('assets/images/google.png'),
                                ),
                              ),
                              // const SizedBox(width: 50),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(context,
                              //         MaterialPageRoute(
                              //             builder: (context) => SecondScreen()));
                              //   },
                              //   child: Container(
                              //     width: 60,
                              //     height: 60,
                              //     padding: const EdgeInsets.all(5),
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(15),
                              //       color: Colors.white38,
                              //     ),
                              //     child: Image.asset('lib/images/facebook.png'),
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Register here!",
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // devtools.log("Register here!");
                                        context.read<AuthBloc>().add(
                                            const AuthEventShouldRegister());
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Forgot your password? ",
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Reset here!",
                                    style: const TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // devtools.log("Register here!");
                                        context.read<AuthBloc>().add(
                                            const AuthEventForgotPassword());
                                      },
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
              )
            ],
          ),
        ),
      ),
      // child: Scaffold(
      //   // backgroundColor: SokyoColors.p2,
      //   appBar: AppBar(
      //     title: const Text("CodeXeR"),
      //     centerTitle: true,
      //   ),
      //   body: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         const Image(
      //           image: AssetImage('assets/images/logo.PNG'),
      //           height: 300,
      //         ),
      //         // const SizedBox(height: 10.0),

      //         // const SizedBox(height: 15.0),
      //         TextButton(
      //           onPressed: () {
      //             context.read<AuthBloc>().add(const AuthEventGoogleSignIn());
      //           },
      //           style: TextButton.styleFrom(
      //             // backgroundColor: SokyoColors.p2,
      //             shadowColor: Colors.black,
      //             padding: const EdgeInsets.symmetric(
      //               vertical: 20,
      //               horizontal: 10,
      //             ),
      //             shape: const ContinuousRectangleBorder(
      //               side: BorderSide(
      //                   color: Colors.grey, width: 1, style: BorderStyle.solid),
      //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
      //             ),
      //           ),
      //           child: Row(
      //             mainAxisSize: MainAxisSize.min,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Image.asset(
      //                 'assets/images/google.png',
      //                 height: 30,
      //               ),
      //               const SizedBox(width: 8),
      //               const Text(
      //                 'Continue with Google',
      //               ),
      //             ],
      //           ),
      //         ),
      //         const SizedBox(height: 10),
      //         Row(
      //           children: [
      //             Expanded(
      //                 child: Container(
      //               margin: const EdgeInsets.only(left: 10.0, right: 20.0),
      //               child: const Divider(
      //                 color: Colors.grey,
      //                 height: 40,
      //               ),
      //             )),
      //             const Text(
      //               "OR",
      //               // style: TextStyle(color: Colors.white),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: const EdgeInsets.only(left: 20.0, right: 10.0),
      //                   child: const Divider(
      //                     color: Colors.grey,
      //                     height: 40,
      //                   )),
      //             ),
      //           ],
      //         ),
      //         const SizedBox(height: 10.0),
      //         Container(
      //           decoration: BoxDecoration(
      //             border: Border.all(color: Colors.grey),
      //             borderRadius: BorderRadius.circular(5.0),
      //           ),
      //           child: TextField(
      //             controller: _email,
      //             autocorrect: false,
      //             keyboardType: TextInputType.emailAddress,
      //             decoration: const InputDecoration(
      //               hintText: "Email",
      //               prefixIcon: Icon(Icons.email),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16.0),
      //         Container(
      //           decoration: BoxDecoration(
      //             border: Border.all(color: Colors.grey),
      //             borderRadius: BorderRadius.circular(5.0),
      //           ),
      //           child: TextField(
      //             controller: _password,
      //             obscureText: true,
      //             enableSuggestions: false,
      //             autocorrect: false,
      //             decoration: const InputDecoration(
      //               hintText: "Password",
      //               prefixIcon: Icon(Icons.lock),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16.0),
      //         ElevatedButton(
      //           onPressed: () async {
      //             final email = _email.text;
      //             final password = _password.text;
      //             context.read<AuthBloc>().add(AuthEventLogIn(email, password));
      //           },
      //           child: const Text("Login"),
      //         ),
      //         const SizedBox(height: 16.0),
      //         RichText(
      //           textAlign: TextAlign.center,
      //           text: TextSpan(
      //             text: "Don't have an account? ",
      //             // style: const TextStyle(color: Colors.black),
      //             children: [
      //               TextSpan(
      //                 text: "Register here!",
      //                 style: const TextStyle(color: Colors.blue),
      //                 recognizer: TapGestureRecognizer()
      //                   ..onTap = () {
      //                     // devtools.log("Register here!");
      //                     context
      //                         .read<AuthBloc>()
      //                         .add(const AuthEventShouldRegister());
      //                   },
      //               ),
      //             ],
      //           ),
      //         ),
      //         const SizedBox(height: 16.0),
      //         RichText(
      //           textAlign: TextAlign.center,
      //           text: TextSpan(
      //             text: "Forgot your password? ",
      //             // style: const TextStyle(color: Colors.black),
      //             children: [
      //               TextSpan(
      //                 text: "Reset here!",
      //                 style: const TextStyle(color: Colors.blue),
      //                 recognizer: TapGestureRecognizer()
      //                   ..onTap = () {
      //                     // devtools.log("Register here!");
      //                     context
      //                         .read<AuthBloc>()
      //                         .add(const AuthEventForgotPassword());
      //                   },
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
