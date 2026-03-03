import '../models/user.dart';

class LocalDatabase {
  static final List<User> _users = [];

  static void addUser(User user) {
    _users.add(user);
  }

  static List<User> getUsers() {
    return _users;
  }
}
