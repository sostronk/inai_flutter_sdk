import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inai_flutter_sdk/inai_flutter_sdk.dart';
import 'package:pay/pay.dart';
import 'dart:async';
import './inai_config.dart';
import './inai_checkout_widget.dart';
import 'dart:io' show Platform;

enum GooglePayEnvironment { TEST, PRODUCTION }

extension ParseToString on GooglePayEnvironment {
  String toShortString() {
    return toString().split('.').last;
  }
}

class InaiGooglePayRequestData {
  Pay? payClient;
  bool userCanPay = false;
  var currencyCode = "";
  var countryCode = "";
  var merchantName = "";
  var merchantId = "";
  var productDescription = "";
  var orderAmount = "";
  List<dynamic> supportedNetworks = [];
  List<dynamic> supportedMethods = [];
  Map<String, dynamic> tokenization = {};
  List<PaymentItem> paymentItems = [];
}

class InaiApplePayRequest {
  Pay? payClient;
  bool userCanPay = false;
  dynamic applePayPaymentMethod;
}

class InaiCheckout {
  static const googlePay = "google_pay";
  static const applePayProviderKey = "apple_pay";
  InaiConfig _config = InaiConfig(token: "");

  // constructor
  InaiCheckout(InaiConfig config) {
    if (config.token.isEmpty) {
      throw Exception('Invalid config');
    }

    _config = config;
  }

  Future<InaiResult> presentCheckout({required BuildContext context}) async {
    InaiCheckoutWidget checkoutWidget = InaiCheckoutWidget(
        config: _config, checkoutMode: InaiCheckoutMode.payment);

    if (Platform.isAndroid){
        return await _showCheckoutWidget(context, checkoutWidget,false);
      }else{
        return await _showCheckoutWidget(context, checkoutWidget,true);
      }

  }

  Future<InaiResult> addPaymentMethod(
      {required String type, required BuildContext context}) async {
    InaiCheckoutWidget checkoutWidget = InaiCheckoutWidget(
      config: _config,
      checkoutMode: InaiCheckoutMode.addPaymentMethod,
      paymentMethodType: type,
    );

    if (Platform.isAndroid) {
      return await _showCheckoutWidget(context, checkoutWidget, false);
    } else {
      return await _showCheckoutWidget(context, checkoutWidget, true);
    }
  }

  Future<InaiResult> presentPayWithPaymentMethod(
      {required String paymentMethodId, required BuildContext context}) async {
    InaiCheckoutWidget checkoutWidget = InaiCheckoutWidget(
      config: _config,
      checkoutMode: InaiCheckoutMode.payWithPaymentMethod,
      paymentMethodId: paymentMethodId,
    );

    if (Platform.isAndroid) {
      return await _showCheckoutWidget(context, checkoutWidget, false);
    } else {
      return await _showCheckoutWidget(context, checkoutWidget, true);
    }
  }

  Future<InaiResult> makePayment(
      {required String paymentMethodOption,
      required BuildContext context,
      required Map<String, dynamic> paymentDetails}) async {
    InaiCheckoutWidget checkoutWidget = InaiCheckoutWidget(
      config: _config,
      checkoutMode: InaiCheckoutMode.payHeadless,
      paymentMethodOption: paymentMethodOption,
      paymentDetails: paymentDetails,
    );

    if (Platform.isAndroid) {
      return await _showCheckoutWidget(context, checkoutWidget, false);
    } else {
      return await _showCheckoutWidget(context, checkoutWidget, true);
    }
  }

  Future<InaiResult> validateFields(
      {required String paymentMethodOption,
      required BuildContext context,
      required Map<String, dynamic> paymentDetails}) async {
    InaiCheckoutWidget checkoutWidget = InaiCheckoutWidget(
      config: _config,
      checkoutMode: InaiCheckoutMode.validateFields,
      paymentMethodOption: paymentMethodOption,
      paymentDetails: paymentDetails,
    );
    return await _showCheckoutWidgetInvisible(context, checkoutWidget);
  }

  Future<InaiResult> getCardInfo(
      {required String cardNumber, required BuildContext context}) async {
    InaiCheckoutWidget checkoutWidget = InaiCheckoutWidget(
        config: _config,
        checkoutMode: InaiCheckoutMode.getCardInfo,
        cardNumber: cardNumber);
    return await _showCheckoutWidgetInvisible(context, checkoutWidget);
  }

  Future<InaiGooglePayRequestData> initGooglePlay(
      Map<String, dynamic> paymentMethodMap,
      GooglePayEnvironment environment) async {
    Pay _payClient;

    dynamic configs = paymentMethodMap["configs"];

    List<dynamic> supportedMethods = configs["supported_methods"];
    List<dynamic> supportedNetworks = configs["supported_networks"];
    List<String> allowedAuthMethods = [];
    List<String> allowedCardNetworks = [];

    for (var supportedMethod in supportedMethods) {
      allowedAuthMethods.add(supportedMethod);
    }

    for (var supportedNetwork in supportedNetworks) {
      allowedCardNetworks.add(supportedNetwork["name"]);
    }

    Map<String, List<String>> parameters = {};
    parameters["allowedAuthMethods"] = allowedAuthMethods;
    parameters["allowedCardNetworks"] = allowedCardNetworks;

    Map<String, dynamic> allowedPaymentMethod = {};
    allowedPaymentMethod["type"] = "CARD";
    allowedPaymentMethod["parameters"] = parameters;
    allowedPaymentMethod["tokenizationSpecification"] = configs["tokenization"];

    Map<String, String> transactionInfo = {};
    transactionInfo["totalPrice"] = configs["order_amount"];
    transactionInfo["totalPriceStatus"] = "FINAL";
    transactionInfo["currencyCode"] = configs["currency_code"];
    transactionInfo["countryCode"] = configs["country_code"];

    Map<String, String> merchantInfo = {};
    merchantInfo["merchantId"] = configs["merchant_id"];
    if (configs["merchant_name"] != null) {
      merchantInfo["merchantName"] = configs["merchant_name"];
    }

    Map<String, dynamic> data = {};
    data["environment"] = environment.toShortString();
    data["apiVersion"] = 2;
    data["apiVersionMinor"] = 0;
    data["allowedPaymentMethods"] = [allowedPaymentMethod];
    data["transactionInfo"] = transactionInfo;
    data["merchantInfo"] = merchantInfo;

    Map<String, dynamic> paymentConfigurationMap = {};

    paymentConfigurationMap["provider"] = googlePay;

    paymentConfigurationMap["data"] = data;

    String paymentConfigurationJsonString =
        json.encode(paymentConfigurationMap);

    // _configurations.add(PaymentConfiguration.fromJsonString(paymentConfigurationJsonString));

    Map<PayProvider, PaymentConfiguration> _goolePayConfig = {};

    _goolePayConfig[PayProvider.google_pay] =
        PaymentConfiguration.fromJsonString(paymentConfigurationJsonString);

    _payClient = Pay(_goolePayConfig);

    bool userCanPay = await _payClient.userCanPay(PayProvider.google_pay);
    InaiGooglePayRequestData requestData = InaiGooglePayRequestData();
    requestData.userCanPay = userCanPay;
    if (userCanPay) {
      requestData.payClient = _payClient;
      requestData.orderAmount = configs["order_amount"];
      requestData.currencyCode = configs["currency_code"];
      requestData.countryCode = configs["country_code"];
      requestData.supportedNetworks = configs["supported_networks"];
      requestData.supportedMethods = configs["supported_methods"];
      requestData.tokenization = configs["tokenization"];
      requestData.paymentItems.add(PaymentItem(
          amount: configs["order_amount"],
          label: "TOTAL",
          status: PaymentItemStatus.final_price));
    }
    return requestData;
  }

  Map<String, dynamic> getGooglePayRequestData(
      Map<String, dynamic> paymentData) {
    String tokenString =
        paymentData["paymentMethodData"]["tokenizationData"]["token"];
    dynamic tokenObject = jsonDecode(tokenString);
    Map<String, dynamic> googlePayRequestData = {
      "fields": [],
      googlePay: tokenObject
    };

    return googlePayRequestData;
  }

  static Future<InaiApplePayRequest> initApplePayRequest(
      List<dynamic> paymentMethods) async {
    var inaiApplePayRequest = InaiApplePayRequest();

    Map<String, dynamic>? applePayPaymentMethod = paymentMethods.firstWhere(
        (element) => element["rail_code"] == applePayProviderKey,
        orElse: () => null);

    if (applePayPaymentMethod != null) {
      inaiApplePayRequest.applePayPaymentMethod = applePayPaymentMethod;
      dynamic configs = applePayPaymentMethod["configs"];
      var merchantId = configs["merchant_identifier"];
      var productDescription = configs["product_description"];

      var supportedNetworksMaps = configs["supported_networks"];
      var supportedNetworks = [];
      for (var supportedNetworkMap in supportedNetworksMaps) {
        supportedNetworks
            .add(supportedNetworkMap["name"].toString().toLowerCase());
      }

      var countryCode = configs["country_code"];
      var currencyCode = configs["currency_code"];

      var paymentConfigurationMap = {
        "provider": applePayProviderKey,
        "data": {
          "merchantIdentifier": merchantId,
          "displayName": productDescription,
          "merchantCapabilities": ["3DS", "debit", "credit"],
          "supportedNetworks": supportedNetworks,
          "countryCode": countryCode,
          "currencyCode": currencyCode,
          "requiredBillingContactFields": null,
          "requiredShippingContactFields": null
        }
      };

      String paymentConfigurationJsonString =
          json.encode(paymentConfigurationMap);

      Map<PayProvider, PaymentConfiguration> _applePayConfig = {};

      _applePayConfig[PayProvider.apple_pay] =
          PaymentConfiguration.fromJsonString(paymentConfigurationJsonString);

      inaiApplePayRequest.payClient = Pay(_applePayConfig);

      var payClient = inaiApplePayRequest.payClient;

      if (payClient != null) {
        inaiApplePayRequest.userCanPay =
            await payClient.userCanPay(PayProvider.apple_pay);
      }
    }

    return inaiApplePayRequest;
  }

  String getPaymentMethodString(String paymentMethodType) {
    String paymentMethodString = "unknown";

    switch (paymentMethodType) {
      case "0":
        break;
      case "1":
        paymentMethodString = "debit";
        break;
      case "2":
        paymentMethodString = "credit";
        break;
      case "3":
        paymentMethodString = "prepaid";
        break;
      case "4":
        paymentMethodString = "store";
        break;
      case "5":
        paymentMethodString = "eMoney";
        break;
    }

    return paymentMethodString;
  }

  Future<InaiResult> makePaymentApplePay(
      InaiApplePayRequest inaiApplePayRequest, BuildContext context) async {
    InaiResult inaiResult = InaiResult();

    //  Fire off the apple pay request and wait for the result

    var applePayConfigs = inaiApplePayRequest.applePayPaymentMethod!["configs"];

    var orderAmount = applePayConfigs["order_amount"];

    var paymentItem = PaymentItem(
        amount: orderAmount,
        label: "TOTAL",
        status: PaymentItemStatus.final_price);

    var applePayResult = await inaiApplePayRequest.payClient!
        .showPaymentSelector(PayProvider.apple_pay, [paymentItem]);

    var applePayResultPaymentMethod = applePayResult["paymentMethod"];

    Map<String, dynamic> paymentMethod = {
      "displayName": applePayResultPaymentMethod["displayName"],
      "network": applePayResultPaymentMethod["network"],
      "type":
          getPaymentMethodString(applePayResultPaymentMethod["type"].toString())
    };

    var applePayResultToken = jsonDecode(applePayResult["token"]);

    //  var applePayResultTokenData = applePayResultToken["data"];

    Map<String, dynamic> paymentDetails = {
      "apple_pay": {
        "paymentData": applePayResultToken,
        "paymentMethod": paymentMethod,
        "transactionIdentifier": applePayResult["transactionIdentifier"]
      }
    };

    try {
      inaiResult = await makePayment(
          paymentMethodOption: applePayProviderKey,
          context: context,
          paymentDetails: paymentDetails);
    } catch (ex) {
      inaiResult.status = InaiStatus.failed;

      inaiResult.data = {"message": ex.toString()};
    }

    return inaiResult;
  }

  Future<InaiResult> _showCheckoutWidget(BuildContext context,
      InaiCheckoutWidget checkoutWidget, bool enableDrag) async {
    InaiResult? result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true, //  Let modal sheet take full height
        isDismissible: false, //  Do not close on tapping outside
        enableDrag: enableDrag,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.9,
              builder: (_, controller) =>
                  Stack(clipBehavior: Clip.none, children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        child: checkoutWidget),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: const EdgeInsets.only(top: 2.0),
                          width: 80,
                          height: 4,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey[400],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                          )),
                    )
                  ]));
        });

    if (result == null) {
      //  No result => Payment was canceled
      InaiResult cancelResult = InaiResult();
      cancelResult.data["message"] = "Canceled";
      return cancelResult;
    }

    return result;
  }

  Future<InaiResult> _showCheckoutWidgetInvisible(
      BuildContext context, InaiCheckoutWidget checkoutWidget) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          left: 0,
          top: 0,
          child: SizedBox(height: 1, width: 1, child: checkoutWidget));
    });
    // Inserting the OverlayEntry into the Overlay
    overlayState!.insert(overlayEntry);

    var completer = Completer();
    checkoutWidget.overlayFinished = (InaiResult? result) {
      // Below code produced a bug in latest version of flutter-webview.
      // overlayEntry.dispose();
      if (result == null) {
        //  No result => Payment was canceled
        result = InaiResult();
        result.data["message"] = "Canceled";
      }

      completer.complete(result);
    };

    return await completer.future;
  }
}
