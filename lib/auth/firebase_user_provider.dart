import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BestDealsInfoFirebaseUser {
  BestDealsInfoFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

BestDealsInfoFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BestDealsInfoFirebaseUser> bestDealsInfoFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BestDealsInfoFirebaseUser>(
            (user) => currentUser = BestDealsInfoFirebaseUser(user));
