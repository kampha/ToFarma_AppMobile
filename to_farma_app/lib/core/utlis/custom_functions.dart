import 'package:intl/intl.dart';
import 'package:html_unescape/html_unescape.dart';

class CustomFuntions {
  ///saludo en el inicio de la app
  static String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    String greeting = '';

    if (hour >= 6 && hour < 12) {
      greeting = 'Buenos días';
    } else if (hour >= 12 && hour < 18) {
      greeting = 'Buenas tardes';
    } else {
      greeting = 'Buenas noches';
    }

    return greeting;
  }

  ///remuevo los guiones en la cedula
  static String removeDashes(String dashedString) {
    return dashedString.replaceAll("-", "");
  }

  ///formato de fecha año-mes-dia
  static String formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    return '$year-$month-$day';
  }

  static DateTime parseDateString(String dateString) {
    return DateFormat('yyyy-M-d').parse(dateString);
  }

  ////elimiar etiquetas html en texto
  static String removeHtmlTags(String htmlText) {
    var unescape = HtmlUnescape();
    var text = unescape.convert(htmlText.replaceAll(RegExp(r'<[^>]*>'), ''));
    return text;
  }

  ///formato de fecha día/mes/año
  static String convertStringFechaFormat(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();
    return '$day/$month/$year';
  }
}
