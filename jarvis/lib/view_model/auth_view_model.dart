import 'package:flutter/cupertino.dart';

import '../model/user.dart';
import '../model/user_info.dart';
import '../model/user_token.dart';
import '../repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  User? user;
  bool isSigningIn = false;
  bool isSigningUp = false;
  String errorMessageSignIn = '';
  String errorMessageSignUp = '';

  AuthViewModel(this._authRepository);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    isSigningIn = true;
    errorMessageSignIn = '';
    notifyListeners();

    try {
      UserToken? userToken =
          await _authRepository.signInWithEmailAndPassword(email, password);

      isSigningIn = false;

      if (userToken != null) {
        UserInfo? userInfo =
            await _authRepository.getUserInfo(userToken.accessToken);
        if (userInfo != null) {
          user = User(userToken: userToken, userInfo: userInfo);
        }
      }
    } catch (e) {
      isSigningIn = false;
      errorMessageSignIn = e.toString();
    }

    notifyListeners();
  }

  Future<bool> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    isSigningUp = true;
    errorMessageSignUp = '';
    notifyListeners();

    try {
      await _authRepository.signUpWithEmailAndPassword(
          email, password, username);

      isSigningUp = false;
      return true;
    } catch (e) {
      errorMessageSignUp = e.toString();
      isSigningUp = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut(user?.userToken.accessToken ?? '');
    user = null;
    notifyListeners();
  }
}
