import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_cartify/dimension/dimension.dart';
import 'package:main_cartify/modules/authentication/features/login/presentation/screens/login.dart';
import 'package:main_cartify/presentation/presentation_logic/provider/firebase_auth_service.dart';
import 'package:main_cartify/utils/app_colors.dart';
import 'package:main_cartify/utils/context_extension.dart';
import 'package:provider/provider.dart';

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

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<FirebaseAuthServiceProvider>();

    final double fontSize = MediaQuery.sizeOf(context).width / 30;
    final double inputBarLength = MediaQuery.sizeOf(context).width / 70;
    final double iconSize = MediaQuery.sizeOf(context).width / 20;

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
                    'Create an Account',
                    style: TextStyle(
                      fontSize: Dimension.xsmallSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  _label(Icons.email_outlined, context.l10n.email, iconSize, fontSize),
                  _inputField(
                    controller: _email,
                    hint: 'user@gmail.com',
                    padding: inputBarLength,
                    validator: (v) => v!.isEmpty ? context.l10n.emailRequired : null,
                  ),

                  _label(Icons.lock_outline, context.l10n.password, iconSize, fontSize),
                  Stack(
                    children: [
                      _inputField(
                        controller: _password,
                        hint: 'Password',
                        padding: inputBarLength,
                        obscure: _confirmVisible,
                        validator: (v) => v!.isEmpty ? context.l10n.passwordRequired : null,
                      ),
                      Positioned(
                        right: 15,
                        top: 22,
                        child: GestureDetector(
                          onTap: () => setState(
                            () => _confirmVisible = !_confirmVisible,
                          ),
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
                    decoration: BoxDecoration(
                      color: AppColors.brandColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: auth.authState == AuthDataState.loading
                          ? null
                          : () async {
                              if (!_formKey.currentState!.validate()) return;

                              await auth.signUp(
                                _email.text.trim(),
                                _password.text.trim(),
                              );

                              if (auth.authState == AuthDataState.success) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginPage(),
                                  ),
                                );
                              }
                            },
                      child: auth.authState == AuthDataState.loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Sign up',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: Dimension.msmall,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Or Continue with',
                    style: TextStyle(fontSize: Dimension.mxssmall),
                  ),

                  const SizedBox(height: 10),

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

                  const SizedBox(height: 80),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginPage()),
                          );
                        },
                        child: Text(
                          context.l10n.login,
                          style: TextStyle(color: AppColors.brandColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(IconData icon, String text, double iconSize, double fontSize) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          Icon(icon, size: iconSize),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required double padding,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      width: ScreenUtil().setWidth(350),
      margin: const EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
