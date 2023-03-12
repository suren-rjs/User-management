import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/controllers/users_controller.dart';
import 'package:user_management/screens/home_screen/widgets/user_card.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({
    super.key,
    required this.isPortrait,
    required this.isActiveUsers,
  });

  final bool isPortrait;
  final bool isActiveUsers;

  @override
  Widget build(BuildContext context) {
    var contextSize = MediaQuery.of(context).size;
    return GetBuilder<UsersController>(
      init: Get.find<UsersController>(),
      builder: (controller) => Container(
        padding: const EdgeInsets.only(left: 0),
        height:
            isPortrait ? contextSize.height * 0.3 : contextSize.height * 0.58,
        width: contextSize.width,
        child: Container(
          padding: const EdgeInsets.only(left: 0),
          height: isPortrait
              ? contextSize.height * 0.375
              : contextSize.height * 0.48,
          width: contextSize.width,
          child: ListView.builder(
            itemCount: isActiveUsers
                ? controller.activeUsers.length
                : controller.inActiveUsers.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: isPortrait
                      ? contextSize.width * 0.7
                      : contextSize.width * 0.3,
                  child: UserCard(
                    isPortrait: isPortrait,
                    user: isActiveUsers
                        ? controller.activeUsers[index]
                        : controller.inActiveUsers[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
