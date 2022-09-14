// import 'package:velocity_x/velocity_x.dart';

class Api {
  static String get baseUrl {
    return "https://ojol.arthopay.id/api";
    // return "https://ojoldev.arthopay.id/api";
    // return "http://192.168.8.168:8000/api";
  }

  static String get baseUrlArtho {
    return "https://arthopay.id/api";
  }

  static String get baseUrlPPOB {
    return "https://ppob.arthopay.id/index.php/api/";
  }

  static const appSettings = "/app/settings";

  static const login = "/login";
  static const qrlogin = "/login/qrcode";
  static const register = "/register";
  static const logout = "/logout";
  static const forgotPassword = "/password/reset/init";
  static const verifyPhoneAccount = "/verify/phone";
  static const updateProfile = "/profile/update";
  static const updatePassword = "/profile/password/update";
  //
  static const sendOtp = "/otp/send";
  static const verifyOtp = "/otp/verify";
  static const verifyFirebaseOtp = "/otp/firebase/verify";
  static const socialLogin = "/social/login";

  //
  static const banners = "/banners";
  static const categories = "/categories";
  static const subcategories = "/subcategories";
  static const products = "/products";
  static const services = "/services";
  static const bestProducts = "/products?type=best";
  static const forYouProducts = "/products?type=you";
  static const vendorTypes = "/vendor/types";
  static const vendors = "/vendors";
  static const vendorReviews = "/vendor/reviews";
  static const topVendors = "/vendors?type=top";
  static const bestVendors = "/vendors?type=best";

  static const search = "/search";
  static const tags = "/tags";
  static const searchData = "/search/data";
  static const favourites = "/favourites";

  //cart & checkout
  static const coupons = "/coupons";
  static const deliveryAddresses = "/delivery/addresses";
  static const paymentMethods = "/payment/methods";
  static const orders = "/orders";
  static const trackOrder = "/track/order";
  static const packageOrders = "/package/orders";
  static const packageOrderSummary = "/package/order/summary";
  static const generalOrderSummary = "/general/order/summary";
  static const chat = "/chat/notification";
  static const rating = "/rating";
  static const urlPaymentOrders = "/order/payment";

  //packages
  static const packageTypes = "/package/types";

  //Taxi booking
  static const vehicleTypes = "/vehicle/types";
  static const vehicleTypePricing = "/vehicle/types/pricing";
  static const newTaxiBooking = "/taxi/book/order";
  static const currentTaxiBooking = "/taxi/current/order";
  static const cancelTaxiBooking = "/taxi/order/cancel";
  static const taxiDriverInfo = "/taxi/driver/info";
  static const taxiLocationAvailable = "/taxi/location/available";

  //wallet
  static const walletBalance = "/wallet/balance";
  static const walletTopUp = "/wallet/topup";
  static const walletTransactions = "/wallet/transactions";
  static const myWalletAddress = "/wallet/my/address";
  static const walletAddressesSearch = "/wallet/address/search";
  static const walletTransfer = "/wallet/address/transfer";

  //map
  static const geocoderForward = "/geocoder/forward";
  static const geocoderReserve = "/geocoder/reserve";

  //reviews
  static const productReviewSummary = "/product/review/summary";
  static const productReviews = "/product/reviews";
  static const productBoughtFrequent = "/product/frequent";

  //gym
  static const allCategory = "/subcategories";

  //ppob
  static const prabayar = "/Order_Prabayar/Kategori";
  static const operatorprabayar = "/Order_Prabayar/operator";
  static const produkprabayar = "/Order_Prabayar/product";
  static const payPrabayar = "Order_Prabayar/pay_prabayar";
  static const pascabayar = "Order_Pascabayar/kategori";
  static const produkPascabayar = "Order_Pascabayar/product";
  static const orderPascabayar = "Order_Pascabayar/order_pascabayar";
  static const payPascabayar = "Order_Pascabayar/pay_pascabayar";

  // Other pages
  static String get privacyPolicy {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/privacy/policy";
  }

  static String get terms {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/pages/terms";
  }

  static String get contactUs {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/pages/contact";
  }

  static String get inappSupport {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/support/chat";
  }

  static String get appShareLink {
    final webUrl = baseUrl.replaceAll('/api', '');
    return "$webUrl/preview/share";
  }
}
