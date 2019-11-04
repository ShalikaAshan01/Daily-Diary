import 'package:daily_diary/controllers/user_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<AuthCredential> getSignedInGoogleAccount(
    GoogleSignIn googleSignIn) async {
  GoogleSignInAccount account = googleSignIn.currentUser;
  if (account == null) {
    account = await googleSignIn.signIn();
  }
  GoogleSignInAuthentication googleAuth = await account.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return credential;
}

Future<AuthCredential> getSignedInFacebook() async {
  final FacebookLogin facebookLogin = FacebookLogin();
  final result = await facebookLogin.logIn(['email']);

  print("++++++++++++++++++++++++++++");
  print(result.status);
  print("++++++++++++++++++++++++++++");

  final AuthCredential authCredential =
      FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
  return authCredential;
}

Future<FirebaseUser> signIn(AuthCredential credential) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserControl userControl = UserControl();
  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  await userControl.onSignIn(user.uid, user.displayName);
  return user;
}
