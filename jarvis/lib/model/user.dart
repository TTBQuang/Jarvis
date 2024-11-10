import 'package:jarvis/model/user_info.dart';
import 'package:jarvis/model/user_token.dart';

class User {
  late final UserInfo userInfo;
  late final UserToken userToken;

  User({
    UserToken? userToken,
    UserInfo? userInfo,
  }) {
    this.userToken = userToken ?? UserToken();
    this.userInfo = userInfo ?? UserInfo();
  }
}
