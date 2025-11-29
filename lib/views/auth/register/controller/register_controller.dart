import 'package:doda_work/core/api/services/auths.dart';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final passConfirmController = TextEditingController();
  final confirmPasswordFocus = FocusNode();

  // email
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final isEmailValid = false.obs;

  // phoneNumber
  final phoneController = TextEditingController();
  final phoneFocus = FocusNode();

  // password
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  final isPasswordValid = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  // final isCheck = false.obs;

  var isCheck = false.obs;
  var isError = false.obs;

  // void validateAndProceed() {
  //   if (isCheck.value) {
  //     isError.value = false;
  //     Get.toNamed('');
  //   } else {
  //     isError.value = true;
  //   }
  // }


  RxBool isLoading = false.obs;

  registerProcess() async {
    return await AuthService.registerService(
      isLoading: isLoading,
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
      role: AppStorage.isVendor == true ? "PROVIDER" : "USER",
      confirmPassword: passConfirmController.text,

    );
  }
}
