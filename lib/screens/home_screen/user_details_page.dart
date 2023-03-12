import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/app_constants/app_colors.dart';
import 'package:user_management/controllers/auth_controller.dart';
import 'package:user_management/controllers/users_controller.dart';
import 'package:user_management/data_models/user.dart';
import 'package:user_management/screens/auth_screens/common_widgets/custom_action_button.dart';
import 'package:user_management/screens/auth_screens/common_widgets/page_identifier_text.dart';
import 'package:user_management/screens/auth_screens/common_widgets/text_field_container.dart';
import 'package:user_management/screens/auth_screens/common_widgets/user_avatar_image.dart';

class UserDetails extends StatefulWidget {
  UserDetails({super.key, this.user, this.isAdmin});

  final User? user;
  bool? isAdmin;

  @override
  _UserDetailsState createState() => _UserDetailsState();
}


class _UserDetailsState extends State<UserDetails> {
  bool isEditableForm = false;
  late TextEditingController nameController;
  late TextEditingController contactController;
  late TextEditingController passwordController;
  late TextEditingController passwordController1;
  TextEditingController imageUrlController =  TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    contactController = TextEditingController();
    passwordController = TextEditingController();
    passwordController1 = TextEditingController();
    imageUrlController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var contextSize = MediaQuery.of(context).size;
    String defaultImageUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_QsvGMmS56m4vMND5RkPibQu5McrpfQMI-w&usqp=CAU';
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appColors.background,
      body: OrientationBuilder(
        builder: (context, orientation) => SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GetBuilder<UsersController>(
              builder: (controller) {
                User? userDetails = widget.user ?? controller.userDetails;
                if (userDetails != null) {
                  nameController =
                      TextEditingController(text: userDetails.username);
                  contactController =
                      TextEditingController(text: userDetails.contact);
                  defaultImageUrl = userDetails.profileImgUrl != ''
                      ? (userDetails.profileImgUrl ?? defaultImageUrl)
                      : defaultImageUrl;
                  imageUrlController.text = userDetails.profileImgUrl ?? '';
                }
                return Stack(
                  fit: StackFit.passthrough,
                  children: [
                    PageIdentifierText(
                      contextSize: contextSize,
                      isPortrait: orientation == Orientation.portrait,
                      text: "User Profile",
                    ),
                    UserAvatarImage(
                      isPortrait: orientation == Orientation.portrait,
                      isEditable: isEditableForm,
                      imagePathController: imageUrlController,
                    ),
                    Positioned(
                      bottom: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.015
                          : MediaQuery.of(context).size.height * 0.02,
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
                              isReadOnly: !isEditableForm,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015),
                            TextFieldContainer(
                              textController: contactController,
                              hintText: 'Phone or Email',
                              fieldType: TextInputFieldType.contact,
                              isPortrait: orientation == Orientation.portrait,
                              isReadOnly: !isEditableForm,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015),
                            TextFieldContainer(
                              textController: passwordController,
                              hintText: 'Password',
                              fieldType: TextInputFieldType.password,
                              isPortrait: orientation == Orientation.portrait,
                              isReadOnly: !isEditableForm,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015),
                            isEditableForm
                                ? TextFieldContainer(
                                    textController: passwordController1,
                                    hintText: 'Re type password',
                                    fieldType: TextInputFieldType.password,
                                    isPortrait:
                                        orientation == Orientation.portrait,
                                    isReadOnly: !isEditableForm,
                                    function: () {
                                      if (passwordController.text !=
                                          passwordController1.text) {
                                        return 'password mismatch';
                                      } else {
                                        return null;
                                      }
                                    },
                                  )
                                : Container(),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            CustomActionButton(
                              contextSize: contextSize,
                              isPortrait: orientation == Orientation.portrait,
                              buttonText: isEditableForm ? "Update" : 'Edit',
                              function: () async {
                                if (!isEditableForm) {
                                  isEditableForm = !isEditableForm;
                                  setState(() {});
                                }
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Updating ...'),
                                    ),
                                  );
                                  userDetails?.contact = contactController.text;
                                  userDetails?.username = nameController.text;
                                  userDetails?.profileImgUrl =
                                      imageUrlController.text.isNotEmpty
                                          ? imageUrlController.text
                                          : '';
                                  userDetails?.password =
                                      passwordController.text;
                                  Get.find<AuthController>()
                                      .updateUser(userDetails)
                                      .then((value) {
                                    userDetails = value;
                                    isEditableForm = !isEditableForm;
                                    passwordController.text = '';
                                    passwordController1.text = '';
                                    setState(() {});
                                  });
                                }
                              },
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            widget.isAdmin ?? false
                                ? CustomActionButton(
                                    contextSize: contextSize,
                                    isPortrait:
                                        orientation == Orientation.portrait,
                                    buttonText: widget.user?.isActive == true
                                        ? 'Remove user'
                                        : 'Removed User',
                                    function: () async {
                                      await Get.find<UsersController>()
                                          .removeUser(widget.user);
                                    },
                                  )
                                : Container(),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
