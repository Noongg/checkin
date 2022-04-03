import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseHelper{
static Future<void> loginFirebase({
  required String email,required String password
})async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    print(userCredential.user!.email);
    print(userCredential.user!.displayName);
    print(userCredential.user!.getIdToken().toString());

    // Get.offAllNamed(Routes.HOMEPAGE);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Get.back();
      Get.snackbar("Lỗi", "No user found for that email.");
    } else if (e.code == 'wrong-password') {
      Get.back();
      Get.snackbar("Lỗi", "Wrong password provided for that user.");
    }
  }
}

static Future<void> registerFirebase({
  required String name,
  required String email,required String password
})async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    user = userCredential.user;
    // await user!.sendEmailVerification();
    await user!.updateDisplayName(name);
    await user.reload();
    user = auth.currentUser;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Get.back();
      Get.snackbar("Lỗi", "The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
      Get.back();
      Get.snackbar("Lỗi", "The account already exists for that email.");
    }
  }
}
}