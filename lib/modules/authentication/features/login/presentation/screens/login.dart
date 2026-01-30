import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/modules/authentication/features/signup/presentation/screens/signup.dart';
import 'package:main_cartify/modules/commons/bottom_navbar_widget/bottom_nav.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/firebase_auth_service.dart';
import 'package:main_cartify/utils/app_colors.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _confirmVisible = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.sizeOf(context).width / 30;
    final double inputBarLength = MediaQuery.sizeOf(context).width / 70;
    final double emailAndPasswordIconSize =
        MediaQuery.sizeOf(context).width / 20;

    final authProvider = context.watch<FirebaseAuthServiceProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Login to Your Account',
                    style: TextStyle(
                      fontSize: Dimension.xsmallSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// EMAIL
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.email_outlined, size: emailAndPasswordIconSize),
                        const SizedBox(width: 10),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: inputBarLength),
                    width: ScreenUtil().setWidth(350),
                    margin: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _email,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Email Required' : null,
                      decoration: InputDecoration(
                        hintText: 'user@gmail.com',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  /// PASSWORD
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline, size: emailAndPasswordIconSize),
                        const SizedBox(width: 10),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: inputBarLength),
                        width: ScreenUtil().setWidth(350),
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _password,
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Password Required' : null,
                          obscureText: _confirmVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 22,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _confirmVisible = !_confirmVisible;
                            });
                          },
                          child: Icon(
                            _confirmVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                                 size: Dimension.mmediumsize,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: ScreenUtil().setWidth(330),
                    margin: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: AppColors.brandColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      onPressed:
                          authProvider.authState == AuthDataState.loading
                              ? null
                              : () async {
                                  if (!_formKey.currentState!.validate()) return;

                                  final user = await authProvider.signIn(
                                    _email.text.trim(),
                                    _password.text.trim(),
                                  );

                                  if (user != null && mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const BottomNav(),
                                      ),
                                    );
                                  }
                                },
                      child: authProvider.authState == AuthDataState.loading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Log In',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: Dimension.msmall,
                              ),
                            ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Or Continue with',
                      style: TextStyle(fontSize: Dimension.mxssmall),
                    ),
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
                              color: const Color(0xFFCCCCCC),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset('assets/svg/facebook.svg'),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(204, 204, 204, 1),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset('assets/svg/google.svg'),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(204, 204, 204, 1),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset('assets/svg/apple.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 145),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const Signup()),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(color: AppColors.brandColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
