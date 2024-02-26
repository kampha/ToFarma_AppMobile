import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// clase para expresiones regulares y mascaras en entradas de texto.
class RegularExpressions {
  static const String _patternOnlyNumbers = r'[0-9]'; //solo numeros
  static const String _patternLettersNumbers =r'[a-zA-Z0-9]'; // solo letras y numeros
  static const String _patternIbanAccount = r'^[CR]{2}([0-9a-zA-Z]{20})$';
  static const String _patternCharactersSpecials = r'^[a-zA-Z0-9!@#\$&*~%^()_+=[\]{}|\\;:\'"%,.<>/?-]+";


  static RegExp regexTest = RegExp(r'\S'); 

  static const String _pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExpEmail  = RegExp(_pattern);


  static RegExp regExpOnlyNumbers = RegExp(_patternOnlyNumbers);
  static RegExp regExpLettersNumbers = RegExp(_patternLettersNumbers);
  static RegExp regIbanAccount = RegExp(_patternIbanAccount);
  static RegExp regCharacteresSpecials = RegExp(_patternCharactersSpecials);


  static String expPassword = r'(?=^.{6,}$)(?=.*\d)(?=.*[!@#$%^&*]+)(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$';
  static RegExp resexpPassword = RegExp(expPassword);


  ///mascaras 
  static MaskTextInputFormatter formatterIdentification = MaskTextInputFormatter(
    mask: '0-0000-0000', 
    filter: { "0": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  static MaskTextInputFormatter formatterTelephone = MaskTextInputFormatter(
    mask: '0000-0000', 
    filter: { "0": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

  static MaskTextInputFormatter formatterDateTime = MaskTextInputFormatter(
    mask: '0000/00/00', 
    filter: { "0": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy
  );

}
