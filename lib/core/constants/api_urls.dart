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
}
