import 'package:get/get.dart';
import 'package:user_management/data_models/user.dart';
import 'package:user_management/helpers/hive_helper.dart';
import 'package:user_management/in_app_storage/secure_storage.dart';
import 'package:uuid/uuid.dart';

class UsersController extends GetxController {
  bool isLoading = false;
  User? userDetails;

  List<User> get activeUsers =>
      _users.where((element) => element.isActive).toList();

  List<User> get inActiveUsers =>
      _users.where((element) => !element.isActive).toList();

  List<User> _users = [];

  UsersController() {
    getAllUsers();
  }

  Future<List<User>> getAllUsers() async {
    isLoading = true;
    _users = (await hiveData.getUsers())?.toList() ?? [];
    update();
    isLoading = false;
    return _users;
  }

  Future<List<User>> getUsersByActiveStatus(bool isActive) async {
    isLoading = true;
    await getAllUsers();
    isLoading = false;
    return _users.where((user) => user.isActive == isActive).toList();
  }

  Future<void> addNewUser(User user) async {
    isLoading = true;
    user.id = const Uuid().v4();
    await hiveData.save(user);
    getAllUsers();
    isLoading = false;
  }

  Future<void> updateUser(User user) async {
    isLoading = true;
    await hiveData.removeUser(user);
    await hiveData.save(user);
    getAllUsers();
    isLoading = false;
  }

  Future<void> removeUser(User? user) async {
    if (user == null) return;
    isLoading = true;
    user.isActive = false;
    await updateUser(user);
    isLoading = false;
    await getAllUsers();
  }

  Future<User?> findByUserContact(String contact) async {
    try {
      return _users.where((user) => user.contact == contact).first;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> findByUserId(String id) async {
    try {
      return _users.where((user) => user.id == id).first;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> getUserDetails(String? userId) async {
    isLoading = true;
    if (userId == null) {
      String? userId = await secureStorage.get('loginUserId');
      userDetails = await findByUserId('$userId');
    } else {
      userDetails = await findByUserId(userId);
    }
    isLoading = false;
    return userDetails;
  }

  Future<void> search(String searchText) async {
    _users = _users
        .where((element) =>
            element.contact.toLowerCase().contains(searchText.toLowerCase()) ||
            element.username.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    update();
  }
}
