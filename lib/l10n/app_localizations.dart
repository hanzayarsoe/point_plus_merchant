import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my')
  ];

  /// No description provided for @pointPlus.
  ///
  /// In en, this message translates to:
  /// **'Point Plus'**
  String get pointPlus;

  /// No description provided for @pts.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get pts;

  /// No description provided for @pointBalance.
  ///
  /// In en, this message translates to:
  /// **'Points Balance'**
  String get pointBalance;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome To Point Plus'**
  String get welcome;

  /// No description provided for @getReward.
  ///
  /// In en, this message translates to:
  /// **'Get rewarded for your loyalty. Earn points at all your favourite places.'**
  String get getReward;

  /// No description provided for @earnPoint.
  ///
  /// In en, this message translates to:
  /// **'Earn Points Everywhere'**
  String get earnPoint;

  /// No description provided for @shopAnyWhere.
  ///
  /// In en, this message translates to:
  /// **'Shop anywhere in our network, collect points from every purchase.'**
  String get shopAnyWhere;

  /// No description provided for @spend.
  ///
  /// In en, this message translates to:
  /// **'Spend Them Anywhere'**
  String get spend;

  /// No description provided for @spendAnywhere.
  ///
  /// In en, this message translates to:
  /// **'Use your points at any merchants you like — your rewards travel with you.'**
  String get spendAnywhere;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @logInHere.
  ///
  /// In en, this message translates to:
  /// **'Log in here'**
  String get logInHere;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @letSetUpYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Let’s set up your account!'**
  String get letSetUpYourAccount;

  /// No description provided for @enterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number. We’ll send a one-time verification code there.'**
  String get enterYourPhoneNumber;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @verifyYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get verifyYourNumber;

  /// No description provided for @checkYourMessageForOneTimeCode.
  ///
  /// In en, this message translates to:
  /// **'Check your messages for a one-time verification code. Enter it here to continue.'**
  String get checkYourMessageForOneTimeCode;

  /// No description provided for @noReceiveOtpCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the OTP code?'**
  String get noReceiveOtpCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @tryAgainIn.
  ///
  /// In en, this message translates to:
  /// **'Try again in {seconds} sec'**
  String tryAgainIn(Object seconds);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enterVerificationCode;

  /// No description provided for @lefCreateYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Let’s create your profile!'**
  String get lefCreateYourProfile;

  /// No description provided for @justFewDetailToGetYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Jus a few details to get your account set up.'**
  String get justFewDetailToGetYourAccount;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name *'**
  String get name;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email (optional)'**
  String get email;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender *'**
  String get gender;

  /// No description provided for @selectYourGender.
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get selectYourGender;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passwordDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Password must be same'**
  String get passwordDoNotMatch;

  /// No description provided for @haveReadAndAgree.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to the '**
  String get haveReadAndAgree;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms And Conditions'**
  String get termsAndConditions;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @passwordRecovery.
  ///
  /// In en, this message translates to:
  /// **'password Recovery'**
  String get passwordRecovery;

  /// No description provided for @enterYourMobileNumberToResetYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number to reset your password.'**
  String get enterYourMobileNumberToResetYourPassword;

  /// No description provided for @enteryYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get enteryYourMobileNumber;

  /// No description provided for @enterYourEmailToResetYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to reset your password.'**
  String get enterYourEmailToResetYourPassword;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @rememberYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberYourPassword;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @resetWithYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Reset with your email'**
  String get resetWithYourEmail;

  /// No description provided for @resetWithYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Reset with your mobile number'**
  String get resetWithYourMobileNumber;

  /// No description provided for @checkYourInbox.
  ///
  /// In en, this message translates to:
  /// **'Check Your Inbox'**
  String get checkYourInbox;

  /// No description provided for @sentToYourEamilOrPhone.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a code to {phoneOrEmail}. Please enter it below to reset your password.'**
  String sentToYourEamilOrPhone(Object phoneOrEmail);

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @pleaseCreateNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please create a new password for your account.'**
  String get pleaseCreateNewPassword;

  /// No description provided for @enterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Current Password'**
  String get enterCurrentPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @passwordUpdate.
  ///
  /// In en, this message translates to:
  /// **'Password Updated'**
  String get passwordUpdate;

  /// No description provided for @passwordSuccessfullyUpdate.
  ///
  /// In en, this message translates to:
  /// **'Your password has been successfully updated. Sign in with your new password.'**
  String get passwordSuccessfullyUpdate;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccount_confirmBoxLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete Your Account?'**
  String get deleteAccount_confirmBoxLabel;

  /// No description provided for @deleteAccount_confrimBoxText.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent and will delete all your data and points. Are you sure you want to delete your account?'**
  String get deleteAccount_confrimBoxText;

  /// No description provided for @deleteAccount_confrimBoxDeleteButtonText.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAccount_confrimBoxDeleteButtonText;

  /// No description provided for @deleteAccount_confrimBoxCancelButtonText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deleteAccount_confrimBoxCancelButtonText;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @homeScreen_earn.
  ///
  /// In en, this message translates to:
  /// **'Earn'**
  String get homeScreen_earn;

  /// No description provided for @homeScreen_redeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get homeScreen_redeem;

  /// No description provided for @homeScreen_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get homeScreen_history;

  /// No description provided for @homeScreen_popularMerchants.
  ///
  /// In en, this message translates to:
  /// **'Popular Merchants'**
  String get homeScreen_popularMerchants;

  /// No description provided for @homeScreen_promoAndRewards.
  ///
  /// In en, this message translates to:
  /// **'Promo & Rewards'**
  String get homeScreen_promoAndRewards;

  /// No description provided for @homeScreen_expiresOn.
  ///
  /// In en, this message translates to:
  /// **'Expires on {date}'**
  String homeScreen_expiresOn(Object date);

  /// No description provided for @homeScreen_pts.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String homeScreen_pts(Object points);

  /// No description provided for @homerScreen_recentMerchantOffers.
  ///
  /// In en, this message translates to:
  /// **'Recent Merchant Offers'**
  String get homerScreen_recentMerchantOffers;

  /// No description provided for @homeScreen_rewardDetails.
  ///
  /// In en, this message translates to:
  /// **'Reward Detail'**
  String get homeScreen_rewardDetails;

  /// No description provided for @homeScreen_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get homeScreen_description;

  /// No description provided for @homeScreen_notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get homeScreen_notification;

  /// No description provided for @homeScreen_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get homeScreen_today;

  /// No description provided for @homeScreen_mostRecent.
  ///
  /// In en, this message translates to:
  /// **'Most Recent'**
  String get homeScreen_mostRecent;

  /// No description provided for @rewardScreen_reward.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get rewardScreen_reward;

  /// No description provided for @rewardScreen_allRewards.
  ///
  /// In en, this message translates to:
  /// **'All Rewards'**
  String get rewardScreen_allRewards;

  /// No description provided for @rewardScreen_rewardsYouCanClaimNow.
  ///
  /// In en, this message translates to:
  /// **'Rewards You Can Claim Now'**
  String get rewardScreen_rewardsYouCanClaimNow;

  /// No description provided for @rewardScreen_rewardNow.
  ///
  /// In en, this message translates to:
  /// **'Reward Now'**
  String get rewardScreen_rewardNow;

  /// No description provided for @rewardScreen_recommendedRewards.
  ///
  /// In en, this message translates to:
  /// **'Recommended Rewards'**
  String get rewardScreen_recommendedRewards;

  /// No description provided for @rewardScreen_rewardsNearYou.
  ///
  /// In en, this message translates to:
  /// **'Rewards Near You'**
  String get rewardScreen_rewardsNearYou;

  /// No description provided for @walletScreen_wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletScreen_wallet;

  /// No description provided for @walletScreen_earnPoints.
  ///
  /// In en, this message translates to:
  /// **'Earn Points'**
  String get walletScreen_earnPoints;

  /// No description provided for @walletScreen_redeemPoints.
  ///
  /// In en, this message translates to:
  /// **'Redeem Points'**
  String get walletScreen_redeemPoints;

  /// No description provided for @walletScreen_pointsBalance.
  ///
  /// In en, this message translates to:
  /// **'Points Balance'**
  String get walletScreen_pointsBalance;

  /// No description provided for @walletScreen_scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get walletScreen_scanQrCode;

  /// No description provided for @walletScreen_scanThisQrCodeToEarn.
  ///
  /// In en, this message translates to:
  /// **'Scan this QR code at the merchant to earn points'**
  String get walletScreen_scanThisQrCodeToEarn;

  /// No description provided for @walletScreen_cannotScan.
  ///
  /// In en, this message translates to:
  /// **'Can’t scan? Use your account number'**
  String get walletScreen_cannotScan;

  /// No description provided for @walletScreen_yourAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Your Account Number'**
  String get walletScreen_yourAccountNumber;

  /// No description provided for @walletScreen_points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get walletScreen_points;

  /// No description provided for @walletScreen_enterPoints.
  ///
  /// In en, this message translates to:
  /// **'Enter points'**
  String get walletScreen_enterPoints;

  /// No description provided for @walletScreen_forYourSecurityEnterPassowrd.
  ///
  /// In en, this message translates to:
  /// **'For your security, please enter your password to confirm this redemption.'**
  String get walletScreen_forYourSecurityEnterPassowrd;

  /// No description provided for @walletScreen_redeemingPts.
  ///
  /// In en, this message translates to:
  /// **'Redeeming {points} pts.'**
  String walletScreen_redeemingPts(Object points);

  /// No description provided for @walletScreen_codeExpireTime.
  ///
  /// In en, this message translates to:
  /// **'Code expires in {time}'**
  String walletScreen_codeExpireTime(Object time);

  /// No description provided for @walletScreen_codeExpired.
  ///
  /// In en, this message translates to:
  /// **'Code expired'**
  String get walletScreen_codeExpired;

  /// No description provided for @walletScreen_getNewCode.
  ///
  /// In en, this message translates to:
  /// **'Get New Code'**
  String get walletScreen_getNewCode;

  /// No description provided for @merchantScreen_merchants.
  ///
  /// In en, this message translates to:
  /// **'Merchants'**
  String get merchantScreen_merchants;

  /// No description provided for @merchantScreen_branches.
  ///
  /// In en, this message translates to:
  /// **'Branches'**
  String get merchantScreen_branches;

  /// No description provided for @merchantScreen_rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get merchantScreen_rewards;

  /// No description provided for @merchantScreen_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get merchantScreen_about;

  /// No description provided for @profileScreen_header.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileScreen_header;

  /// No description provided for @profileScreen_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileScreen_account;

  /// No description provided for @profileScreen_personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get profileScreen_personalInformation;

  /// No description provided for @profileScreen_changeMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Change Mobile Number'**
  String get profileScreen_changeMobileNumber;

  /// No description provided for @profileScreen_changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileScreen_changePassword;

  /// No description provided for @profileScreen_appSetting.
  ///
  /// In en, this message translates to:
  /// **'App Setting'**
  String get profileScreen_appSetting;

  /// No description provided for @profileScreen_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileScreen_language;

  /// No description provided for @profileScreen_pushNotification.
  ///
  /// In en, this message translates to:
  /// **'Push Notification'**
  String get profileScreen_pushNotification;

  /// No description provided for @profileScreen_legalAndInfo.
  ///
  /// In en, this message translates to:
  /// **'Legal & Info'**
  String get profileScreen_legalAndInfo;

  /// No description provided for @profileScreen_termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms And Conditions'**
  String get profileScreen_termsAndConditions;

  /// No description provided for @profileScreen_aboutPointPlus.
  ///
  /// In en, this message translates to:
  /// **'About Point Plus'**
  String get profileScreen_aboutPointPlus;

  /// No description provided for @profileScreen_chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get profileScreen_chooseLanguage;

  /// No description provided for @mobileNumber_validation_empty.
  ///
  /// In en, this message translates to:
  /// **'Phone number must not be empty'**
  String get mobileNumber_validation_empty;

  /// No description provided for @mobileNubmer_validation_length.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get mobileNubmer_validation_length;

  /// No description provided for @mobileNubmer_validation_alreadyExist.
  ///
  /// In en, this message translates to:
  /// **'An account with this number already exist'**
  String get mobileNubmer_validation_alreadyExist;

  /// No description provided for @profileScreen_editPersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'Edit Personal Information'**
  String get profileScreen_editPersonalInformation;

  /// No description provided for @profileScreen_confirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Password'**
  String get profileScreen_confirmYourPassword;

  /// No description provided for @profileScreen_forSecurityEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'For your security, please enter your password to confirm that you want to edit your personal information.'**
  String get profileScreen_forSecurityEnterPassword;

  /// No description provided for @profileScreen_changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes Saved'**
  String get profileScreen_changesSaved;

  /// No description provided for @profileScreen_changeYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Change your mobile number'**
  String get profileScreen_changeYourMobileNumber;

  /// No description provided for @profileScreen_enterYourNewMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your new mobile number. We will send a verification code to it to confirm the change.'**
  String get profileScreen_enterYourNewMobileNumber;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'my': return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
