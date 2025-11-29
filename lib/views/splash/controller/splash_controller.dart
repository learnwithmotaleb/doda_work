// controllers/splash_controller.dart
import 'package:get/get.dart';
import '../../../core/utils/app_storage.dart';
import '../../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _checkNavigation();
  }

  void _checkNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    final bool hasValidToken = AppStorage.isLoggedIn && AppStorage.token.isNotEmpty;
    final bool hasSeenOnboarding = AppStorage.seenOnboarding;

    print("🔍 DEBUG - Token: ${AppStorage.token}");
    print("🔍 DEBUG - isLoggedIn: ${AppStorage.isLoggedIn}");
    print("🔍 DEBUG - seenOnboarding: $hasSeenOnboarding");
    print("🔍 DEBUG - hasValidToken: $hasValidToken");

    if (hasValidToken) {
      // ✅ User is logged in → Go directly to Home
      print("✅ USER LOGGED IN → HOME");
      Get.offAllNamed(Routes.navigationScreen);
    } else if (!hasSeenOnboarding) {
      print("🚀 NEW USER → ONBOARDING");
      Get.offAllNamed(Routes.onboardScreen);
    } else {
      print("🔐 RETURNING USER → LOGIN");
      Get.offAllNamed(Routes.loginScreen);
    }
  }
}