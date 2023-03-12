import 'package:flutter/material.dart';
import 'package:user_management/app_constants/app_colors.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.contextSize,
    required this.isPortrait,
    required this.buttonText,
    required this.function,
    this.color,
  });

  final Size contextSize;
  final bool isPortrait;
  final String buttonText;
  final Function()? function;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          isPortrait ? contextSize.height * 0.06 : contextSize.height * 0.1,
      width: isPortrait ? contextSize.width * 0.9 : contextSize.width * 0.45,
      margin: EdgeInsets.only(
        left: contextSize.aspectRatio * 50,
        right: contextSize.aspectRatio * 50,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: appColors.white,
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: function,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(appColors.red),
            foregroundColor: MaterialStateProperty.all<Color>(appColors.white),
          ),
          child: SizedBox(
            width: contextSize.width,
            child: Center(
              child: Text(
                buttonText.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: appColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
