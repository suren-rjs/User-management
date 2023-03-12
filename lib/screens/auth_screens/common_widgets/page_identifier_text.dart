import 'package:flutter/material.dart';
import 'package:user_management/app_constants/app_colors.dart';

class PageIdentifierText extends StatelessWidget {
  const PageIdentifierText({
    super.key,
    required this.contextSize,
    required this.isPortrait,
    required this.text,
  });

  final Size contextSize;
  final bool isPortrait;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isPortrait
          ? MediaQuery.of(context).size.height * 0.1
          : MediaQuery.of(context).size.height * 0.15,
      left: isPortrait ? 0 : MediaQuery.of(context).size.height * -0.1,
      right: isPortrait ? MediaQuery.of(context).size.height * 0.2 : null,
      child: Container(
        padding: EdgeInsets.only(
          left: contextSize.aspectRatio * 50,
          right: contextSize.aspectRatio * 50,
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            color: appColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
