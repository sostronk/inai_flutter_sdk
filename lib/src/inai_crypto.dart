import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../inai_flutter_sdk.dart';
import 'inai_checkout_widget.dart';

class InaiCrypto {
  static Future<InaiResult> getPurchaseEstimate(
      {required InaiCryptoPurchaseDetails cryptoPurchaseDetails,
      required BuildContext context}) async {
    InaiCheckoutWidget checkoutWidget = InaiCheckoutWidget(
      checkoutMode: InaiCheckoutMode.cryptoEstimates,
      cryptoPurchaseDetails: cryptoPurchaseDetails,
    );
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
