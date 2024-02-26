/// clase para definir los tema de la app

import 'package:flutter/material.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';
import 'package:to_farma_app/core/utlis/dimens.dart';

///tema  claro
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: CustomColors.blue,
  canvasColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(
    backgroundColor: const Color.fromRGBO(0, 51, 160, 1),
  ).copyWith(
    primary: CustomColors.blue,
    onPrimary: Colors.white, // Cambia el color del texto del botón "OK"
    surface: Colors.white, // Cambia el color del botón "CANCEL"
    //onSurface: Colors.white, // Cambia el color del texto del botón "CANCEL"
  ),
  buttonTheme: const ButtonThemeData(buttonColor: Color(0xff0072CE)),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
        color: Colors.white,
        fontFamily: "Roboto-regular",
        fontWeight: FontWeight.normal,
        fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 30),
    bodyLarge: TextStyle(
        color: Colors.white,
        fontFamily: "Roboto-Bold",
        fontWeight: FontWeight.bold,
        fontSize: 14),
    headlineSmall: TextStyle(
        color: Colors.white,
        fontFamily: "Montserrat-SemiBold",
        fontSize: 14,
        fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(color: Colors.white, fontSize: 25),
    titleMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat-bold',
        fontWeight: FontWeight.bold,
        fontSize: 16),
    labelSmall: TextStyle(
        color: Colors.white,
        fontFamily: "Roboto-regular",
        fontWeight: FontWeight.normal,
        fontSize: 14),
    labelMedium: TextStyle(
        color: Colors.white,
        fontFamily: "Montserrat-Bold",
        fontWeight: FontWeight.bold,
        fontSize: 15),
    // labelLarge: TextStyle(color: Color(0xff1BACEC), fontFamily: "Montserrat-Bold", fontWeight: FontWeight.bold, fontSize: 15),
    displaySmall: TextStyle(
        color: Color(0xff001238),
        fontFamily: "Roboto-regular",
        fontWeight: FontWeight.normal,
        fontSize: 13),
    displayMedium: TextStyle(
        color: Color(0xff001238),
        fontFamily: "Roboto-Medium",
        fontSize: 14,
        fontWeight: FontWeight.w600),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonsBorderRadius))),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          backgroundColor: const Color.fromRGBO(0, 51, 160, 1).withOpacity(0.1),
          //side: const BorderSide(color: CustomColors.buttonOutline),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimens.buttonsBorderRadius)))),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 14,
          ),
          backgroundColor: CustomColors.ButtonEnabledAction,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimens.buttonsBorderRadius)))),
);

///tema oscuro para la app
ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xff00226B),
  canvasColor: const Color(0xff001238),
  colorScheme: ColorScheme.fromSwatch(
    backgroundColor: const Color(0xff000205),
  ).copyWith(brightness: Brightness.dark), // fin copywith
  buttonTheme: const ButtonThemeData(buttonColor: Color(0xff0072CE)),
  textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white,
          fontSize:
              30), //👈 we will be able to access these in our widgets later
      headlineMedium: TextStyle(color: Colors.white, fontSize: 25),
      titleMedium: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat-bold',
          fontWeight: FontWeight.bold,
          fontSize: 16),
      bodySmall: TextStyle(
          color: Colors.white,
          fontFamily: "Roboto-regular",
          fontWeight: FontWeight.normal,
          fontSize: 16)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonsBorderRadius))),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: CustomColors.buttonOutline),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimens.buttonsBorderRadius)))),
);
