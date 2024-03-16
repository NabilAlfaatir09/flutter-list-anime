import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Obx(
              () => Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.28,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/banner.jpeg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () =>
                          Navigator.of(context).pushNamed(Routes.LOGIN),
                      child: Text(
                        (controller.userName.value == "")
                            ? "Login"
                            : controller.cutString(controller.userName.value),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: Text(
                      (controller.userName.value == "")
                          ? "***********"
                          : controller.userName.value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: Text(
                      (controller.userEmail.value == "")
                          ? "***********"
                          : controller.userEmail.value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 30,
                    ),
                    title: Text(
                      "Profile details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next_outlined,
                      size: 30,
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: Icon(
                      Icons.bookmark,
                      size: 30,
                    ),
                    title: Text(
                      "Whitelist Anime",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.navigate_next_outlined,
                      size: 30,
                    ),
                  ),
                  const Divider(),
                  (controller.userName.value == "")
                      ? Container()
                      : Column(
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () => loginController.signOut(),
                              child: const ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  size: 30,
                                ),
                                title: Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.navigate_next_outlined,
                                  size: 30,
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                  ListTile(
                    leading: const Icon(
                      Icons.dark_mode,
                      size: 30,
                    ),
                    title: const Text(
                      "dark Mode",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Obx(
                      () => Switch(
                        value: controller.isDark.value,
                        activeColor: Colors.white,
                        activeTrackColor: Colors.grey[700],
                        inactiveTrackColor: Colors.white,
                        inactiveThumbColor: Colors.grey[700],
                        onChanged: (value) async {
                          controller.darkMode(value);
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool("darkmode", value);
                        },
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.28 - 65,
              left: MediaQuery.of(context).size.width / 2 - 62.5,
              child: Obx(
                () => Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    image: (controller.userImage.value == "")
                        ? const DecorationImage(
                            image: AssetImage(
                              "assets/profilePicture.png",
                            ),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(
                              controller.userImage.value,
                            ),
                            fit: BoxFit.cover,
                          ),
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    border: Border.all(
                      color: (controller.isDark.value)
                          ? const Color.fromRGBO(18, 18, 18, 1)
                          : Colors.white,
                      width: 5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
