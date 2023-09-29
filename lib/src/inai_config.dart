import 'dart:convert';

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
  String? width;
  String? height;
  String? margin;
  String? padding;
  String? background;
  String? border;
  String? borderBottom;
  String? borderBottomColor;
  String? borderBottomLeftRadius;
  String? borderBottomRightRadius;
  String? borderBottomStyle;
  String? borderBottomWidth;
  String? borderColor;
  String? borderLeft;
  String? borderLeftColor;
  String? borderLeftStyle;
  String? borderLeftWidth;
  String? borderRadius;
  String? borderRight;
  String? borderRightColor;
  String? borderRightStyle;
  String? borderRightWidth;
  String? borderStyle;
  String? borderTop;
  String? borderTopColor;
  String? borderTopLeftRadius;
  String? borderTopRightRadius;
  String? borderTopStyle;
  String? borderTopWidth;
  String? borderWidth;
  String? boxShadow;
  String? webkitFontSmoothing;
  String? mozOsxFontSmoothing;
  String? fontVariant;
  String? fontSmoothing;
  String? letterSpacing;
  String? lineHeight;
  String? marginBottom;
  String? marginLeft;
  String? marginRight;
  String? marginTop;
  String? outline;
  String? outlineOffset;
  String? paddingBottom;
  String? paddingLeft;
  String? paddingRight;
  String? textDecoration;
  String? textShadow;
  String? textTransform;
  String? transition;
  String? display;
  String? alignItems;
  String? justifyContent;
  String? fontStyle;
  String? fill;

  InaiConfigStylesContainer(
      {this.backgroundColor,
      this.color,
      this.fontWeight,
      this.fontFamily,
      this.fontSize,
      this.width,
      this.height,
      this.margin,
      this.padding,
      this.background,
      this.border,
      this.borderBottom,
      this.borderBottomColor,
      this.borderBottomLeftRadius,
      this.borderBottomRightRadius,
      this.borderBottomStyle,
      this.borderBottomWidth,
      this.borderColor,
      this.borderLeft,
      this.borderLeftColor,
      this.borderLeftStyle,
      this.borderLeftWidth,
      this.borderRadius,
      this.borderRight,
      this.borderRightColor,
      this.borderRightStyle,
      this.borderRightWidth,
      this.borderStyle,
      this.borderTop,
      this.borderTopColor,
      this.borderTopLeftRadius,
      this.borderTopRightRadius,
      this.borderTopStyle,
      this.borderTopWidth,
      this.borderWidth,
      this.boxShadow,
      this.webkitFontSmoothing,
      this.mozOsxFontSmoothing,
      this.fontVariant,
      this.fontSmoothing,
      this.letterSpacing,
      this.lineHeight,
      this.marginBottom,
      this.marginLeft,
      this.marginRight,
      this.marginTop,
      this.outline,
      this.outlineOffset,
      this.paddingBottom,
      this.paddingLeft,
      this.paddingRight,
      this.textDecoration,
      this.textShadow,
      this.textTransform,
      this.transition,
      this.display,
      this.alignItems,
      this.justifyContent,
      this.fontStyle,
      this.fill});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (backgroundColor != null) json['backgroundColor'] = backgroundColor;
    if (color != null) json['color'] = color;
    if (fontWeight != null) json['fontWeight'] = fontWeight;
    if (fontFamily != null) json['fontFamily'] = fontFamily;
    if (fontSize != null) json['fontSize'] = fontSize;
    if (width != null) json['width'] = width;
    if (height != null) json['height'] = height;
    if (margin != null) json['margin'] = margin;
    if (padding != null) json['padding'] = padding;
    if (background != null) json['background'] = background;
    if (border != null) json['border'] = border;
    if (borderBottom != null) json['borderBottom'] = borderBottom;
    if (borderBottomColor != null) {
      json['borderBottomColor'] = borderBottomColor;
    }
    if (borderBottomLeftRadius != null) {
      json['borderBottomLeftRadius'] = borderBottomLeftRadius;
    }
    if (borderBottomRightRadius != null) {
      json['borderBottomRightRadius'] = borderBottomRightRadius;
    }
    if (borderBottomStyle != null) {
      json['borderBottomStyle'] = borderBottomStyle;
    }
    if (borderBottomWidth != null) {
      json['borderBottomWidth'] = borderBottomWidth;
    }
    if (borderColor != null) json['borderColor'] = borderColor;
    if (borderLeft != null) json['borderLeft'] = borderLeft;
    if (borderLeftColor != null) json['borderLeftColor'] = borderLeftColor;
    if (borderLeftStyle != null) json['borderLeftStyle'] = borderLeftStyle;
    if (borderLeftWidth != null) json['borderLeftWidth'] = borderLeftWidth;
    if (borderRadius != null) json['borderRadius'] = borderRadius;
    if (borderRight != null) json['borderRight'] = borderRight;
    if (borderRightColor != null) json['borderRightColor'] = borderRightColor;
    if (borderRightStyle != null) json['borderRightStyle'] = borderRightStyle;
    if (borderRightWidth != null) json['borderRightWidth'] = borderRightWidth;
    if (borderStyle != null) json['borderStyle'] = borderStyle;
    if (borderTop != null) json['borderTop'] = borderTop;
    if (borderTopColor != null) json['borderTopColor'] = borderTopColor;
    if (borderTopLeftRadius != null) {
      json['borderTopLeftRadius'] = borderTopLeftRadius;
    }
    if (borderTopRightRadius != null) {
      json['borderTopRightRadius'] = borderTopRightRadius;
    }
    if (borderTopStyle != null) json['borderTopStyle'] = borderTopStyle;
    if (borderTopWidth != null) json['borderTopWidth'] = borderTopWidth;
    if (borderWidth != null) json['borderWidth'] = borderWidth;
    if (boxShadow != null) json['boxShadow'] = boxShadow;
    if (webkitFontSmoothing != null) {
      json['webkitFontSmoothing'] = webkitFontSmoothing;
    }
    if (mozOsxFontSmoothing != null) {
      json['mozOsxFontSmoothing'] = mozOsxFontSmoothing;
    }
    if (fontVariant != null) json['fontVariant'] = fontVariant;
    if (fontSmoothing != null) json['fontSmoothing'] = fontSmoothing;
    if (letterSpacing != null) json['letterSpacing'] = letterSpacing;
    if (lineHeight != null) json['lineHeight'] = lineHeight;
    if (marginBottom != null) json['marginBottom'] = marginBottom;
    if (marginLeft != null) json['marginLeft'] = marginLeft;
    if (marginRight != null) json['marginRight'] = marginRight;
    if (marginTop != null) json['marginTop'] = marginTop;
    if (outline != null) json['outline'] = outline;
    if (outlineOffset != null) json['outlineOffset'] = outlineOffset;
    if (paddingBottom != null) json['paddingBottom'] = paddingBottom;
    if (paddingLeft != null) json['paddingLeft'] = paddingLeft;
    if (paddingRight != null) json['paddingRight'] = paddingRight;
    if (textDecoration != null) json['textDecoration'] = textDecoration;
    if (textShadow != null) json['textShadow'] = textShadow;
    if (textTransform != null) json['textTransform'] = textTransform;
    if (transition != null) json['transition'] = transition;
    if (display != null) json['display'] = display;
    if (alignItems != null) json['alignItems'] = alignItems;
    if (justifyContent != null) json['justifyContent'] = justifyContent;
    if (fontStyle != null) json['fontStyle'] = fontStyle;
    if (fill != null) json['fill'] = fill;
    return json;
  }
}

class InaiConfigStylesCta {
  String? backgroundColor;
  String? color;
  int? fontWeight;
  String? fontSize;
  String? borderRadius;
  String? border;
  String? outline;
  String? padding;
  String? background;
  String? borderBottom;
  String? borderBottomColor;
  String? borderBottomLeftRadius;
  String? borderBottomRightRadius;
  String? borderBottomStyle;
  String? borderBottomWidth;
  String? borderColor;
  String? borderLeft;
  String? borderLeftColor;
  String? borderLeftStyle;
  String? borderLeftWidth;
  String? borderRight;
  String? borderRightColor;
  String? borderRightStyle;
  String? borderRightWidth;
  String? borderStyle;
  String? borderTop;
  String? borderTopColor;
  String? borderTopLeftRadius;
  String? borderTopRightRadius;
  String? borderTopStyle;
  String? borderTopWidth;
  String? borderWidth;
  String? boxShadow;
  String? webkitFontSmoothing;
  String? mozOsxFontSmoothing;
  String? fontFamily;
  String? fontVariant;
  String? fontSmoothing;
  String? height;
  String? letterSpacing;
  String? lineHeight;
  String? margin;
  String? marginBottom;
  String? marginLeft;
  String? marginRight;
  String? marginTop;
  String? outlineOffset;
  String? paddingBottom;
  String? paddingLeft;
  String? paddingRight;
  String? textDecoration;
  String? textShadow;
  String? textTransform;
  String? transition;
  String? width;
  String? display;
  String? alignItems;
  String? justifyContent;
  String? fontStyle;
  String? fill;

  InaiConfigStylesCta(
      {this.backgroundColor,
      this.color,
      this.fontWeight,
      this.fontFamily,
      this.fontSize,
      this.width,
      this.height,
      this.margin,
      this.padding,
      this.background,
      this.border,
      this.borderBottom,
      this.borderBottomColor,
      this.borderBottomLeftRadius,
      this.borderBottomRightRadius,
      this.borderBottomStyle,
      this.borderBottomWidth,
      this.borderColor,
      this.borderLeft,
      this.borderLeftColor,
      this.borderLeftStyle,
      this.borderLeftWidth,
      this.borderRadius,
      this.borderRight,
      this.borderRightColor,
      this.borderRightStyle,
      this.borderRightWidth,
      this.borderStyle,
      this.borderTop,
      this.borderTopColor,
      this.borderTopLeftRadius,
      this.borderTopRightRadius,
      this.borderTopStyle,
      this.borderTopWidth,
      this.borderWidth,
      this.boxShadow,
      this.webkitFontSmoothing,
      this.mozOsxFontSmoothing,
      this.fontVariant,
      this.fontSmoothing,
      this.letterSpacing,
      this.lineHeight,
      this.marginBottom,
      this.marginLeft,
      this.marginRight,
      this.marginTop,
      this.outline,
      this.outlineOffset,
      this.paddingBottom,
      this.paddingLeft,
      this.paddingRight,
      this.textDecoration,
      this.textShadow,
      this.textTransform,
      this.transition,
      this.display,
      this.alignItems,
      this.justifyContent,
      this.fontStyle,
      this.fill});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (backgroundColor != null) json['backgroundColor'] = backgroundColor;
    if (color != null) json['color'] = color;
    if (fontWeight != null) json['fontWeight'] = fontWeight;
    if (fontFamily != null) json['fontFamily'] = fontFamily;
    if (fontSize != null) json['fontSize'] = fontSize;
    if (width != null) json['width'] = width;
    if (height != null) json['height'] = height;
    if (margin != null) json['margin'] = margin;
    if (padding != null) json['padding'] = padding;
    if (background != null) json['background'] = background;
    if (border != null) json['border'] = border;
    if (borderBottom != null) json['borderBottom'] = borderBottom;
    if (borderBottomColor != null) {
      json['borderBottomColor'] = borderBottomColor;
    }
    if (borderBottomLeftRadius != null) {
      json['borderBottomLeftRadius'] = borderBottomLeftRadius;
    }
    if (borderBottomRightRadius != null) {
      json['borderBottomRightRadius'] = borderBottomRightRadius;
    }
    if (borderBottomStyle != null) {
      json['borderBottomStyle'] = borderBottomStyle;
    }
    if (borderBottomWidth != null) {
      json['borderBottomWidth'] = borderBottomWidth;
    }
    if (borderColor != null) json['borderColor'] = borderColor;
    if (borderLeft != null) json['borderLeft'] = borderLeft;
    if (borderLeftColor != null) json['borderLeftColor'] = borderLeftColor;
    if (borderLeftStyle != null) json['borderLeftStyle'] = borderLeftStyle;
    if (borderLeftWidth != null) json['borderLeftWidth'] = borderLeftWidth;
    if (borderRadius != null) json['borderRadius'] = borderRadius;
    if (borderRight != null) json['borderRight'] = borderRight;
    if (borderRightColor != null) json['borderRightColor'] = borderRightColor;
    if (borderRightStyle != null) json['borderRightStyle'] = borderRightStyle;
    if (borderRightWidth != null) json['borderRightWidth'] = borderRightWidth;
    if (borderStyle != null) json['borderStyle'] = borderStyle;
    if (borderTop != null) json['borderTop'] = borderTop;
    if (borderTopColor != null) json['borderTopColor'] = borderTopColor;
    if (borderTopLeftRadius != null) {
      json['borderTopLeftRadius'] = borderTopLeftRadius;
    }
    if (borderTopRightRadius != null) {
      json['borderTopRightRadius'] = borderTopRightRadius;
    }
    if (borderTopStyle != null) json['borderTopStyle'] = borderTopStyle;
    if (borderTopWidth != null) json['borderTopWidth'] = borderTopWidth;
    if (borderWidth != null) json['borderWidth'] = borderWidth;
    if (boxShadow != null) json['boxShadow'] = boxShadow;
    if (webkitFontSmoothing != null) {
      json['webkitFontSmoothing'] = webkitFontSmoothing;
    }
    if (mozOsxFontSmoothing != null) {
      json['mozOsxFontSmoothing'] = mozOsxFontSmoothing;
    }
    if (fontVariant != null) json['fontVariant'] = fontVariant;
    if (fontSmoothing != null) json['fontSmoothing'] = fontSmoothing;
    if (letterSpacing != null) json['letterSpacing'] = letterSpacing;
    if (lineHeight != null) json['lineHeight'] = lineHeight;
    if (marginBottom != null) json['marginBottom'] = marginBottom;
    if (marginLeft != null) json['marginLeft'] = marginLeft;
    if (marginRight != null) json['marginRight'] = marginRight;
    if (marginTop != null) json['marginTop'] = marginTop;
    if (outline != null) json['outline'] = outline;
    if (outlineOffset != null) json['outlineOffset'] = outlineOffset;
    if (paddingBottom != null) json['paddingBottom'] = paddingBottom;
    if (paddingLeft != null) json['paddingLeft'] = paddingLeft;
    if (paddingRight != null) json['paddingRight'] = paddingRight;
    if (textDecoration != null) json['textDecoration'] = textDecoration;
    if (textShadow != null) json['textShadow'] = textShadow;
    if (textTransform != null) json['textTransform'] = textTransform;
    if (transition != null) json['transition'] = transition;
    if (display != null) json['display'] = display;
    if (alignItems != null) json['alignItems'] = alignItems;
    if (justifyContent != null) json['justifyContent'] = justifyContent;
    if (fontStyle != null) json['fontStyle'] = fontStyle;
    if (fill != null) json['fill'] = fill;
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

class InaiComponentStyles {
  String? component;
  InaiConfigStylesContainer? style;

  InaiComponentStyles({this.component, this.style});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (component != null) json["component"] = component;
    if (style != null) json["style"] = style;
    return json;
  }
}

class InaiConfigStyles {
  InaiConfigStylesContainer? container;
  InaiConfigStylesCta? cta;
  InaiConfigStylesErrorText? errorText;
  List<InaiComponentStyles>? components;

  InaiConfigStyles({this.container, this.cta, this.errorText, this.components});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (container != null) json["container"] = container;
    if (cta != null) json["cta"] = cta;
    if (errorText != null) json["errorText"] = errorText;
    if (components != null) {
      json["components"] = components;
    }
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
    if (styles != null) json["styles"] = styles;
    if (usePaymentMethodOption != null) {
      json["usePaymentMethodOption"] = usePaymentMethodOption;
    }
    if (availablePaymentMethodOptions != null) {
      json["availablePaymentMethodOptions"] = availablePaymentMethodOptions;
    }

    return json;
  }
}
