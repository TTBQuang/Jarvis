import 'package:jarvis/model/user_info.dart';
import 'package:jarvis/model/user_token.dart';
import 'package:uuid/uuid.dart';

class User {
  UserInfo? userInfo;
  UserToken? userToken;
  late final String userUuid;

  User({
    this.userToken,
    this.userInfo,
  }) {
    userUuid = const Uuid().v4();
    print(userUuid);
  }
}
