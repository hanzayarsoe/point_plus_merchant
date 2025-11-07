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
}
