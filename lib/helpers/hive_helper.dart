import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_management/data_models/user.dart';
import 'package:user_management/helpers/users_set.dart';

final _HiveData hiveData = _HiveData.instance;

class _HiveData {
  _HiveData._();

  init() async {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UsersSetAdapter());
  }

  static final _HiveData instance = _HiveData._();
  static const String _boxName = 'users';

  Future<Box<Set<User>>> _openUsers() async {
    var connectionBox = await Hive.openBox<Set<User>>(_boxName);
    if (Hive.isBoxOpen(_boxName) == false) {
      await Hive.openBox<Set<User>>(_boxName);
    } else {
      await connectionBox.close();
      connectionBox = await Hive.openBox<Set<User>>(_boxName);
    }

    return connectionBox;
  }

  Future<void> saveUsers(Set<User> users) async {
    final box = await _openUsers();
    await box.put('allUsers', users);
    await box.close();
  }

  Future<Set<User>?> getUsers() async {
    final box = await _openUsers();
    Set<User>? users = <User>{};
    if (box.isOpen) {
      print('${box.isOpen}');
      users = box.get('allUsers', defaultValue: <User>{});
      await box.close();
    }
    return users;
  }

  Future<void> save(User user) async {
    Set<User>? users = await getUsers();
    users = users ?? {};
    users.add(user);
    await saveUsers(users);
  }

  Future<void> removeUser(User user) async {
    Set<User>? users = await getUsers();
    users = users ?? {};
    users = users.where((x) => x.id != user.id).toSet();
    await saveUsers(users);
  }
}
