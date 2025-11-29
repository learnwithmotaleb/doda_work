import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:doda_work/core/utils/message_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../../utils/app_storage.dart';
import '../../utils/basic_import.dart';

class ApiRequest {
  /// ✅ Header Generator
  static Future<Map<String, String>> _bearerHeaderInfo([String? token]) async {
    final authToken = token ?? AppStorage.token;
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      if (authToken.isNotEmpty)
        HttpHeaders.authorizationHeader: "Bearer $authToken",
    };
  }

  static void printBodyLineByLine(Map<String, dynamic> body) {
    body.forEach((key, value) {
      log("🔹 '$key': '$value'");
      log('╚════════════════════════════════════════════════════════════════');
    });
  }

  // ✅ FIXED HERE
  static void printEndPointLog(String url) {
    log('╔════════════════════════════════════════════════════════════════');

    log("📍 'End Point': '$url'");
  }

  /// =========================================================== ✅ POST REQUEST =========================================================== ///
  static Future<R> post<R>({
    required R Function(Map<String, dynamic>) fromJson,
    required String endPoint,
    required RxBool isLoading,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
    bool showSuccessSnackBar = false,
    Function(R result)? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      log('|📤|---------[ 📦 POST REQUEST STARTED ]---------|📤|');

      // ✅ Build URL with queryParams
      final uri = Uri.parse(
        '${ApiEndPoints.baseUrl}$endPoint',
      ).replace(queryParameters: queryParams);

      printEndPointLog(uri.toString());
      printBodyLineByLine(body);

      final response = await http
          .post(uri, headers: await _bearerHeaderInfo(), body: jsonEncode(body))
          .timeout(const Duration(seconds: 120));

      log('|✅|---------[ ✅ POST REQUEST COMPLETED ]---------|✅|');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final result = fromJson(json);

        final successMessage =
            json['message'] ?? Strings.requestCompletedSuccessfully;
        if (showSuccessSnackBar) {
          CustomSnackBar.success(
            title: Strings.success,
            message: successMessage,
          );
        }
        if (onSuccess != null) onSuccess(result);

        return result;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['message'] ?? 'Something went wrong!';
        log('❌ Error: $errorMessage');
        CustomSnackBar.error(errorMessage);
        CustomSnackBar.error(errorMessage);
        throw Exception(errorMessage);

      }
    } catch (e) {
      
      MessageHelper.showError("Please Check Email and Password!");
      log('🐞🐞🐞 UNHANDLED ERROR:${e.toString()}');
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================================================== ✅ GET REQUEST =========================================================== ///
  static Future<R> get<R>({
    required R Function(Map<String, dynamic>) fromJson,
    required String endPoint,
    required RxBool isLoading,
    String? id,
    Map<String, dynamic>? queryParams,
    bool showSuccessSnackBar = false,
    bool showResponse = false,
    Function(R result)? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      log('|📥|---------[ 🌐 GET REQUEST STARTED ]---------|📥|');

      String fullUrl = '${ApiEndPoints.baseUrl}$endPoint';
      if (id != null && id.isNotEmpty) {
        fullUrl += '/$id';
      }
      final uri = Uri.parse(fullUrl).replace(
        queryParameters: queryParams?.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );

      printEndPointLog(uri.toString());

      final response = await http
          .get(uri, headers: await _bearerHeaderInfo())
          .timeout(const Duration(seconds: 120));

      // 🌟 Pretty print the response body here
      if (showResponse) {
        try {
          final prettyJson = const JsonEncoder.withIndent(
            '  ',
          ).convert(jsonDecode(response.body));
          log('|📤|---------[ RESPONSE BODY ]---------|📤|');
          log(prettyJson);
          log('|📤|---------------------------------|📤|');
        } catch (_) {
          log('|📤| RESPONSE (raw) |📤|: ${response.body}');
        }
      }
      log('|✅|---------[ ✅ GET REQUEST COMPLETED ]---------|✅|');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final result = fromJson(json);

        final successMessage =
            json['message'] ?? Strings.requestCompletedSuccessfully;
        if (showSuccessSnackBar) {
          CustomSnackBar.success(
            title: Strings.success,
            message: successMessage,
          );
        }
        if (onSuccess != null) onSuccess(result);

        return result;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['message'] ?? 'Something went wrong!';
        log('❌ Error: $errorMessage');
        CustomSnackBar.error(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      log('🐞🐞🐞 UNHANDLED ERROR: ${e.toString()}');
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================================================== ✅ PATCH REQUEST =========================================================== ///
  static Future<R> patch<R>({
    required R Function(Map<String, dynamic>) fromJson,
    required String endPoint,
    required RxBool isLoading,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
    bool showSuccessSnackBar = false,
    Function(R result)? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      log('|📤|---------[ 📦 PATCH REQUEST STARTED ]---------|📤|');

      // ✅ Build URL with queryParams
      final uri = Uri.parse(
        '${ApiEndPoints.baseUrl}$endPoint',
      ).replace(queryParameters: queryParams);

      printEndPointLog(uri.toString());
      printBodyLineByLine(body);

      final response = await http
          .patch(
            uri,
            headers: await _bearerHeaderInfo(),
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 120));

      log('|✅|---------[ ✅ PATCH REQUEST COMPLETED ]---------|✅|');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final result = fromJson(json);

        final successMessage =
            json['message'] ?? Strings.requestCompletedSuccessfully;
        if (showSuccessSnackBar) {
          CustomSnackBar.success(
            title: Strings.success,
            message: successMessage,
          );
        }
        if (onSuccess != null) onSuccess(result);

        return result;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['message'] ?? 'Something went wrong!';
        log('❌ Error: $errorMessage');
        CustomSnackBar.error(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      log('🐞🐞🐞 UNHANDLED ERROR: ${e.toString()}');
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================================================== ✅ PUT REQUEST =========================================================== ///
  static Future<R> put<R>({
    required R Function(Map<String, dynamic>) fromJson,
    required String endPoint,
    required RxBool isLoading,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
    bool showSuccessSnackBar = false,
    Function(R result)? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      log('|📤|---------[ 📦 PUT REQUEST STARTED ]---------|📤|');

      // ✅ Build URL with queryParams
      final uri = Uri.parse(
        '${ApiEndPoints.baseUrl}$endPoint',
      ).replace(queryParameters: queryParams);

      printEndPointLog(uri.toString());
      printBodyLineByLine(body);

      final response = await http
          .put(uri, headers: await _bearerHeaderInfo(), body: jsonEncode(body))
          .timeout(const Duration(seconds: 120));

      log('|✅|---------[ ✅ PUT REQUEST COMPLETED ]---------|✅|');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final result = fromJson(json);

        final successMessage =
            json['message'] ?? Strings.requestCompletedSuccessfully;
        if (showSuccessSnackBar) {
          CustomSnackBar.success(
            title: Strings.success,
            message: successMessage,
          );
        }
        if (onSuccess != null) onSuccess(result);

        return result;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['message'] ?? 'Something went wrong!';
        log('❌ Error: $errorMessage');
        CustomSnackBar.error(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      log('🐞🐞🐞 UNHANDLED ERROR: ${e.toString()}');
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================================================== ✅ DELETE REQUEST =========================================================== ///
  static Future<R> delete<R>({
    required R Function(Map<String, dynamic>) fromJson,
    required String endPoint,
    required RxBool isLoading,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool showSuccessSnackBar = false,
    Function(R result)? onSuccess,
  }) async {
    try {
      isLoading.value = true;
      log('|📤|---------[ 📦 DELETE REQUEST STARTED ]---------|📤|');

      // ✅ Build URL with queryParams
      final uri = Uri.parse(
        '${ApiEndPoints.baseUrl}$endPoint',
      ).replace(queryParameters: queryParams);

      printEndPointLog(uri.toString());
      if (body != null) printBodyLineByLine(body);

      final response = await http
          .delete(
            uri,
            headers: await _bearerHeaderInfo(),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(const Duration(seconds: 120));

      log('|✅|---------[ ✅ DELETE REQUEST COMPLETED ]---------|✅|');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        final Map<String, dynamic> json = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {};
        final result = fromJson(json);

        final successMessage =
            json['message'] ?? Strings.requestCompletedSuccessfully;
        if (showSuccessSnackBar) {
          CustomSnackBar.success(
            title: Strings.success,
            message: successMessage,
          );
        }
        if (onSuccess != null) onSuccess(result);

        return result;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['message'] ?? 'Something went wrong!';
        log('❌ Error: $errorMessage');
        CustomSnackBar.error(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      log('🐞🐞🐞 UNHANDLED ERROR: ${e.toString()}');
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// ======================================================== ✅ Multipart POST Method ========================================================= ///
  static Future<R> multiMultipartRequest<R>({
    required String endPoint,
    required RxBool isLoading,
    required String reqType,
    required Map<String, dynamic> body,
    required Map<String, File?> files,
    Map<String, List<File>>? filesList, // ✅ Added new parameter
    String? singleQueryParam,
    required R Function(Map<String, dynamic>) fromJson,
    bool showSuccessSnackBar = false,
    Function(R result)? onSuccess,
    String? token, // ✅ Added token parameter
  }) async {
    try {
      isLoading.value = true;
      final headers = await _bearerHeaderInfo(token); // ✅ Pass token here

      // Build URL
      String fullUrl = '${ApiEndPoints.baseUrl}$endPoint';
      if (singleQueryParam != null && singleQueryParam.isNotEmpty) {
        if (!singleQueryParam.startsWith('/')) fullUrl += '/';
        fullUrl += singleQueryParam;
      }

      final uri = Uri.parse(fullUrl);
      log('📤 MULTIPART REQUEST STARTED');
      log('🔗 Method  : $reqType');
      log('🔗 URL     : $uri');
      log('📦 Body    : $body');
      log('📑 Headers : $headers');

      final request = http.MultipartRequest(reqType.toUpperCase(), uri);
      request.headers.addAll(headers);

      // Add body fields safely
      body.forEach((key, value) {
        if (value is List || value is Map) {
          request.fields[key] = jsonEncode(value);
        } else {
          request.fields[key] = value?.toString() ?? '';
        }
      });

      // Add single files safely
      for (var entry in files.entries) {
        final file = entry.value;
        if (file == null) continue;

        final mimeType =
            lookupMimeType(file.path) ?? 'application/octet-stream';
        log('🧪 MIME TYPE for ${entry.key}: $mimeType');

        request.files.add(
          await http.MultipartFile.fromPath(
            entry.key,
            file.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      // ✅ Add multiple file lists as JSON strings
      if (filesList != null && filesList.isNotEmpty) {
        for (var entry in filesList.entries) {
          final key = entry.key;
          final fileList = entry.value;

          // ফাইলের path কে string list হিসেবে পাঠানো
          request.fields[key] = jsonEncode(
            fileList.map((file) => file.path).toList(),
          );

          log(
            '🧩 MULTI-FILE AS STRING [$key]: ${fileList.map((file) => file.path).toList()}',
          );
        }
      }

      // Send request
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 120),
      );
      final response = await http.Response.fromStream(streamedResponse);

      log('📬 RESPONSE STATUS: ${response.statusCode}');
      log('📬 RESPONSE BODY  : ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final result = fromJson(json);

        if (showSuccessSnackBar) {
          final successMessage =
              json['message'] ?? Strings.requestCompletedSuccessfully;
          CustomSnackBar.success(
            title: Strings.success,
            message: successMessage,
          );
        }

        if (onSuccess != null) onSuccess(result);
        return result;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['message'] ?? 'Something went wrong!';
        log('❌ MULTIPART ERROR: $errorMessage');
        CustomSnackBar.error(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      log('🐞 MULTIPART UNHANDLED ERROR: $e');
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle update profile process
  // Future<UserProfileModel?> updateProfile() async {
  //   final Map<String, File?> fileMap = {};
  //   if (selectedImg.value != null) {
  //     fileMap['image'] = selectedImg.value;
  //   }
  //   return await ApiRequest.multiMultipartRequest(
  //     endPoint: ApiEndPoints.updateProfile,
  //     reqType: "PUT",
  //     isLoading: isLoading,
  //     body: {
  //       'firstName': firstNameController.text.trim(),
  //       'lastName': lastNameController.text.trim(),
  //       'phone': phoneController.text.trim(),
  //     },
  //     files: fileMap,
  //     fromJson: UserProfileModel.fromJson,
  //     showSuccessSnackBar: true,
  //     onSuccess: (_) => Get.back(),
  //   );
  // }

  /// ✅ Check Internet Connection
  // static Future<bool> checkInternetConnection() async {
  //   final networkController = Get.find<NetworkController>();
  //   if (!networkController.isConnected.value) {
  //     // ✅ Show popup dialog
  //     // Get.toNamed(noInterNetPageDesign)
  //     Get.defaultDialog(
  //       title: "No Internet Connection",
  //       middleText: "Check your Internet Connection",
  //       textConfirm: "Okay",
  //       onConfirm: () => Get.back(),
  //     );
  //     return false;
  //   }
  //   return true;
  // }


  // static Future<R> multiMultipartRequest2<R>({
  //   required String endPoint,
  //   required RxBool isLoading,
  //   required String reqType, // GET, POST, PATCH, PUT
  //   required Map<String, dynamic> body,
  //   required Map<String, File?> files,
  //   Map<String, List<File>>? filesList,
  //   String? singleQueryParam,
  //   required R Function(Map<String, dynamic>) fromJson,
  //   bool showSuccessSnackBar = false,
  //   Function(R result)? onSuccess,
  //   required String token, // ✅ Backend requires Bearer Token
  // }) async {
  //   try {
  //     isLoading.value = true;
  //
  //     // 🔐 Add Token into header
  //     final headers = {
  //       "Accept": "application/json",
  //       "Authorization": "Bearer ${AppStorage.token}", // <--- Required by backend
  //     };
  //
  //     // Build URL
  //     String fullUrl = '${ApiEndPoints.baseUrl}$endPoint';
  //     if (singleQueryParam != null && singleQueryParam.isNotEmpty) {
  //       if (!singleQueryParam.startsWith('/')) fullUrl += '/';
  //       fullUrl += singleQueryParam;
  //     }
  //
  //     final uri = Uri.parse(fullUrl);
  //
  //     final request = http.MultipartRequest(reqType.toUpperCase(), uri);
  //     request.headers.addAll(headers);
  //
  //     // 📝 Add normal fields
  //     body.forEach((key, value) {
  //       if (value is List || value is Map) {
  //         request.fields[key] = jsonEncode(value);
  //       } else {
  //         request.fields[key] = value?.toString() ?? '';
  //       }
  //     });
  //
  //     // 📁 Add single files
  //     for (var entry in files.entries) {
  //       final file = entry.value;
  //       if (file == null) continue;
  //
  //       final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
  //
  //       request.files.add(
  //         await http.MultipartFile.fromPath(
  //           entry.key,
  //           file.path,
  //           contentType: MediaType.parse(mimeType),
  //         ),
  //       );
  //     }
  //
  //     // 📁📁 Add multi-files correctly
  //     if (filesList != null && filesList.isNotEmpty) {
  //       for (var entry in filesList.entries) {
  //         final key = entry.key;
  //         final fileList = entry.value;
  //
  //         for (var file in fileList) {
  //           final mimeType =
  //               lookupMimeType(file.path) ?? 'application/octet-stream';
  //
  //           request.files.add(
  //             await http.MultipartFile.fromPath(
  //               "$key[]", // array format (most backend uses this)
  //               file.path,
  //               contentType: MediaType.parse(mimeType),
  //             ),
  //           );
  //         }
  //       }
  //     }
  //
  //     // Send request
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final json = jsonDecode(response.body);
  //       final result = fromJson(json);
  //
  //       if (onSuccess != null) onSuccess(result);
  //       if (showSuccessSnackBar) {
  //         CustomSnackBar.success(
  //           title: "Success",
  //           message: json["message"] ?? "Request completed successfully",
  //         );
  //       }
  //
  //       return result;
  //     } else {
  //       final msg = jsonDecode(response.body)['message'] ?? "Something went wrong";
  //       CustomSnackBar.error(msg);
  //       throw Exception(msg);
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

}
