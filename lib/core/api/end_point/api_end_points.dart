class ApiEndPoints {
  static final mainDomain = 'http://10.10.20.52:6002';//http://10.10.20.52:6002
  static final baseUrl = '$mainDomain/';

  /// API End Points
  // Auth
  static const login = 'auth/login';
  static const register = 'auth/register';
  static const verifyEmail = 'auth/activate-account';
  static const resendOtpCode = 'auth/activation-code-resend';
  static const resetPassword = 'auth/reset-password';
  static const forgotPassword = 'auth/forgot-password';
  static const providerRegister = 'provider/provider-register';

  //home
  static const banner = 'banner/get';
  static const privacy = 'manage/get-privacy-policy';
  static const terms = 'manage/get-terms-conditions';
  static const allEbookGet = 'ebooks/get';
  static const getAllBookCategory = 'book-categories/get';
  static const singlePost = 'home/book';

  //user_category

  static const getAllCategory = 'category/active-categories';
  static const getFavoritesCategory = 'category/favorites';
  static const patchToggleToFavorites = 'category/toggle-to-favorites';
  static const getSubCategoriesByCategory = 'category/subcategories-by-category?categoryId=68c6f418136f3599e8c394b4';


  static const categoryPreview = 'categories/books';
  static const serviceCategory = 'category/active-categories';
  static const getAllAudioBook = 'audio-books/get';
  static const faqGet = 'manage/get-faq';

  //profile
  static const changePassword = 'auth/change-password';
  static const userProfile = 'user/profile';
  static const providerProfile = 'provider/profile';
  static const userUpdateProfile = 'user/edit-profile';
  static const providerUpdateProfile = 'provider/update-profile';
  static const deleteProfile = 'user/delete-account';

  //bookmark
  static const bookMark = 'home/save';
  static const bookMarkData = 'home/saved';
  static const userProgress = 'user-progress/continue';

  static final getTerms = '${baseUrl}manage/get-terms-conditions';
  static final getPrivacy = '${baseUrl}manage/get-privacy-policy';
  static final updateProviderLicence = '${baseUrl}provider/update-profile';

  static final categoryAll = '${baseUrl}category/active-categories';


  static String getServiceRequestAll({required int page}) {
    return '${baseUrl}service-requests/my-requests?page=$page';
  }

  static serviceCreate() => '${baseUrl}service-requests/create';

  static myService({required String status, required int page}) =>
      '${baseUrl}service-requests/my-requests?status=$status&page=$page&limit=20';


  static providerService({required String status, required int page}) =>
      '${baseUrl}provider/potential-requests?providerStatus=$status&page=$page&limit=20';

  static providerChangeStatus() => '${baseUrl}provider/handle-request';

  static notification({required int page}) =>
      '${baseUrl}notification/get-all-notifications?page=$page&limit=20';

  var notificationId = "";
  //====================Notification=========================
  static final getAllNotification = '${baseUrl}notification/get-all-notifications';
  static final getNotification = '${baseUrl}notification/get-notification?notificationId=notificationId';
  static final deleteNotification = '${baseUrl}notification/delete-notification';

  var reviewId = "";
  //=================Review=================================
  static final postPostReview = '${baseUrl}review/post-review';
  static final getAllReview = '${baseUrl}review/get-all-reviews';
  static final getReview = '${baseUrl}review/get-review?reviewId=reviewId';
  static final getReviewProvider = '${baseUrl}review/get-provider-reviews';

  var partnerId= "";
  var conversationId= "";
  var targetUserId = "";
  //============Conversation==============
  static final getConversation = '${baseUrl}chat/get-conversation?partnerId=partnerId';
  static final getConversationByID = '${baseUrl}chat/get-conversation/:conversationId';
  static final getConversationList = '${baseUrl}chat/get-conversation-list';
  static final getCheckBlockUnblock = '${baseUrl}chat/check-block/:targetUserId';


  var messageId = "";

  static final postBlockUser = '${baseUrl}chat/block/:targetUserId';
  static final postUnblockUser = '${baseUrl}chat/unblock/:targetUserId';
  static final postDeleteMessage = '${baseUrl}chat/delete-message/:messageId';
  static final postChatImageORVideo = '${baseUrl}chat/chat-images-video';
















}
