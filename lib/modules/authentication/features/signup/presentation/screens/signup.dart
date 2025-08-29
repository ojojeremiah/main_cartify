import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_cartify/modules/authentication/features/login/presentation/screens/login.dart';
import 'package:main_cartify/utils/app_colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _confirmVisible = true;
  bool task = false;

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.sizeOf(context).width / 26;
    double inputBarLength = MediaQuery.sizeOf(context).width / 70;
    double emailAndPasswordIconSize = MediaQuery.sizeOf(context).width / 16;

    // final userNotifier = context.watch<UserNotifier>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Create an Account",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // Email field
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined,
                              size: emailAndPasswordIconSize),
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text("Email",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize)))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: inputBarLength, right: inputBarLength),
                      width: ScreenUtil().setWidth(350),
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        key: const Key('emailField'),
                        controller: _email,
                        validator: (v) =>
                            v!.isEmpty ? "Email Required" : null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'user@gmail.com',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    // Password field
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: Row(
                        children: [
                          Icon(Icons.lock_outline,
                              size: emailAndPasswordIconSize),
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize),
                              ))
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: inputBarLength, right: inputBarLength),
                          width: ScreenUtil().setWidth(350),
                          margin: const EdgeInsets.only(top: 10, left: 5),
                          child: TextFormField(
                            key: const Key('passwordField'),
                            controller: _password,
                            validator: (v) =>
                                v!.isEmpty ? "Password Required" : null,
                            obscureText: _confirmVisible,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Password',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 15,
                          top: 18,
                          child: GestureDetector(
                             key: const Key('togglePasswordVisibility'),
                            onTap: () {
                              setState(() {
                                _confirmVisible = !_confirmVisible;
                              });
                            },
                            child: Icon(
                              _confirmVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Login button
                    Container(
                      width: ScreenUtil().setWidth(330),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          color: AppColors.brandColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                        onPressed: 
                            ()  {
                              if (!_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (_email.text.isEmpty ||
                                    _password.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Fill Required fields')));
                                }
                                //  Get.to( AccountValidation());
                              } else {
  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(builder: (_) => LoginPage()),
  // );
}

                            },
                        child: const Text(
                                "Sign up",
                                style: TextStyle(
                                    color: AppColors.whiteColor, fontSize: 18),
                              ),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "Or Continue with",
                        style: TextStyle(fontSize: 18),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        const Color.fromRGBO(204, 204, 204, 1)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                    "assets/svg/facebook.svg")),
                          ),
                          Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        const Color.fromRGBO(204, 204, 204, 1)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                    "assets/svg/google.svg")),
                          ),
                          Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color:
                                        const Color.fromRGBO(204, 204, 204, 1)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                    "assets/svg/apple.svg")),
                          ),
                        ],
                      ),
                    ),
                     Container(
                      margin: const EdgeInsets.only(top: 145),
                      child: Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 85),
                              child: const Text("Don't have an account?")),
                          TextButton(
                              onPressed: () {
                                  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => LoginPage()),
  );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: AppColors.brandColor),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
