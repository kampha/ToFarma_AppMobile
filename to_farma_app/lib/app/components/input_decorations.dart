import 'package:flutter/material.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';

class InputDecorationCustom {
  static InputDecoration getInputDecoration({
    String? labeltext,
    String? hintext,
    Widget? prefixicon,
    Widget? suffixIcon,
    required BuildContext context,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.036,
          color: CustomColors.lightGray,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.normal),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          borderSide: BorderSide(
            color: Colors.grey,
            style: BorderStyle.solid,
          )),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          borderSide: BorderSide(
            color: Colors.grey,
            style: BorderStyle.solid,
          )),
      //labelText: labeltext,
      hintText: hintext,
      labelText: labeltext,
      prefixIcon: prefixicon,
      suffixIcon: suffixIcon,
    );
  }

  static InputDecoration getInputDecorationPharmaco({
    String? labeltext,
    String? hintext,
    Widget? prefixicon,
    Widget? suffixIcon,
    required BorderRadius borderRadius,
    required BuildContext context,
  }) {
    return InputDecoration(
      hintStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.040,
          color: CustomColors.lightGray,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.normal),
      labelStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.045,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.normal),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            color: Colors.grey,
            style: BorderStyle.solid,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            color: Colors.grey,
            style: BorderStyle.solid,
          )),
      hintText: hintext,
      labelText: labeltext,
      prefixIcon: prefixicon,
      suffixIcon: suffixIcon,
    );
  }
}
