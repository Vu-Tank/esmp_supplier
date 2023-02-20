class AppUrl {
  static const String baseUrl =
      'https://esmpfree-001-site1.etempurl.com/api'; //hosting

  static const String checkExistUser = '$baseUrl/user/check_user';

  static const String supplierRegister = '$baseUrl/user/supplier_register';

  static const String login = '$baseUrl/user/suppliersign_in';

  static const String refeshtoken = '$baseUrl/user/refeshtoken';

  static const String province = '$baseUrl/Address/provine';

  static const String district = '$baseUrl/Address/district';

  static const String ward = '$baseUrl/Address/ward';

  static const String registerStore = '$baseUrl/Store/register';

  static const String loginStore = '$baseUrl/Store/login_store';

  static const String getPriceActice = '$baseUrl/Store/get_price_actice';

  static const String storePayment = '$baseUrl/Payment/momo_store_pay';
}
