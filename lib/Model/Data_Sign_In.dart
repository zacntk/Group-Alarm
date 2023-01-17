import 'package:google_sign_in/google_sign_in.dart';

class Data_Sign_In {
  GoogleSignInAccount? _currentUser;

  GoogleSignInAccount? get getCurrentUser {
    return _currentUser;
  }

  void setCurrentUser(GoogleSignInAccount? _currentUser) {
    this._currentUser = _currentUser;
  }
}
