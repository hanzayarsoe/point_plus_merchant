class ApiUrls {
  ApiUrls._();
  static late String baseUrl;
  static final String logIn = "/api/auth/login/branch";
  static final String logOut = "/api/auth/logout";
  static final String refresh = "/api/auth/refresh/token";
  static final String me = "/api/branch/me";
  static final String forgetPasswordSendOtp = "/api/auth/forgot-password/otp";
  static final String forgetPasswordVerifyOtp =
      "/api/auth/forgot-password/verify-otp";
  static final String forgetPasswordReset = "/api/auth/forgot-password/reset";
  static final String searchCustomerByAccountNumber =
      "/api/branch/customers/{accountNumber}";
  static final String givePointByAccountNumber =
      "/api/branch/points/give-by-account";
  static final String givePointByQr = "/api/branch/points/give-by-qr";
  static final String claimPointByAccountNumber =
      "/api/branch/points/claim-by-account";
  static final String claimPointByQr = "/api/branch/points/claim-by-qr";
  static final String updateManagerInfo = "/api/branch/me/manager";
  static final String changeMobileNumberSendOtp =
      "/api/branch/me/change-phone/send-otp";
  static final String changeMobileNumber = "/api/branch/me/change-phone";
  static final String changePassword = "/api/branch/me/change-password";
  static final String items = "/api/branch/items";
  static final String editBranchInfo = "/api/branch/me";
  static final String historyTransaction = "/api/branch/transactions/grouped";
  static final String transactionDetail = "/api/branch/transactions/{id}";
  static final String requestHistory = "/api/branch/point-requests/grouped";
  static final String requestPoints = "/api/branch/point-requests";
  static final String requestDetail = "/api/branch/point-requests/{id}";
  static final String noti = "/api/notifications/me/grouped";
  static final String manager = "/api/branch/me/manager";
  static final String registerToken = "/api/notifications/register-token";
  static final String unregisterToken = "/api/notifications/unregister-token";
  static final String unreadCount = "/api/notifications/me/unread-count";
  static final String readNoti = "/api/notifications/me/{notificationId}/read";
  static final String getDevices = "/api/{role}/devices";
}
