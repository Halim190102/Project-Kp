import 'package:firebase_auth/firebase_auth.dart';
import 'package:koperasi/view_model/authentication/firebase_exceptions.dart';

class FireAuth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  static Future<AuthStatus> login({required String email, required String pass}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }

  static Future<AuthStatus> regis({required String email, required String pass, required String nama}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      await auth.currentUser!.updateDisplayName(nama);
      await auth.currentUser!.reload();
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }

  static Future<AuthStatus> reset({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) => _status = AuthStatus.successful);
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    }
    return _status;
  }

  static logout() async {
    await auth.signOut();
  }

  static sendVerify() async {
    await auth.currentUser!.sendEmailVerification();
  }
}
