import 'dart:convert';

/*
//  Sample JSON Config
{
    token: string,
    orderId: string,
    planId: string,
    styles: {
        container: {
            "backgroundColor": string,
            "color": string,
            "fontFamily": string,
            "fontSize": string,
            "fontWeight": number,
            "width": string,
            "height": string,
            "margin": string,
            "padding": string
        },
        cta: {
            "backgroundColor": string,
            "color": string,
            "fontWeight": number,
            "fontSize": string,
            "minWidth": string,
            "borderRadius": string,
            "border": string,
            "outline": string,
            "padding": string,
            "cursor": string
        },
        errorText: {
            "color": string,
            "fontSize": string,
            "fontWeight": number
        }
    },
 
    ctaText: string,
    timeout: number,
    customer: {
        id: String,
        email: string,
        phoneNumber: string
    },
    countryCode: string,
    changeLocation: string,
    redirectUrl: string
}
*/

enum InaiStatus { success, failed, canceled }

class InaiResult {
  InaiStatus status = InaiStatus.canceled;
  Map<String, dynamic> data = {};
}

class InaiConfigStylesContainer {
  /// any CSS color or name for background
  String? backgroundColor;
  String? color;
  int? fontWeight;
  String? fontFamily;
  String? fontSize;
  String? minWidth;
  String? width;
  String? height;
  String? margin;
  String? padding;

  InaiConfigStylesContainer(
      {this.backgroundColor,
      this.color,
      this.fontWeight,
      this.fontFamily,
      this.fontSize,
      this.minWidth,
      this.width,
      this.height,
      this.margin,
      this.padding});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (backgroundColor != null) json['backgroundColor'] = backgroundColor;
    if (color != null) json['color'] = color;
    if (fontWeight != null) json['fontWeight'] = fontWeight;
    if (fontFamily != null) json['fontFamily'] = fontFamily;
    if (fontSize != null) json['fontSize'] = fontSize;
    if (minWidth != null) json['minWidth'] = minWidth;
    if (width != null) json['width'] = width;
    if (height != null) json['height'] = height;
    if (margin != null) json['margin'] = margin;
    if (padding != null) json['padding'] = padding;
    return json;
  }
}

class InaiConfigStylesCta {
  String? backgroundColor;
  String? color;
  int? fontWeight;
  String? fontSize;
  String? minWidth;
  String? borderRadius;
  String? border;
  String? outline;
  String? padding;
  String? cursor;

  InaiConfigStylesCta(
      {this.backgroundColor,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.minWidth,
      this.borderRadius,
      this.border,
      this.outline,
      this.padding,
      this.cursor});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (backgroundColor != null) json['backgroundColor'] = backgroundColor;
    if (color != null) json['color'] = color;
    if (fontWeight != null) json['fontWeight'] = fontWeight;
    if (fontSize != null) json['fontSize'] = fontSize;
    if (minWidth != null) json['minWidth'] = minWidth;
    if (borderRadius != null) json['borderRadius'] = borderRadius;
    if (border != null) json['border'] = border;
    if (outline != null) json['outline'] = outline;
    if (padding != null) json['padding'] = padding;
    if (cursor != null) json['cursor'] = cursor;
    return json;
  }
}

class InaiConfigStylesErrorText {
  String? color;
  String? fontSize;
  int? fontWeight;

  InaiConfigStylesErrorText({this.color, this.fontSize, this.fontWeight});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (color != null) json["color"] = color;
    if (fontSize != null) json["fontSize"] = fontSize;
    if (fontWeight != null) json["fontWeight"] = fontWeight;
    return json;
  }
}

class InaiConfigCustomer {
  String? id;
  String? email;
  String? phoneNumber;

  InaiConfigCustomer({this.id, this.email, this.phoneNumber});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json["id"] = id;
    if (email != null) json["email"] = email;
    if (phoneNumber != null) json["phoneNumber"] = phoneNumber;
    return json;
  }
}

class InaiConfigStyles {
  InaiConfigStylesContainer? container;
  InaiConfigStylesCta? cta;
  InaiConfigStylesErrorText? errorText;

  InaiConfigStyles({this.container, this.cta, this.errorText});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (container != null) json["container"] = jsonEncode(container);
    if (cta != null) json["cta"] = jsonEncode(cta);
    if (errorText != null) json["errorText"] = jsonEncode(errorText);
    return json;
  }
}

class InaiConfig {
  String token;
  String? orderId;
  String? planId;
  InaiConfigStyles? styles;
  String? ctaText;
  int? time;
  String? countryCode;
  String? changeLocation;
  String? redirectUrl;
  String? locale;
  String? usePaymentMethodOption;
  List<String>? availablePaymentMethodOptions;

  InaiConfig(
      {required this.token,
      this.orderId,
      this.planId,
      this.styles,
      this.ctaText,
      this.time,
      this.countryCode,
      this.changeLocation,
      this.redirectUrl,
      this.locale,
      this.usePaymentMethodOption,
      this.availablePaymentMethodOptions});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["token"] = token;
    if (orderId != null) json["orderId"] = orderId;
    if (planId != null) json["planId"] = planId;
    if (ctaText != null) json["ctaText"] = ctaText;
    if (time != null) json["time"] = time;
    if (countryCode != null) json["countryCode"] = countryCode;
    if (changeLocation != null) json["changeLocation"] = changeLocation;
    if (redirectUrl != null) json["redirectUrl"] = redirectUrl;
    if (locale != null) json["locale"] = locale;
    if (styles != null) json["styles"] = jsonEncode(styles);
    if (usePaymentMethodOption != null) {
      json["usePaymentMethodOption"] = usePaymentMethodOption;
    }
    if (availablePaymentMethodOptions != null) {
      json["availablePaymentMethodOptions"] = availablePaymentMethodOptions;
    }

    return json;
  }
}
