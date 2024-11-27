import 'package:flutter/cupertino.dart';

import '../model/user.dart';
import '../model/user_info.dart';
import '../model/user_token.dart';
import '../repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  late User user;
  bool isSigningIn = false;
  bool isSigningUp = false;
  String errorMessageSignIn = '';
  String errorMessageSignUp = '';


  AuthViewModel(this._authRepository){
    user = User();
  }

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
            await _authRepository.getUserInfo(userToken.accessTokenJarvis);
        if (userInfo != null) {
          user = User(userToken: userToken, userInfo: userInfo);
        }
      }
      notifyListeners();
    } catch (e) {
      isSigningIn = false;
      errorMessageSignIn = 'Failed to sign in';
      notifyListeners();
    }
  }

  Future<bool> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    isSigningUp = true;
    errorMessageSignUp = '';
    notifyListeners();

    // Validate email format using RegExp
    RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(email)) {
      errorMessageSignUp = 'Invalid email format';
      isSigningUp = false;
      notifyListeners();
      return false;
    }

    // Validate password: At least 6 characters, 1 uppercase letter, 1 number, and 1 special character
    RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{6,}$');
    if (!passwordRegExp.hasMatch(password)) {
      errorMessageSignUp = 'Password must be at least 6 characters long, and include at least '
          'one uppercase letter, one number, and one special character.';
      isSigningUp = false;
      notifyListeners();
      return false;
    }

    try {
      await _authRepository.signUpWithEmailAndPassword(
          email, password, username);

      isSigningUp = false;
      return true;
    } catch (e) {
      print(e.toString());
      errorMessageSignUp = 'Fail to sign up';
      isSigningUp = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut(user.userToken?.accessTokenJarvis ?? '');
    user = User();
    notifyListeners();
  }
}
