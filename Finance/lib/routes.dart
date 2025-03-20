import 'package:get/get.dart';
import 'package:lane_dane/view_models/auth_vm.dart';
import 'package:lane_dane/view_models/transaction_vm.dart';
import 'package:lane_dane/views/auth/enter_otp_screen.dart';
import 'package:lane_dane/views/auth/enter_phone_screen.dart';
import 'package:lane_dane/views/auth/user_registeration_view.dart';
import 'package:lane_dane/views/homeIndex.dart';
import 'package:lane_dane/views/introscreens/intro_main.dart';
import 'package:lane_dane/views/personal_transaction/index.dart';
import 'package:lane_dane/views/settings/settingIndex.dart';

// import 'views/pages/transaction/user_transaction_view.dart';

class AppRoutes {
  static const String introPage = '/intro/main';
  static const String enterPhoneNumber = '/auth/phone-number';
  static const String enterOtp = '/auth/otp';
  static const String homeIndex = '/home/allTransaction/index';
  static const String registration = '/auth/register';
  static const String transactionCreate = '/transaction/add_transaction';
  static const String smsList = '/sms/sms_list';
  static const String smsDetails = '/sms/sms_details';
  static const String smsLoading = '/sms/sms_loading';
  static const String settings = '/pages/settings/settingIndex';
  static const String chatScreen = '/pages/transaction/user_transaction_view';

  static List<GetPage<dynamic>> getPages = [
    // GetPage(name: '/', page: () => MyApp()),
    GetPage(
      name: smsList,
      page: () => const PersonalTnxIndex(),
    ),
    GetPage(
      name: smsList,
      page: () => const PersonalTnxIndex(),
    ),
    //GetPage(name: '/language', page: () => Home()),
    GetPage(name: introPage, page: () => IntroMain()),
    // GetPage(name: '/intro2', page: () => Home()),
    // GetPage(name: '/intro3', page: () => Home()),
    GetPage(name: settings, page: () => const Settings()),
    // GetPage(name: chatScreen, page: () => ChatScreen()),

    GetPage(
        name: enterPhoneNumber,
        page: () => const EnterPhoneNumber(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AuthVM>(() => AuthVM());
        })),

    GetPage(
        name: enterOtp,
        page: () => const EnterOtpScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AuthVM>(() => AuthVM());
        })),
    GetPage(
        name: registration,
        page: () => UserRegistrationView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AuthVM>(() => AuthVM());
        })),
    GetPage(
        name: homeIndex,
        page: () => const HomeIndex(),
        binding: BindingsBuilder(() {
          Get.lazyPut<TransactionVM>(() => TransactionVM());
        })),

    /*   GetPage(
        name: transactionCreate,
        page: () => AddTransaction(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => TransactionVM());
        })), */
    GetPage(
      name: smsLoading,
      page: () => const PersonalTnxLoading(),
    ),
    // GetPage(
    //     name: smsDetails,
    //     page: () => PersonalTransactionDetails(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => TransactionVM());
    //     })),

    // GetPage(
    //   name: '/business',
    //   page: () => BusinessView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<BuisenessVM>(() => BuisenessVM());
    //   })
    // ),
    // GetPage(
    //   name: '/sms/index',
    //   page: () => SmsIndexView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<AllSmsVM>(() => AllSmsVM());
    //   })
    // ),
    // GetPage(
    //   name: '/sms/show',
    //   page: () => SmsView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<AllSmsVM>(() => AllSmsVM());
    //   })
    // ),
    // GetPage(
    //   name: '/transaction/index',
    //   page: () => TransactionIndexView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<AgregateTransactionVM>(() => AgregateTransactionVM());
    //   })
    // ),
    // GetPage(
    //   name: '/transaction/:user/user',
    //   page: () => UserTransactionsView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<UserTransactionVM>(() => UserTransactionVM());
    //   })
    // ),
    // GetPage(
    //   name: '/transaction/:transaction/show',
    //   page: () => TransactionView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<TransactionVM>(() => TransactionVM());
    //   })
    // ),
    // GetPage(
    //     name: transactionCreate,
    //     page: () => const TransactionCreateView(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut<TransactionVM>(() => TransactionVM());
    //     })),
    // GetPage(
    //   name: '/profile',
    //   page: () => ProfileView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<ProfileVM>(() => ProfileVM());
    //   })
    // ),
    // GetPage(
    //   name: '/profile/:user',
    //   page: () => ProfileView(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<ProfileVM>(() => ProfileVM());
    //   })
    // ),
    // GetPage(name: '/feedback', page: () => Home()),
    // GetPage(name: '/help', page: () => Home()),
  ];
}
