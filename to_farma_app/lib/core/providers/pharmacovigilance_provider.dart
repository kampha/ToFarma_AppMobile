import 'package:flutter/material.dart';
import 'package:to_farma_app/core/utlis/assets.dart';
import 'package:to_farma_app/core/utlis/custom_functions.dart';

enum EfectoSecundario { si, no }

class PharmacovigilanceProvider extends ChangeNotifier {
  ///Sección 1
  String _titulo = "Farmacovigilancia TÖfarma";
  String _descripcion =
      "Este formulario tiene como objetivo resolver problemas del paciente con su medicación, especificamente interacciones de medicamentos y efectos adversos.";

  ///Sección 2
  String? _motivo = "";
  String _enfermedades = "";
  String _medicamentos = "";
  EfectoSecundario? _efectoSecundario;

  ///Sección 3
  String? _producto;
  String _productoReportar = "";
  String _lote = "";
  String _indicacion = "";
  String _viaAdministracion = "";
  String _dosis = "";
  String _inicioTratamiento = CustomFuntions.formatDate(DateTime.now());
  String _conclusionTratamiento = CustomFuntions.formatDate(DateTime.now());

  ///:::::::::::::::::::::GET::::::::::::::::::::::

  ///Sección 1
  String get seccion1Titulo => _titulo;
  String get seccion1Descripcion => _descripcion;
  String get seccion1Image => Assets.logoTofarma;

  ///Sección 2
  String? get seccion2Motivo => _motivo;
  String get seccion2Enfermedades => _enfermedades;
  String get seccion2Medicamentos => _medicamentos;
  EfectoSecundario? get seccion2EfectoSecundario => _efectoSecundario;

  ///Sección 3
  String? get seccion3Producto => _producto;
  String get seccion3ProductoReportar => _productoReportar;
  String get seccion3Lote => _lote;
  String get seccion3Indicacion => _indicacion;
  String get seccion3ViaAdministracion => _viaAdministracion;
  String get seccion3Dosis => _dosis;
  String get seccion3InicioTratamiento => _inicioTratamiento;
  String get seccion3ConclusionTratamiento => _conclusionTratamiento;

  ///:::::::::::::::::::::SET::::::::::::::::::::::

  ///Sección 2
  set seccion2Motivo(String? value) {
    _motivo = value;
    notifyListeners();
  }

  set seccion2Enfermedades(String value) {
    _enfermedades = value;
    notifyListeners();
  }

  set seccion2Medicamentos(String value) {
    _medicamentos = value;
    notifyListeners();
  }

  set seccion2EfectoSecundario(EfectoSecundario? value) {
    _efectoSecundario = value;
    notifyListeners();
  }

  ///Sección 3

  set seccion3Producto(String? value) {
    _producto = value;
    notifyListeners();
  }

  set seccion3ProductoReportar(String value) {
    _productoReportar = value;
    notifyListeners();
  }

  set seccion3Lote(String value) {
    _lote = value;
    notifyListeners();
  }

  set seccion3Indicacion(String value) {
    _indicacion = value;
    notifyListeners();
  }

  set seccion3ViaAdministracion(String value) {
    _viaAdministracion = value;
    notifyListeners();
  }

  set seccion3Dosis(String value) {
    _dosis = value;
    notifyListeners();
  }

  set seccion3InicioTratamiento(String value) {
    _inicioTratamiento = value;
    notifyListeners();
  }

  set seccion3ConclusionTratamiento(String value) {
    _conclusionTratamiento = value;
    notifyListeners();
  }

  ///:::::::::::::::::::::validación::::::::::::::::::::::

  bool isValidateFormSeccion2() {
    return (seccion2Enfermedades.isNotEmpty &&
            seccion2Medicamentos.isNotEmpty &&
            seccion2EfectoSecundario != null)
        ? true
        : false;
  }

  bool isValidateFormSeccion3() {
    return (seccion3ProductoReportar.isNotEmpty &&
            seccion3Lote.isNotEmpty &&
            seccion3Indicacion.isNotEmpty &&
            seccion3ViaAdministracion.isNotEmpty &&
            seccion3Dosis.isNotEmpty &&
            seccion3InicioTratamiento.isNotEmpty &&
            seccion3ConclusionTratamiento.isNotEmpty)
        ? true
        : false;
  }

  bool isValidateFormAll() {
    return (seccion2Enfermedades.isNotEmpty &&
            seccion2Medicamentos.isNotEmpty &&
            seccion2EfectoSecundario != null &&
            seccion3ProductoReportar.isNotEmpty &&
            seccion3Lote.isNotEmpty &&
            seccion3Indicacion.isNotEmpty &&
            seccion3ViaAdministracion.isNotEmpty &&
            seccion3Dosis.isNotEmpty &&
            seccion3InicioTratamiento.isNotEmpty &&
            seccion3ConclusionTratamiento.isNotEmpty)
        ? true
        : false;
  }

  //Limpiar Form
  void cleanRegister() {
    ///Sección 2
    _motivo = "";
    _enfermedades = "";
    _medicamentos = "";

    ///Sección 3
    _producto = null;
    _productoReportar = "";
    _lote = "";
    _indicacion = "";
    _viaAdministracion = "";
    _dosis = "";
    _inicioTratamiento = CustomFuntions.formatDate(DateTime.now());
    _conclusionTratamiento = CustomFuntions.formatDate(DateTime.now());
  }
}
