import 'package:get/get.dart';
import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';
import '../model/faq_model.dart';

class FaqController extends GetxController {
  /// ============================= GET FAQ Data =====================================

  final RxList<Data> faqList = <Data>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onReady() {
    fetchFaqs();
    super.onReady();
  }

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;
      var response = await ApiClient.get(

          url: ApiEndPoints.faqGet);

      if (response.statusCode == 200) {
        FaqModel faqModel = FaqModel.fromJson(response.body);
        faqList.value = faqModel.data ?? [];
      }
    } finally {
      isLoading.value = false;
    }
  }
}