import 'package:flutter/material.dart';
import 'package:receitasapp/common/my_colors.dart';

InputDecoration getAuthenticationInputDecoration(String label, {Icon? icon}) {
  return InputDecoration(
    icon: icon,
    hintText: label,
    fillColor: Colors.transparent,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: MyColors.azulPrincipal.withOpacity(0.4), width: 4),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.withOpacity(0.5), width: 4),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

InputDecoration getReceitasInputDecoration(String label) {
  return InputDecoration(
    hintText: label,
    hintStyle: TextStyle(color: MyColors.azulPrincipal, fontSize: 14),
    fillColor: MyColors.cinzaPrincipal,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

TextStyle getTextStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  bool underline = false,
  TextDecorationStyle? underlineStyle,
  Color? underlineColor,
  double? height,
}) {
  return TextStyle(
    fontFamily: 'Roboto',
    fontSize: fontSize ?? 14,
    color: color ?? MyColors.azulPrincipal,
    fontWeight: fontWeight ?? FontWeight.normal,
    decoration: underline ? TextDecoration.underline : null,
    decorationStyle: underline ? underlineStyle : null,
    decorationColor: underline ? underlineColor : null,
    height: height,
  );
}
