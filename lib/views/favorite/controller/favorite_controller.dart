import 'package:get/get.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api.dart';
import '../model/favorite_model.dart';

class FavoriteController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<FavoriteCategoryItem> favoriteList = <FavoriteCategoryItem>[].obs;

  @override
  void onInit() {
    fetchFavoriteCategories();
    super.onInit();
  }

  /// 🔥 Call GET API
  Future<void> fetchFavoriteCategories() async {
    await ApiRequest.get<FavoriteCategoryResponse>(
      endPoint: ApiEndPoints.getFavoritesCategory,
      isLoading: isLoading,
      showResponse: true,

      fromJson: (json) => FavoriteCategoryResponse.fromJson(json),

      onSuccess: (result) {
        /// Make sure the list exists
        if (result.data?.data != null) {
          favoriteList.value = result.data!.data!;
        } else {
          favoriteList.clear();
        }
      },
    );
  }
}
