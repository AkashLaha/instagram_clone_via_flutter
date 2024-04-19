import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/Screens/sign_up_screen.dart';
import 'package:insta_clone/reponsive/mobile_screen_layout.dart';
import 'package:insta_clone/reponsive/responsive_layout_screen.dart';
import 'package:insta_clone/reponsive/web_screen_layout.dart';
import 'package:insta_clone/resources/auth_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout());
          },
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const SignUpScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //svg img
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                height: 64,
              ),
              SizedBox(
                height: 64,
              ),
              //textfield for email
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your emial',
                  textInputType: TextInputType.emailAddress),
              SizedBox(
                height: 24,
              ),
              //textfield for password
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              SizedBox(
                height: 24,
              ),
              //textbutton
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        )
                      : const Text('Login'),
                  padding: EdgeInsets.only(top: 12, bottom: 15),
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //Transitioning to sign up
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Don't have an account?"),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: navigateToSignup,
                      child: Container(
                        child: Text(
                          ' Sign Up.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
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
