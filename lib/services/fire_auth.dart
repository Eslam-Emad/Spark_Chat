import 'package:firebase_auth/firebase_auth.dart';

import '/models/user_model.dart';
import '/services/firestore_service.dart';

abstract class AuthServices {
  login(String email, String password);

  signup(UserModel user, String password);

  signOut();
}

class FireAuthServices implements AuthServices {
  final _auth = FirebaseAuth.instance;
  final _store = FireStoreServices();

  User? get currentUser => _auth.currentUser;

  bool get isAuthenticated => _auth.currentUser != null;

  Stream<User?> get authState => _auth.authStateChanges();

  @override
  login(String email, String password) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserCredential> signup(UserModel user, String password) async {
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: user.email, password: password);
    await _store.createUser(currentUser!.uid, user);
    return newUser;
  }

  @override
  signOut() => _auth.signOut();
}
