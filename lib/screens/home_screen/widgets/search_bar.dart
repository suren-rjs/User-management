import 'package:flutter/material.dart';
import 'package:user_management/app_constants/app_colors.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onTextChanged;
  final String placeHolder;

  const SearchBox(
      {super.key, required this.onTextChanged, required this.placeHolder});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: appColors.textGreyDark,
        style: BorderStyle.solid,
      ),
    );
    return TextField(
      controller: _textEditingController,
      style: TextStyle(
        color: appColors.textGreyDark,
      ),
      decoration: InputDecoration(
        fillColor: appColors.textGreyDark,
        iconColor: appColors.textGreyDark,
        focusColor: appColors.textGreyDark,
        hintText: widget.placeHolder,
        hintStyle: TextStyle(
          color: appColors.textGreyDark,
          overflow: TextOverflow.ellipsis,
          fontSize: 20,
        ),
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.clear,
            color: appColors.textGreyDark,
          ),
          onPressed: () {
            _textEditingController.clear();
            widget.onTextChanged('');
          },
        ),
      ),
      onChanged: (value) {
        widget.onTextChanged(value);
      },
      cursorColor: appColors.textGreyDark,
    );
  }
}
