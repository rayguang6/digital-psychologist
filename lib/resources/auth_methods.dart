import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:digital_psychologist/models/user.dart' as model;
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        User? currentUser;
        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences!.setString("uid", cred.user!.uid);
        await sharedPreferences!.setString("email", email);
        await sharedPreferences!.setString("username", username);
        await sharedPreferences!.setString("photoUrl", photoUrl);

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password

        User? currentUser;
        await _auth
            .signInWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((auth) => currentUser = auth.user!)
            .catchError((onError) {
          print(onError);
        });

        if (currentUser != null) {
          readDataAndSetDataLocally(currentUser!);
        }
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        print("current user id is:  " + currentUser.uid);
        await sharedPreferences!.setString("email", snapshot.data()!["email"]);
        await sharedPreferences!
            .setString("username", snapshot.data()!["username"]);
        await sharedPreferences!
            .setString("photoUrl", snapshot.data()!["photoUrl"]);
      }
    });
  }
}
