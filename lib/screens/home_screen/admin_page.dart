import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/app_constants/app_colors.dart';
import 'package:user_management/controllers/users_controller.dart';
import 'package:user_management/screens/auth_screens/common_widgets/page_identifier_text.dart';
import 'package:user_management/screens/home_screen/widgets/all_users.dart';
import 'package:user_management/screens/home_screen/widgets/search_bar.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var contextSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appColors.background,
      body: OrientationBuilder(
        builder: (context, orientation) => SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: contextSize.height,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                PageIdentifierText(
                  contextSize: contextSize,
                  isPortrait: orientation == Orientation.portrait,
                  text: "Admin",
                ),
                Positioned(
                  top: orientation == Orientation.portrait ? contextSize.height * 0.14 : contextSize.height * 0.125,
                  left:  orientation == Orientation.portrait ? contextSize.width * 0.1 : contextSize.width * 0.2,
                  right: orientation == Orientation.portrait ? contextSize.width * 0.1 : contextSize.width * 0.2,
                  child: SearchBox(
                    onTextChanged: (String searchText) {
                      if(searchText.isNotEmpty){
                        Get.find<UsersController>().search(searchText);
                      } else{
                        Get.find<UsersController>().getAllUsers();
                      }
                    },
                    placeHolder: 'Search Email, phone, name',
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: orientation == Orientation.portrait
                        ? contextSize.height * 0.22
                        : contextSize.height * 0.275,
                    left: orientation == Orientation.portrait
                        ? contextSize.height * 0.01
                        : contextSize.height * 0.075,
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: orientation == Orientation.portrait
                                  ? contextSize.width * 0.05
                                  : contextSize.width * 0.015),
                          child: Text(
                            'All Users',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: appColors.textGreyDark,
                            ),
                          ),
                        ),
                        AllUsers(
                          isPortrait: orientation == Orientation.portrait,
                          isActiveUsers: true,
                        ),
                        SizedBox(height: contextSize.height * 0.05),
                        Padding(
                          padding: EdgeInsets.only(
                              left: orientation == Orientation.portrait
                                  ? contextSize.width * 0.05
                                  : contextSize.width * 0.015),
                          child: Text(
                            'Removed Users',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: appColors.textGreyDark,
                            ),
                          ),
                        ),
                        AllUsers(
                          isPortrait: orientation == Orientation.portrait,
                          isActiveUsers: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
