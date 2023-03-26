import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/auth_methods.dart';
import 'package:flutter_instagram_clone/responsive/responsive_screen_layout.dart';
import 'package:flutter_instagram_clone/screens/signup_screen.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_instagram_clone/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/web_screen_layout.dart';

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
      if (context.mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout())));
      }

      //
    } else {
      if (context.mounted) {
        showSnackbar(res, context);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignupScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),
            SvgPicture.asset(
              "assets/instagram.svg",
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(
              height: 64,
            ),
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter your password',
              textInputType: TextInputType.phone,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Login in'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(child: Container(), flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text('Don\'t have an account?'),
                ),
                GestureDetector(
                  onTap: navigateToSignup,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
