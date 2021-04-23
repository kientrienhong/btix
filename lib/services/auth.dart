import 'package:btix/apis/api.dart';
import 'package:btix/models/user.dart';

abstract class AuthBase {
  User user;
  Future<void> signInUserName(String username, String password);
  Future<void> signUpUserName(String username, String password);
  Future<void> updateBillForAccount();
  void updateUser(User newUser);
}

class Auth implements AuthBase {
  User user;

  @override
  void updateUser(User newUser) {
    user = newUser;
  }

  @override
  Future<void> signInUserName(String username, String password) async {
    try {
      var response = await Api.login(username, password);
      user = User.fromJson(response);
      var detailInfo = await Api.getAccountInfo(username);
      user = user.copyWith(historyBooked: detailInfo['thongTinDatVe']);
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  @override
  Future<void> signUpUserName(String username, String password) async {
    try {
      var response = await Api.login(username, password);
      user = User.fromJson(response);
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  @override
  Future<void> updateBillForAccount() async {
    try {
      var detailInfo = await Api.getAccountInfo(user.username);
      user = user.copyWith(historyBooked: detailInfo['thongTinDatVe']);
    } catch (e) {
      throw Exception('Wrong');
    }
  }
}
