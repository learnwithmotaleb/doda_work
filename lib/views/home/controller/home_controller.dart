import 'dart:convert';
import 'package:doda_work/core/utils/app_storage.dart';
import 'package:doda_work/views/home/model/home_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/basic_import.dart';
import '../model/requestModel.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  // Currently selected tab index
  final RxInt selectedStatus = 0.obs;

  /// Paging controller for user's requests
  final PagingController<int, RequestService> requestPagingController =
      PagingController(firstPageKey: 1);

  /// Paging controllers for Home Services (Pending, Ongoing, Completed)
  final Map<String, PagingController<int, HomeServiceItem>> pagingControllers =
      {
        "PENDING": PagingController(firstPageKey: 1),
        "ONGOING": PagingController(firstPageKey: 1),
        "COMPLETED": PagingController(firstPageKey: 1),
      };

  /// Loading states for Home Services
  final Map<String, bool> isLoadingMap = {
    "PENDING": false,
    "ONGOING": false,
    "COMPLETED": false,
  };

  // =============================
  // FETCH HOME SERVICES
  // =============================
  Future<void> fetch(String status, int pageKey) async {
    if (isLoadingMap[status] == true) return;
    isLoadingMap[status] = true;

    final controller = pagingControllers[status]!;

    try {
      final response = await ApiClient.get(
        url: ApiEndPoints.myService(status: status, page: pageKey),
      );

      if (response.statusCode == 200) {
        final newItems = HomeModel.fromJson(response.body).data?.requests ?? [];

        if (newItems.isEmpty) {
          controller.appendLastPage(newItems);
        } else {
          controller.appendPage(newItems, pageKey + 1);
        }
      } else {
        controller.error = 'Error fetching data';
      }
    } catch (e) {
      controller.error = e.toString();
    } finally {
      isLoadingMap[status] = false;
    }
  }

  // =============================
  // FETCH ALL REQUESTS FOR CURRENT USER
  // =============================
  Future<void> fetchUserRequests(int pageKey) async {
    try {
      final token = await AppStorage.token;
      final url = Uri.parse(ApiEndPoints.getServiceRequestAll(page: pageKey));

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List list = decoded["data"]["requests"] ?? [];

        final newItems = list.map((e) => RequestService.fromJson(e)).toList();

        if (newItems.isEmpty) {
          requestPagingController.appendLastPage(newItems);
        } else {
          requestPagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        requestPagingController.error = "Error fetching user requests";
      }
    } catch (e) {
      requestPagingController.error = e.toString();
    }
  }

  // =============================
  // INIT CONTROLLER
  // =============================
  @override
  void onInit() {
    super.onInit();

    // Home Services paging
    pagingControllers.forEach((status, controller) {
      controller.addPageRequestListener((pageKey) => fetch(status, pageKey));
    });

    // Fetch first page for all Home Services
    fetch("PENDING", 1);
    fetch("ONGOING", 1);
    fetch("COMPLETED", 1);

    // User requests paging
    requestPagingController.addPageRequestListener(
      (pageKey) => fetchUserRequests(pageKey),
    );
  }

  // =============================
  // REFRESH FUNCTIONS
  // =============================
  Future<void> refreshStatusData(String status) async {
    pagingControllers[status]?.refresh();
  }

  Future<void> refreshUserRequests() async {
    requestPagingController.refresh();
  }

  // =============================
  // DISPOSE CONTROLLERS
  // =============================
  @override
  void onClose() {
    pagingControllers.forEach((_, controller) => controller.dispose());
    requestPagingController.dispose();
    super.onClose();
  }
}
