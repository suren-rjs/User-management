import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_management/app_constants/app_colors.dart';
import 'package:user_management/screens/home_screen/user_details_page.dart';

class UserAvatarImage extends StatefulWidget {
  const UserAvatarImage({
    super.key,
    required this.isPortrait,
    required this.isEditable,
    required this.imagePathController,
  });

  final bool isPortrait;
  final bool isEditable;
  final TextEditingController imagePathController;

  @override
  State<StatefulWidget> createState() => _UserAvatarImageState();
}

class _UserAvatarImageState extends State<UserAvatarImage> {
  final picker = ImagePicker();
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.imagePathController.text.isEmpty) {
      widget.imagePathController.text = selectedImageForUpload;
    }
    _imageFile = XFile(widget.imagePathController.text);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        widget.imagePathController.text = pickedFile.path;
        selectedImageForUpload = pickedFile.path;
        _imageFile = XFile(widget.imagePathController.text);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var contextSize = MediaQuery.of(context).size;
    return Positioned(
      top: widget.isPortrait
          ? MediaQuery.of(context).size.height * 0.175
          : MediaQuery.of(context).size.height * 0.2,
      left: widget.isPortrait
          ? MediaQuery.of(context).size.width * 0.1
          : MediaQuery.of(context).size.width * 0.1,
      right: widget.isPortrait ? MediaQuery.of(context).size.width * 0.1 : null,
      child: Column(
        children: [
          Container(
            width: widget.isPortrait
                ? contextSize.width * 0.6
                : contextSize.width * 0.25,
            height: widget.isPortrait
                ? contextSize.height * 0.25
                : contextSize.height * 0.65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: widget.imagePathController.text.isEmpty
                    ? const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_QsvGMmS56m4vMND5RkPibQu5McrpfQMI-w&usqp=CAU')
                    : FileImage(File(widget.imagePathController.text))
                        as ImageProvider,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: widget.isPortrait ? contextSize.width * 0.05 : 0,
              left: widget.isPortrait
                  ? contextSize.width * 0.225
                  : contextSize.width * 0,
              bottom: widget.isPortrait ? contextSize.width * 0.02 : 0,
            ),
            child: widget.isEditable
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _selectImage();
                        },
                        child: Text(
                          'Upload profile picture',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: appColors.textGreyDark,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
