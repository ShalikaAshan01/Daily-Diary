import 'package:daily_diary/controllers/user_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
getSignedInFacebook(){

}

Future<FirebaseUser> signIn(AuthCredential credential) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserControl userControl= UserControl();
  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  await userControl.onSignIn(user.uid, user.displayName);
  return user;
}