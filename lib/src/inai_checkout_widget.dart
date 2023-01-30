import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import './inai_config.dart';

/// Represents the mode for the Checkout ViewController:
enum InaiCheckoutMode {
  /// This mode represents a direct payment method
  payment,

  /// This mode represents saving a payment method
  addPaymentMethod,

  /// This mode represents making a payment using a saved payment method
  payWithPaymentMethod,

  /// This mode represents making a payment using headless payment
  payHeadless,

  /// This mode represents validating payment method fields
  validateFields,

  /// This mode represents fetching card information
  getCardInfo
}

const String sdkHostURL = "https://payments.inai.io/sdk-index";

class InaiCheckoutWidget extends StatefulWidget {
  InaiCheckoutWidget(
      {Key? key,
      this.config,
      this.checkoutMode = InaiCheckoutMode.payment,
      this.paymentMethodId,
      this.paymentMethodType,
      this.paymentMethodOption,
      this.paymentDetails,
      this.cardNumber})
      : super(key: key);
  final InaiConfig? config;
  final InaiCheckoutMode checkoutMode;

  final Map<String, dynamic>? paymentDetails;
  final String? paymentMethodId;
  final String? paymentMethodType;
  final String? paymentMethodOption;
  final String? cardNumber;

  Function? overlayFinished;

  @override
  State<InaiCheckoutWidget> createState() => _InaiCheckoutWidgetState();
}

class _InaiCheckoutWidgetState extends State<InaiCheckoutWidget> {
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    // Enable virtual display on Android platform
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  void _hideProgressIndicator() {
    if (widget.checkoutMode != InaiCheckoutMode.validateFields &&
        widget.checkoutMode != InaiCheckoutMode.getCardInfo) {
      Navigator.pop(context);
    }
  }

  void _showProgressIndicator() {
    if (widget.checkoutMode != InaiCheckoutMode.validateFields &&
        widget.checkoutMode != InaiCheckoutMode.getCardInfo) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [Center(child: CircularProgressIndicator())]),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _webviewLoaded = false;
  return Scaffold(
    resizeToAvoidBottomInset: true,
    body:WebView(
      initialUrl: sdkHostURL,
      javascriptMode: JavascriptMode.unrestricted,
      gestureRecognizers: {
        Factory(() => VerticalDragGestureRecognizer()),
      },
      onWebViewCreated: (WebViewController wvc) {
        _webViewController = wvc;
        _showProgressIndicator();
      },
      onPageFinished: (finished) {
        //  Load webview only once and call out init js function to call the web sdk
        if (_webviewLoaded) {
          return;
        }

        String jsConfig = jsonEncode(widget.config!);
        String extraArgs = "";
        String inaiFn = "initPayment";

        switch (widget.checkoutMode) {
          case InaiCheckoutMode.payment:
            break;
          case InaiCheckoutMode.addPaymentMethod:
            inaiFn = "initAddPaymentMethod";
            extraArgs += ",'${widget.paymentMethodType!}'";
            break;
          case InaiCheckoutMode.payWithPaymentMethod:
            inaiFn = "initPayWithPaymentMethod";
            extraArgs += ",'${widget.paymentMethodId!}'";
            break;
          case InaiCheckoutMode.payHeadless:
            inaiFn = "initMakePayment";
            extraArgs =
                ",'${widget.paymentMethodOption!}', ${json.encode(widget.paymentDetails!)}";
            break;
          case InaiCheckoutMode.validateFields:
            inaiFn = "initValidateFields";
            extraArgs =
                ",'${widget.paymentMethodOption!}', ${json.encode(widget.paymentDetails!)}";
            break;
          case InaiCheckoutMode.getCardInfo:
            inaiFn = "initGetCardInfo";
            extraArgs += ",'${widget.cardNumber!}'";
            break;
        }

        if (_webViewController == null) {
          InaiResult result = InaiResult();
          result.data = {"message": "Webview init error"};
          _removeCheckoutWidget(context, result);
        } else {
          String overrideAlert =
              "window.alert = function (e){ Alert.postMessage(e);}; ";

          String overrideHandler = "";
          if (Platform.isAndroid) {
            overrideHandler =
                "window.webkit = { messageHandlers: { inaiHandler: window.inaiHandler} }; ";
          }

          String jsFnCall =
              "$overrideHandler$overrideAlert$inaiFn($jsConfig$extraArgs);";
          _webViewController!.runJavascript(jsFnCall);

          _hideProgressIndicator();
          _webviewLoaded = true;
        }
      },
      navigationDelegate: (NavigationRequest request) {
        Uri uri = Uri.parse(request.url);

        String? transctionId = uri.queryParameters["transaction-id"] ??
            uri.queryParameters["transaction_id"];
        String? status = uri.queryParameters["status"];

        if (transctionId != null && status != null) {
          if (transctionId.isNotEmpty && status.isNotEmpty) {
            //  We're on a result page. Stop the url load action and unload the webview
            InaiResult result = InaiResult();
            result.data = uri.queryParameters;
            if (status == "success") {
              result.status = InaiStatus.success;
            } else {
              result.status = InaiStatus.failed;
            }
            _removeCheckoutWidget(context, result);
            return NavigationDecision.prevent;
          }
        }
        //  Let the URL Load
        return NavigationDecision.navigate;
      },
      javascriptChannels: <JavascriptChannel>{
        _inaiHandler(context),
        JavascriptChannel(
          name: 'Alert',
          onMessageReceived: (JavascriptMessage message) {
            // set up the AlertDialog
            // set up the button
            Widget okButton = TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            );

            AlertDialog alert = AlertDialog(
              content: SingleChildScrollView(child: Text(message.message)),
              actions: [
                okButton,
              ],
            );

            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          },
        )
      },
    )
  );
  }

  void _removeCheckoutWidget(BuildContext context, InaiResult result) {
    if (widget.overlayFinished != null) {
      widget.overlayFinished!(result);
    } else {
      Navigator.pop(context, result);
    }
  }

  JavascriptChannel _inaiHandler(BuildContext context) {
    return JavascriptChannel(
        name: "inaiHandler",
        onMessageReceived: (JavascriptMessage message) {
          Map<String, dynamic> handlerMessage = jsonDecode(message.message);
          /*
           {"message":"Payment Success",
           "transaction_id":"e06c9658-086f-47ca-bfdb-3d332f579cf2",
           "vendor_response":{"response":{"params":{"transaction":{"status":"success","authorization_code":"TEST00",
           "status_detail":3,"message":"Response by mock","id":"DF-175792","payment_date":"2022-02-01T10:48:17.871",
           "dev_reference":"e06c9658-086f-47ca-bfdb-3d332f579cf2","carrier_code":"00","current_status":"APPROVED",
           "amount":100,"carrier":"DataFast","installments":0},"card":{"bin":"555555","expiry_year":"2031","expiry_month":"10",
           "transaction_reference":"DF-175792","type":"mc","number":"4444","origin":"Paymentez"}},"message":"Response by mock",
           "success":true,"test":true,"authorization":"DF-175792","avs_result":{},"cvv_result":{}}},"inai_status":"success"}
          */
          InaiResult result = InaiResult();
          String inaiStatus = handlerMessage["inai_status"];
          handlerMessage.remove("inai_status");
          result.data = handlerMessage;

          if (inaiStatus == "success") {
            result.status = InaiStatus.success;
          } else {
            result.status = InaiStatus.failed;
          }

          _removeCheckoutWidget(context, result);
        });
  }
}
