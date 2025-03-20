/// -> Connstant domain for the http request
library;

// ignore_for_file: constant_identifier_names

class Constants {
// const String DOMAIN = 'http://192.168.0.12:3363';
// const String host = 'http://localhost:8000';
// String domain = 'http://172.20.10.2:3363';

//* @suhailbilalo Local IP
// String host = 'http://192.168.100.32:8000';

//* Main Server
  static String kHost = 'lane-dane.com';

//* @Abood2284 Local IP
// String host = 'http://192.168.0.12:8080';
  // static String kHost = 'http://lane-dane.test:8080';
  // static String kHost = 'http://10.0.2.2:8000'; // for emulator

// *@abdulaziz local IP
  // static String host = 'localhost:8000';

  /// Make this false when running on a local server. Otherwise true when running
  /// on main server.
  static bool get defaultToHttps {
    if (Constants.kHost == 'lane-dane.com') {
      return true;
    } else {
      return false;
    }
    // return false;
  }

  /// -> Constant variable for SMS BANK SENDER

  static String kRouteToPrivacyPolicy = 'privacy-policy';
  static String kRouteToTermsOfServices = 'term-of-services';

  static String kCanaraBank = "AX-CANBNK";
  static String kIcicicBank = "VM-ICICIB";
  static String kHdfcBank = "AM-HDFCBK";
  static String kSbiBank =
      "BZ-SBIINB"; // TODO: Look for sbiiinb in sender name instead of static BZ

// REGEXP Used
  static String kRegexpAmount =
      r"(Rs|rs|INR).[\d,.]*\b"; // TODO: Get this Regexp implemented & working (Rs|rs|INR).[\d,.]*\b

  /// Checks that account number starts with a whitepsace character.
  /// Then checks that the first few characters are X.
  /// This should be followed by 2-5 digits.
  // static String REGEXP_ACCOUNTNUMBER = r"([X\*]+|(\.\.)+)\d{2,5}";
  static String kRegexpAccountNumber = r"\s(X+\d{2,5})";
  // ! Replaced on  29 Jan 2023
  //  r"([Xx\*]+|(\.\.)+)\d{2,5}";
// const String REGEXP_DATE =
// r"(\d+\s*(\-|\/)\s*(\w+|\d+)\s*(\-|\/)\s*(\d+)\s*(\d*\:\d+\:\d+)*)";

  static String kTwitterLink = 'https://twitter.com/iam_abdulR';

  static String kAppLink =
      'https://play.google.com/store/apps/details?id=com.lane_dane.lane_dane';
  static String kWhatsappCustomerSupportGroup =
      'https://chat.whatsapp.com/DPJyhAlihvOEBUmTjbDIBb';
}
