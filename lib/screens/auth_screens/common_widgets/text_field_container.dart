import 'package:flutter/material.dart';
import 'package:user_management/app_constants/app_colors.dart';

enum TextInputFieldType { username, contact, password }

class TextFieldContainer extends StatefulWidget {
  TextFieldContainer({
    super.key,
    required this.textController,
    required this.hintText,
    required this.fieldType,
    required this.isPortrait,
    this.isReadOnly = false,
    this.function,
  });

  final TextEditingController textController;
  final String hintText;
  final TextInputFieldType fieldType;
  final bool isPortrait;
  bool isReadOnly;
  Function()? function;

  @override
  State<StatefulWidget> createState() => _TextFieldContainer();
}

class _TextFieldContainer extends State<TextFieldContainer> {
  bool isHiddenPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contextSize = MediaQuery.of(context).size;
    var contextRatio = contextSize.aspectRatio;
    bool isPassword = widget.fieldType == TextInputFieldType.password;
    return Container(
      height: widget.isPortrait
          ? contextSize.height * 0.07
          : contextSize.height * 0.15,
      width: widget.isPortrait
          ? contextSize.width * 0.9
          : contextSize.width * 0.45,
      margin: EdgeInsets.only(
        left: contextRatio * 50,
        right: contextRatio * 50,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: appColors.white,
      ),
      child: Center(
        child: TextFormField(
          style: TextStyle(color: appColors.red),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter ${widget.hintText}';
            }
            print(widget.function==null);
            if (widget.function != null) return (widget.function)!();
            return null;
          },
          readOnly: widget.isReadOnly,
          obscureText: isPassword && isHiddenPassword,
          controller: widget.textController,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: widget.isPortrait ? contextRatio * 50 : contextRatio * 10,
                right:
                    widget.isPortrait ? contextRatio * 50 : contextRatio * 10,
                bottom:
                    widget.isPortrait ? contextRatio * 10 : contextRatio * 10,
                top: widget.isPortrait ? contextRatio * 10 : contextRatio * 10,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 16,
                color: appColors.hintText,
                fontWeight: FontWeight.w400,
              ),
              suffix: isPassword && !widget.isReadOnly
                  ? Container(
                      padding: EdgeInsets.zero,
                      child: InkWell(
                        onTap: () {
                          isHiddenPassword = !isHiddenPassword;
                          setState(() {});
                        },
                        child: Icon(
                          isHiddenPassword
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          color: appColors.red,
                        ),
                      ),
                    )
                  : null),
        ),
      ),
    );
  }
}
