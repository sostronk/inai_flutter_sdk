class InaiCryptoPurchaseDetails {
  String token;
  String cryptoCurrency;
  String amount;
  String currency;
  String countryCode;
  String paymentMethodOption;

  InaiCryptoPurchaseDetails({
    required this.token,
    required this.cryptoCurrency,
    required this.amount,
    required this.countryCode,
    required this.currency,
    required this.paymentMethodOption,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["token"] = token;
    json["cryptoCurrency"] = cryptoCurrency;
    json["amount"] = amount;
    json["currency"] = currency;
    json["countryCode"] = countryCode;
    json["paymentMethodOption"] = paymentMethodOption;
    return json;
  }
}
