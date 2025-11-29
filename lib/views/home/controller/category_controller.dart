import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../../../core/api/end_point/api_end_points.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var allCategory = <Data>[].obs; // All categories
  var filteredCategory = <Data>[].obs; // For filtered/search use
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  Future<void> getCategory() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await http.get(Uri.parse(ApiEndPoints.getAllCategory));

      if (response.statusCode == 200) {
        final model = UserAllCategoryModel.fromJson(json.decode(response.body));

        if (model.success == true && model.data != null) {
          allCategory.assignAll(model.data!);
          filteredCategory.assignAll(model.data!); // Initially same as allCategory
        } else {
          errorMessage(model.message ?? 'No categories found');
        }
      } else {
        errorMessage('Server error: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
