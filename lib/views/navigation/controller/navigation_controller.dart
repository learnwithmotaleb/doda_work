import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/views/navigation/model/navigation_model.dart';

class NavigationController extends GetxController {
  final List<NavigationModel> navigationList = [
    NavigationModel(iconPath: Assets.icons.home, name: "Home"),
    NavigationModel(
      iconPath: AppStorage.isVendor == false
          ? Assets.icons.request1
          : Assets.icons.category,
      name: AppStorage.isVendor == false ? "Service Request" : "Categories",
    ),
    NavigationModel(iconPath: Assets.icons.frame1, name: "Chat"),
    NavigationModel(iconPath: Assets.icons.vuesax, name: "Profile"),
  ];

  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void goToProfile() {
    selectedIndex.value = 3;
  }

  void goToHome() {
    selectedIndex.value = 0;
  }
}
