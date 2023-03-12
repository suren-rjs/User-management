import 'package:flutter/material.dart';

class CustomProfileActionButton extends StatelessWidget {
  const CustomProfileActionButton({
    super.key,
    required this.buttonStyle,
    required this.function,
    required this.icon,
    required this.text,
  });

  final ButtonStyle buttonStyle;
  final Function() function;
  final Text text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        onPressed: function,
        style: buttonStyle,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              child: icon,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: text,
            ),
          ],
        ),
      ),
    );
  }
}
