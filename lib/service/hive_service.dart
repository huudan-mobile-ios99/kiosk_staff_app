import 'package:hive_flutter/hive_flutter.dart';
import 'package:vegas_point_portal/model/hive/user_short.dart';

const String _boxName = 'user_box';

class HiveController {
  HiveController._constructor();
  static final HiveController _instance = HiveController._constructor();
  factory HiveController() => _instance;
  late Box<UserShort> _usersBox;

  Future<void> initialize() async {
    // initialize the database
    await Hive.initFlutter();
    Hive.registerAdapter<UserShort>(UserShortAdapter());
    _usersBox = await Hive.openBox<UserShort>(_boxName);
  }

  Box<UserShort> get userBox => _usersBox;

  Future<void> saveUser(UserShort user) async {
  try {
    // Retrieve existing users from the box
    final List<UserShort> existingUsers = _usersBox.values.toList();
    
    // Shift existing users one position down
    for (int i = existingUsers.length - 1; i >= 0; i--) {
      await _usersBox.put(i + 1, existingUsers[i].copy()); // Use copy() method to create a new instance
    }

    // Add the new user at index 0
    await _usersBox.put(0, user);
    print('User added: $user');
  } catch (e) {
    print('Error saving user: $e');
  }
}

  // Future<List<UserShort>> getUsers() async {
  //   try {
  //     // Retrieve all users from the box
  //     final List<UserShort> users = _usersBox.values.toList();
  //     print('Users retrieved: ${users.length}');
  //     return users;
  //   } catch (e) {
  //     print('Error retrieving users: $e');
  //     return []; // Return an empty list in case of error
  //   }
  // }

  Future<List<UserShort>> getUsers() async {
  try {
    // Retrieve all users from the box
    final List<UserShort> users = _usersBox.values.toList();
    // Map to store the latest unique users based on name and number
    final Map<String, UserShort> uniqueUsers = {};
    // Iterate through the list and keep only the first occurrence of each unique user
    for (final user in users) {
      final key = '${user.name}_${user.number}';
      if (!uniqueUsers.containsKey(key)) {
        uniqueUsers[key] = user;
      }
    }
    // Convert the values of the map back to a list
    final List<UserShort> latestUsers = uniqueUsers.values.toList();
    // print('Latest unique users retrieved: ${latestUsers.length}');
    return latestUsers;
  } catch (e) {
    print('Error retrieving users: $e');
    return []; // Return an empty list in case of error
  }
}

  Future<void> deleteAllUsers() async {
    try {
      await _usersBox.clear(); // Clear all items from the box
      print('All users deleted');
    } catch (e) {
      print('Error deleting all users: $e');
    }
  }
}
