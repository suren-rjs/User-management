import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/app_constants/app_colors.dart';
import 'package:user_management/controllers/auth_controller.dart';
import 'package:user_management/data_models/user.dart';
import 'package:user_management/screens/auth_screens/common_widgets/auth_page_image.dart';
import 'package:user_management/screens/auth_screens/common_widgets/custom_action_button.dart';
import 'package:user_management/screens/auth_screens/common_widgets/page_identifier_text.dart';
import 'package:user_management/screens/auth_screens/common_widgets/text_field_container.dart';
import 'package:user_management/screens/auth_screens/login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController nameController;
  late TextEditingController contactController;
  late TextEditingController passwordController;
  late TextEditingController passwordController1;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    contactController = TextEditingController();
    passwordController = TextEditingController();
    passwordController1 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
                    text: "Signup",
                  ),
                  AuthPageImage(
                    contextSize: contextSize,
                    isPortrait: orientation == Orientation.portrait,
                    isLoginPage: false,
                  ),
                  Positioned(
                    bottom: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.015
                        : MediaQuery.of(context).size.height * 0.05,
                    right: orientation == Orientation.portrait
                        ? 0
                        : MediaQuery.of(context).size.width * -0.06,
                    left: orientation == Orientation.portrait ? 0 : null,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldContainer(
                            textController: nameController,
                            hintText: 'User name',
                            fieldType: TextInputFieldType.username,
                            isPortrait: orientation == Orientation.portrait,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015),
                          TextFieldContainer(
                            textController: contactController,
                            hintText: 'Phone or Email',
                            fieldType: TextInputFieldType.contact,
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
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015),
                          TextFieldContainer(
                            textController: passwordController1,
                            hintText: 'Re type password',
                            fieldType: TextInputFieldType.password,
                            isPortrait: orientation == Orientation.portrait,
                            function: () {
                              if (passwordController.text !=
                                  passwordController1.text) {
                                return 'password mismatch';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          CustomActionButton(
                            contextSize: contextSize,
                            isPortrait: orientation == Orientation.portrait,
                            buttonText: "Sign up",
                            function: () async {
                              Navigator.of(context).canPop();
                              if (_formKey.currentState!.validate()) {
                                controller
                                    .signUp(
                                  User(
                                    username: nameController.text,
                                    password: passwordController.text,
                                    contact: contactController.text,
                                  ),
                                )
                                    .then(
                                  (value) {
                                    if (value) {
                                      nameController = TextEditingController();
                                      contactController = TextEditingController();
                                      passwordController = TextEditingController();
                                      passwordController1 = TextEditingController();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Try Login ...'),
                                        ),
                                      );
                                      Get.to(() => const LoginPage());
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Contact admin support'),
                                        ),
                                      );
                                    }
                                  },
                                );
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
