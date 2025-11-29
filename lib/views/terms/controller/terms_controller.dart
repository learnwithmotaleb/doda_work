import 'package:doda_work/core/api/end_point/api_end_points.dart';
import 'package:doda_work/core/api/services/api_request.dart';
import 'package:doda_work/views/terms/model/terms_model.dart';
import 'package:get/get.dart';

class TermsController extends GetxController {
  /// ============================= GET Terms Condition =====================================

  @override
  void onReady() {
    getTermsCondition();
    super.onReady();
  }
  final Rx<TermsModel> termsData = TermsModel().obs;
  final RxBool isLoading = false.obs;
  Future<void> getTermsCondition() async {
    try{
      isLoading.value = true;
      var response = await ApiClient.get(url: ApiEndPoints.faqGet);
      if (response.statusCode == 200) {
        termsData.value = TermsModel.fromJson(response.body);

      }
    }finally{
      isLoading.value = false;
    }

  }
}
 