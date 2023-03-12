import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/app_constants/app_colors.dart';
import 'package:user_management/controllers/users_controller.dart';
import 'package:user_management/data_models/user.dart';
import 'package:user_management/screens/home_screen/user_details_page.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.isPortrait, required this.user});

  final bool isPortrait;
  final User user;

  @override
  Widget build(BuildContext context) {
    var contextSize = MediaQuery.of(context).size;
    String defaultImageUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_QsvGMmS56m4vMND5RkPibQu5McrpfQMI-w&usqp=CAU';
    return Container(
      height: contextSize.height * 0.4,
      width: contextSize.height * 0.2,
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26, blurRadius: 7.0, offset: Offset(0.0, 0.7))
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: appColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: isPortrait
                      ? contextSize.width * 0.025
                      : contextSize.width * 0.0075),
              Container(
                width: isPortrait
                    ? contextSize.width * 0.2
                    : contextSize.width * 0.05,
                height: isPortrait
                    ? contextSize.height * 0.1
                    : contextSize.height * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: user.profileImgUrl == null
                        ? NetworkImage(defaultImageUrl)
                        : FileImage(File('${user.profileImgUrl}'))
                            as ImageProvider,
                  ),
                ),
              ),
              SizedBox(
                  height: isPortrait
                      ? contextSize.width * 0.025
                      : contextSize.width * 0.0075),
              RichText(
                overflow: TextOverflow.clip,
                textAlign: TextAlign.end,
                textDirection: TextDirection.ltr,
                softWrap: true,
                maxLines: 1,
                textScaleFactor: 1,
                text: TextSpan(
                  text: 'User name : ',
                  style: TextStyle(
                    fontSize: 12,
                    color: appColors.textGreyDark,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: user.username,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: appColors.textGreyDark,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: isPortrait
                      ? contextSize.width * 0.025
                      : contextSize.width * 0.005),
              RichText(
                overflow: TextOverflow.clip,
                textAlign: TextAlign.end,
                textDirection: TextDirection.ltr,
                softWrap: true,
                maxLines: 1,
                textScaleFactor: 1,
                text: TextSpan(
                  text: 'Contact : ',
                  style: TextStyle(
                    fontSize: 12,
                    color: appColors.textGreyDark,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: user.contact,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: appColors.textGreyDark,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: isPortrait
                      ? contextSize.width * 0.025
                      : contextSize.width * 0.005),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: appColors.yellow),
                    ),
                    padding: const EdgeInsets.all(10),
                    fixedSize: isPortrait
                        ? Size(contextSize.width, contextSize.height * 0.05)
                        : Size(contextSize.width, contextSize.height * 0.1),
                  ),
                  onPressed: () {
                    Get.find<UsersController>()
                        .getUserDetails(user.id)
                        .then((value) => Get.to(() => UserDetails(
                              user: value,
                              isAdmin: true,
                            )));
                  },
                  child: Center(
                    child: Text(
                      'User details',
                      style: TextStyle(
                        fontSize: 14,
                        color: appColors.textGreyDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
