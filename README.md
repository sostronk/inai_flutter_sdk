# inai-flutter-sdk

Flutter Inai Checkout SDK

## Setup locally 
Relatively Reference the Inai Flutter SDK Library
inai_flutter_sdk:
      path: ../inai_flutter_sdk

## Installation
In your ```pubspec.yaml``` file, under ```dependencies``` include ```inai_flutter_sdk : 0.1.5```

## Initialization

Inai Checkout has different methods that can be used to execute different types of operations related to payments. Let's discuss them in detail.
In order to use an interface of teh SDK you need an instance of the InaiCheckout Object as shown below.

```dart

InaiCheckout checkout = InaiCheckout(config);

```


## Config Parameters

```InaiConfig``` object is required to be passed onto the checkout instance. ```InaiConfig``` takes the following parameters.


| Variables | Description                                                                                   |
| :-------- | :-------------------------------------------------------------------------------------------- |
| token     | The client username can be obtained from the dashboard: Settings > Credentials                |
| orderId   | The orderId refers to the inai order created by the merchant backend.                         |
| countryCode   | The countryCode should be specified as an ISO 3166-1 alpha-3 country code.                |
| styles    | The optional styles object can be used to customize various UI elements on the checkout page. |
| locale    | This adds localization to the SDK method that is being called. e.g "en" for English, "fr" for french. |

```dart
 InaiConfigStyles styles = InaiConfigStyles(
        container: InaiConfigStylesContainer(backgroundColor: "#fff"),
        cta: InaiConfigStylesCta(backgroundColor: "#123456"));

 InaiConfig config = InaiConfig(
    token: "token",
    orderId: "orderId",
    countryCode: "countryCode",
    locale: locale,
    styles: styles); 
  
```

## Drop-In Checkout

### Present Checkout

Inai Checkout presents the customer with a list of configured payment method options for the country of checkout.

```dart
    final result = await checkout.presentCheckout(context: context);
    
    String resultStr = "";
    switch (result.status) {
      case InaiStatus.success:
        // Handle Payment Success
        break;
      case InaiStatus.failed:
        // Handle Payment Failed
        break;
      case InaiStatus.canceled:
        // Handle Payment Canceled
        break;
    }

```

### Present Add Payment Method

The `addPaymentMethod` interface presents the customers a view with a list of configured payment method options for the country of checkout which enables them to save it. Once saved, `payment_method_id` that gets returned from the `addPaymentMethod` call  can be used for subsequent payments eliminating the need for the customer to re-enter the payment details for each payment request.


```dart
      final result = await checkout.addPaymentMethod(type: "card", context: context);

      switch (result.status) {
        case InaiStatus.success:
          // Handle Payment Success
          break;
        case InaiStatus.failed:
          // Handle Payment Failed
          break;
        case InaiStatus.canceled:
          // Handle Payment Canceled
          break;
      }

```

### Present Pay with Saved Payment Method

When a customer has saved a payment method, the `payment_method_id` of the same can be used to invoke the `presentPayWithPaymentMethod` interface. This enables the customers to leverage saved `payment_method_ids` for faster checkout.

```dart
  final result = await checkout.presentPayWithPaymentMethod(paymentMethodId: "<paymentMethodId>", context: context);

  switch(result.status) {
    case InaiStatus.success:
      // Handle Payment Success
      break;
    case InaiStatus.failed:
      // Handle Payment Failed
      break;
    case InaiStatus.canceled:
      // Handle Payment Canceled
      break;
  }
```

For additional information regarding [Drop-In Checkout](https://docs.inai.io/docs/flutter), please check the [link](https://docs.inai.io/docs/flutter).

## Headless Checkout

### Validate Fields

This interface is used to validate payment details entered by the customer.

```validateFields``` takes 3 parameters -

- `paymentMethodOption` represents the payment method option the user chose to complete the payment.
- `context` represents the context in which the checkout instance was created.
- `paymentDetails` represents the payment details that are required to complete the payment for the payment method option specified. For [Payment Method Options](https://docs.inai.io/docs/headless-checkout#3-get-payment-method-options-for-order) with empty form_fields, this must be set as an empty object {}

```dart
    var paymentMethodOption = "card";
    
    var paymentDetails = {
      "fields": [{
        "name": "number",
        "value": "5123456789012346"
      },{
        "name": "cvc",
        "value": "123"
      },{
        "name": "expiry",
        "value": "12/25"
      },{
        "name": "holder_name",
        "value": "John Doe"
      },{
        "name": "contact_number",
        "value": "01010101010"
      },{
        "name": "first_name",
        "value": "John"
      },{
        "name": "last_name",
        "value": "Doe"
      },{
        "name": "contact_email",
        "value": "customer@example.com"
      }]
    };
    
    final result = await checkout.validateFields(
      paymentMethodOption: paymentMethodOption,
      context: context,
      paymentDetails: paymentDetails
    );
    
    switch (result.status) {
      case InaiStatus.success:
        // Handle Payment Success
        break;
      case InaiStatus.failed:
        // Handle Payment Failed
        break;
      case InaiStatus.canceled:
        // Handle Payment Canceled
        break;
    }
```

### Make Payment

This interface is used to do headless payments.

`makePayment` takes 3 parameters -

- `paymentMethodOption` represents the payment method option the user chose to complete the payment.
- `context` represents the context in which the checkout instance was created.
- `paymentDetails` represents the payment details that are required to complete the payment for the payment method option specified. For [Payment Method Options](https://docs.inai.io/docs/headless-checkout#3-get-payment-method-options-for-order) with empty form_fields, this must be set as an empty object {}

```dart
      var paymentMethodOption = "card";
      
      var paymentDetails = {
            "fields": [{
                  "name": "number",
                  "value": "5123456789012346"
            },{
                  "name": "cvc",
                  "value": "123"
            },{
                  "name": "expiry",
                  "value": "12/25"
            },{
                  "name": "holder_name",
                  "value": "John Doe"
            },{
                  "name": "contact_number",
                  "value": "01010101010"
            },{
                  "name": "first_name",
                  "value": "John"
            },{
                  "name": "last_name",
                  "value": "Doe"
            },{
                  "name": "contact_email",
                  "value": "customer@example.com"
            }]
      };  
      final result = await checkout.makePayment(
                paymentMethodOption: paymentMethodOption,
                context: context,
                paymentDetails: paymentDetails)
      );
      
      switch (result.status) {
        case InaiStatus.success:
          // Handle Payment Success
          break;
        case InaiStatus.failed:
          // Handle Payment Failed
          break;
        case InaiStatus.canceled:
          // Handle Payment Canceled
          break;
      }
```

For additional information regarding [Headless Checkout](https://docs.inai.io/docs/headless-checkout), please check the [link](https://docs.inai.io/docs/headless-checkout).


## Developer information
[Inai Flutter Docs](https://docs.inai.io/docs/flutter)
