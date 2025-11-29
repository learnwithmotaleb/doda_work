import 'dart:io';
import 'package:doda_work/core/api/services/auth_service.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/api/services/auths.dart';

class LoginController extends GetxController {
  /// FORM
  final formKey = GlobalKey<FormState>();

  /// EMAIL
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final isEmailValid = false.obs;

  /// PASSWORD
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  final isPasswordValid = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  /// LOADING
  final isLoading = false.obs;

  /// FIREBASE AUTH
  final firebaseUser = Rxn<User>();

  User? get user => firebaseUser.value;

  @override
  void onInit() {
    super.onInit();

    /// Default test credentials
    emailController.text = 'qeo@yopmail.com';
    passwordController.text = '112233';
  }

  /// ❌ REMOVE dispose()
  /// GetX নিজেই lifecycle handle করবে

  /// =======================================
  /// 🔥 LOGIN USING EMAIL + PASSWORD (API)
  /// =======================================
  Future<dynamic> loginProcess() async {
    return await AuthService.loginService(
      isLoading: isLoading,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  /// =======================================
  /// 🔥 GOOGLE SIGN IN (Android / iOS / Web)
  /// =======================================
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignIn googleSignIn;

      if (kIsWeb) {
        googleSignIn = GoogleSignIn(
          clientId:
          "621538781171-8f9t0fpop11e2cfg4jc5qc9iukbb1sq5.apps.googleusercontent.com",
          scopes: ['email', 'profile'],
        );
      } else {
        googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
      }

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar("Cancelled", "Google sign-in cancelled");
        return null;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      firebaseUser.value = userCredential.user;

      Get.snackbar(
        "Success",
        "Signed in as ${userCredential.user?.displayName}",
      );

      return userCredential.user;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");

      await FirebaseAuth.instance.signOut();
      firebaseUser.value = null;

      Get.snackbar("Error", "Google Sign-In failed: $e");
      return null;
    }
  }

  /// =======================================
  /// 🔥 SIGN OUT (Google + Firebase)
  /// =======================================
  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      firebaseUser.value = null;

      Get.snackbar("Success", "Signed out successfully");
    } catch (e) {
      debugPrint("Sign-Out Error: $e");
      Get.snackbar("Error", "Unable to sign out");
    }
  }

  /// APPLE AUTH INSTANCE
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// =======================================
  /// 🔥 APPLE SIGN IN (iOS / macOS Only)
  /// =======================================
  static Future<UserCredential?> signInWithApple() async {
    try {
      if (kIsWeb) {
        print("❌ Apple Sign-In not supported on Web");
        return null;
      }

      if (!Platform.isIOS && !Platform.isMacOS) {
        print("❌ Apple Sign-In only supports iOS/macOS");
        return null;
      }

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      return await _auth.signInWithCredential(oauthCredential);
    } catch (e) {
      debugPrint("Apple Sign-In Error: $e");
      return null;
    }
  }

  /// =======================================
  /// 🔥 CURRENT USER
  /// =======================================
  static User? currentUser() => _auth.currentUser;

  /// =======================================
  /// 🔥 SIGN OUT (Apple + Firebase)
  /// =======================================
  static Future<void> signOutApple() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("Apple Sign-Out Error: $e");
    }
  }
}
