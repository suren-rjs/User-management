import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/app_constants/app_colors.dart';
import 'package:user_management/controllers/auth_controller.dart';
import 'package:user_management/data_models/login.dart';
import 'package:user_management/in_app_storage/secure_storage.dart';
import 'package:user_management/screens/auth_screens/common_widgets/auth_page_image.dart';
import 'package:user_management/screens/auth_screens/common_widgets/custom_action_button.dart';
import 'package:user_management/screens/auth_screens/common_widgets/page_identifier_text.dart';
import 'package:user_management/screens/auth_screens/common_widgets/text_field_container.dart';
import 'package:user_management/screens/auth_screens/signup_page.dart';
import 'package:user_management/screens/home_screen/admin_page.dart';
import 'package:user_management/screens/home_screen/user_details_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController contactController;
  late TextEditingController passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().logOut();
    contactController = TextEditingController();
    passwordController = TextEditingController();
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GetBuilder<AuthController>(
              builder: (controller) => Stack(
                fit: StackFit.passthrough,
                children: [
                  PageIdentifierText(
                    contextSize: contextSize,
                    isPortrait: orientation == Orientation.portrait,
                    text: "Login",
                  ),
                  AuthPageImage(
                    contextSize: contextSize,
                    isPortrait: orientation == Orientation.portrait,
                    isLoginPage: true,
                  ),
                  Positioned(
                    bottom: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.03
                        : MediaQuery.of(context).size.height * 0.2,
                    right: orientation == Orientation.portrait
                        ? 0
                        : MediaQuery.of(context).size.width * -0.06,
                    left: orientation == Orientation.portrait ? 0 : null,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldContainer(
                            textController: contactController,
                            hintText: 'Email or Phone',
                            fieldType: TextInputFieldType.username,
                            isPortrait: orientation == Orientation.portrait,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015),
                          TextFieldContainer(
                            textController: passwordController,
                            hintText: 'Password',
                            fieldType: TextInputFieldType.password,
                            isPortrait: orientation == Orientation.portrait,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: contextSize.width * 0.02,
                              left: orientation == Orientation.portrait
                                  ? contextSize.width * 0.68
                                  : contextSize.width * 0.3,
                              bottom: contextSize.width * 0.02,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'New user ? ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: appColors.textGrey,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const SignUpPage());
                                  },
                                  child: Text(
                                    ' Signup',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: appColors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomActionButton(
                            contextSize: contextSize,
                            isPortrait: orientation == Orientation.portrait,
                            buttonText: "Login",
                            function: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing ...'),
                                  ),
                                );
                                if (contactController.text == 'Admin' &&
                                    passwordController.text == '0000') {
                                  contactController = TextEditingController();
                                  passwordController = TextEditingController();
                                  secureStorage.add('isAdmin', '1').then(
                                      (value) =>
                                          Get.to(() => const AdminPage()));
                                } else {
                                  controller
                                      .signIn(Login(
                                    username: contactController.text,
                                    password: passwordController.text,
                                  ))
                                      .then((value) {
                                    if (value) {
                                      contactController = TextEditingController();
                                      passwordController = TextEditingController();
                                      Get.to(() => UserDetails());
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Contact admin support'),
                                        ),
                                      );
                                    }
                                  });
                                }
                              }
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
