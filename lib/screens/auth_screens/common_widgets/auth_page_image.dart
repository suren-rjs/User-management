import 'package:flutter/material.dart';

class AuthPageImage extends StatelessWidget {
  const AuthPageImage({
    super.key,
    required this.contextSize,
    required this.isPortrait,
    required this.isLoginPage,
  });

  final Size contextSize;
  final bool isPortrait;
  final bool isLoginPage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isPortrait
          ? MediaQuery.of(context).size.height * 0.175
          : MediaQuery.of(context).size.height * 0.05,
      left: isPortrait
          ? MediaQuery.of(context).size.width * 0.1
          : MediaQuery.of(context).size.height * 0.05,
      right: isPortrait ? MediaQuery.of(context).size.width * 0.1 : null,
      child: Container(
        padding: EdgeInsets.all(contextSize.aspectRatio * 30),
        child: Center(
          child: Image.asset(
            isLoginPage
                ? 'assets/images/user_login.png'
                : 'assets/images/signup.png',
            width:
                isPortrait ? contextSize.width * 0.7 : contextSize.width * 0.25,
            height: isPortrait
                ? contextSize.height * 0.35
                : contextSize.height * 0.65,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
