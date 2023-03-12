import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_management/data_models/user.dart';

class UsersSetAdapter extends TypeAdapter<Set<User>> {
  @override
  Set<User> read(BinaryReader reader) {
    final length = reader.readUint32();
    final set = <User>{};
    for (var i = 0; i < length; i++) {
      final song = User.fromJson(reader.readMap());
      set.add(song);
    }
    return set;
  }

  @override
  void write(BinaryWriter writer, Set<User> set) {
    writer.writeUint32(set.length);
    for (final user in set) {
      writer.writeMap(user.toJson());
    }
  }

  @override
  int get typeId => 2;
}
