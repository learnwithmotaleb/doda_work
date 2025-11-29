import 'package:get_storage/get_storage.dart';
import 'app_storage_model.dart';

class AppStorage {
  static final GetStorage _storage = GetStorage();

  static const String tokenKey = 'token';
  static const String temporaryTokenKey = 'temporaryToken';
  static const String mobileCodeKey = 'mobileCode';
  static const String onboardSaveKey = 'onboardSave';
  static const String isLoggedInKey = 'isLoggedIn';
  static const String isEmailVerifiedKey = 'isEmailVerified';
  static const String isKycVerifiedKey = 'isKycVerified';
  static const String isSmsVerifiedKey = 'isSmsVerified';
  static const String kycStatusKey = 'isKycStatus';
  static const String isVendorKey =  'isVendor';

  static Future<void> save({
    String? token,
    String? temporaryToken,
    String? mobileCode,
    bool? onboardSave,
    bool? isLoggedIn,
    bool? isEmailVerified,
    bool? isKycVerified,
    bool? isSmsVerified,
    bool? isKycStatus,
    bool? isVendor
  }) async {
    // ✅ Robust token save: remove unwanted quotes and spaces
    if (token != null) await _storage.write(tokenKey, token.replaceAll('"', '').trim());
    if (temporaryToken != null) await _storage.write(temporaryTokenKey, temporaryToken);
    if (mobileCode != null) await _storage.write(mobileCodeKey, mobileCode);
    if (onboardSave != null) await _storage.write(onboardSaveKey, onboardSave);
    if (isLoggedIn != null) await _storage.write(isLoggedInKey, isLoggedIn);
    if (isEmailVerified != null) await _storage.write(isEmailVerifiedKey, isEmailVerified);
    if (isKycVerified != null) await _storage.write(isKycVerifiedKey, isKycVerified);
    if (isSmsVerified != null) await _storage.write(isSmsVerifiedKey, isSmsVerified);
    if (isKycStatus != null) await _storage.write(kycStatusKey, isKycStatus);
    if (isVendor != null) await _storage.write(isVendorKey, isVendor);
  }

  // ✅ Robust token read: always trim to avoid extra spaces
  static String get token => (_storage.read(tokenKey) ?? '').trim();
  static String get temporaryToken => _storage.read(temporaryTokenKey) ?? '';
  static String get mobileCode => _storage.read(mobileCodeKey) ?? '';
  static bool get isLoggedIn => _storage.read(isLoggedInKey) ?? false;
  static bool get onboardSave => _storage.read(onboardSaveKey) ?? false;
  static bool get isKycVerified => _storage.read(isKycVerifiedKey) ?? false;
  static bool get isEmailVerified => _storage.read(isEmailVerifiedKey) ?? false;
  static bool get isSmsVerified => _storage.read(isSmsVerifiedKey) ?? false;
  static bool get isKycStatus => _storage.read(kycStatusKey) ?? false;
  static bool get isVendor => _storage.read(isVendorKey)?? false;

  static AppStorageModel get common {
    return AppStorageModel(
      token,
      onboardSave,
      isLoggedIn,
      isEmailVerified,
      isKycVerified,
      isSmsVerified,
      isKycStatus ? 1 : 0, // keep same as before
      temporaryToken: temporaryToken,
      mobileCode: mobileCode,
    );
  }

  static bool get seenOnboarding => _storage.read(onboardSaveKey) ?? false;
  static set seenOnboarding(bool value) => _storage.write(onboardSaveKey, value);

  static Future<void> clear() async {
    await _storage.erase();
  }
}
