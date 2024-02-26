import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:to_farma_app/app/components/componets.dart';
import 'package:to_farma_app/app/pages/pages.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/providers/providers.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class BodyPharmacovigilance extends StatefulWidget {
  const BodyPharmacovigilance({Key? key}) : super(key: key);

  @override
  State<BodyPharmacovigilance> createState() => _FormPharmacovigilance();
}

class _FormPharmacovigilance extends State<BodyPharmacovigilance> {
  int currentStep = 0;
  List<String> attachments = [];

  late PharmacovigilanceProvider _pharmacovigilance;
  late User _user;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dateTratamientoController =
      TextEditingController();
  final TextEditingController _dateConclusionController =
      TextEditingController();

  @override
  initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    _pharmacovigilance = PharmacovigilanceProvider();
    _pharmacovigilance.cleanRegister();
    _user = await userGetInfor.getInfo();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Future<void> send() async {
    final Email email = Email(
      body:
          'Hola, TÖFarma. Por este medio yo ${_user.name} les envío la información del formulario Farmacovigilancia.',
      subject: 'Farmacovigilancia - ${_user.name}',
      recipients: ['emisor.tarea@gmail.com'],
      attachmentPaths: attachments,
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print(error);
    }

    if (!mounted) return;
  }

  Future<void> actionsPDF(PDFAction action) async {
    if (!_pharmacovigilance.isValidateFormAll()) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'Validación',
        text: "Revisar el formulario",
        titleColor: CustomColors.black,
        textColor: CustomColors.black,
      );

      return;
    }

    final permissionsProvider =
        Provider.of<PermissionsProvider>(context, listen: false);

    await permissionsProvider.requestPermissionPhotos().then((value) async {
      if (permissionsProvider.galleryPermissionStatus ==
          PermissionStatus.granted) {
        String filename = CustomFuntions.removeDashes(
            CustomFuntions.convertStringFechaFormat(DateTime.now())
                .replaceAll("/", ""));

        FutureResponse response = await PdfGenerator.generatePDFBebidas(
            filename: 'Farmacovigilancia_${_user.name}_$filename.pdf',
            context: context,
            action: action,
            formulario: _pharmacovigilance,
            user: _user);

        if (PDFAction.SEND == action && response.respuesta) {
          attachments.add(response.model);
          await send();
        }

        if (response.respuesta) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.confirm,
            title: 'Farmacovigilancia',
            text: '¿Borrar información del formulario?',
            confirmBtnText: 'Si',
            cancelBtnText: 'No',
            confirmBtnColor: Colors.green,
            confirmBtnTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            onConfirmBtnTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PharmacovigilancePage(),
                ),
              );
            },
          );
        } else {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'PDF',
            text: response.mensaje,
            titleColor: CustomColors.black,
            textColor: CustomColors.black,
          );
        }
      } else {
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Permisos',
          text: "Permisos denegados, por favor habilitar!!",
          titleColor: CustomColors.black,
          textColor: CustomColors.black,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    final stepsIndex = getSteps(currentSize).length;

    return Container(
        width: currentSize.width * 1,
        height: currentSize.height * 1,
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
        child: Form(
            //key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              elevation: 15,
              physics: const ClampingScrollPhysics(),
              margin:
                  const EdgeInsets.only(top: 0, bottom: 30, left: 0, right: 0),
              onStepCancel: () => currentStep == 0
                  ? null
                  : setState(() {
                      currentStep -= 1;
                    }),
              onStepContinue: () async {
                bool isLastStep = (currentStep == stepsIndex - 1);
                if (isLastStep) {
                } else {
                  if (currentStep == 1) {
                    if (!_pharmacovigilance.isValidateFormSeccion2()) {
                      await QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        title: 'Validación',
                        text: "Revisar el formulario",
                        titleColor: CustomColors.black,
                        textColor: CustomColors.black,
                      );

                      return;
                    }
                  } else if (currentStep == 2) {
                    if (!_pharmacovigilance.isValidateFormSeccion3()) {
                      await QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        title: 'Validación',
                        text: "Revisar el formulario",
                        titleColor: CustomColors.black,
                        textColor: CustomColors.black,
                      );

                      return;
                    }
                  }

                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                if (currentStep == 0) {
                  return Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 0, left: 0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: controls.onStepContinue,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.buttonEnabled,
                                fixedSize: Size(currentSize.width * 0.40,
                                    currentSize.height * 0.05),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('SIGUIENTE'),
                                  Icon(Icons.arrow_forward_rounded),
                                ]),
                          ),
                        ],
                      ));
                } else if (currentStep > 0 && (currentStep + 1) < stepsIndex) {
                  return Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 0, left: 0, right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: controls.onStepCancel,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.buttonRedEnable,
                                fixedSize: Size(currentSize.width * 0.40,
                                    currentSize.height * 0.05),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Icon(Icons.arrow_back_rounded),
                                  Text('REGRESAR'),
                                ]),
                          ),
                          ElevatedButton(
                            onPressed: controls.onStepContinue,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColors.buttonEnabled,
                                fixedSize: Size(currentSize.width * 0.40,
                                    currentSize.height * 0.05),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('SIGUIENTE'),
                                  Icon(Icons.arrow_forward_rounded),
                                ]),
                          ),
                        ],
                      ));
                } else {
                  return Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 50, left: 0, right: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: controls.onStepCancel,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.buttonRedEnable,
                                  fixedSize: Size(currentSize.width * 0.40,
                                      currentSize.height * 0.05),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(Icons.arrow_back_rounded),
                                    Text('REGRESAR'),
                                  ]),
                            ),
                          ]));
                }
              },
              onStepTapped: (step) => setState(() {
                currentStep = step;
              }),
              steps: getSteps(currentSize),
            )));
  }

  List<Step> getSteps(Size currentSize) {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text(
          "Sección 1",
          style: TextStyle(color: CustomColors.black),
        ),
        content: Card(
          elevation: 50,
          shadowColor: CustomColors.black,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 25, left: 20, right: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: CustomColors.ButtonEnabledAction,
                    radius: 105,
                    child: CircleAvatar(
                      backgroundColor: CustomColors.white,
                      backgroundImage:
                          AssetImage(_pharmacovigilance.seccion1Image),
                      radius: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _pharmacovigilance.seccion1Titulo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      color: CustomColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    _pharmacovigilance.seccion1Descripcion,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.black,
                    ),
                  ), //
                ],
              ),
            ),
          ),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text(
          "Sección 2",
          style: TextStyle(color: CustomColors.black),
        ),
        content: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.multiline,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(500)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Descripción (opcional)',
                      labeltext: '¿Cuál es el motivo de consulta?',
                      prefixicon: const Icon(Icons.description),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  onChanged: (value) {
                    _pharmacovigilance.seccion2Motivo = value;
                  },
                  maxLines: 5,
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(150)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Texto de respuesta corta',
                      labeltext: '¿Qué enfermedades padece?',
                      prefixicon: const Icon(Icons.wrap_text_outlined),
                      borderRadius: const BorderRadius.only()),
                  onChanged: (value) {
                    _pharmacovigilance.seccion2Enfermedades = value;
                  },
                  maxLines: 2,
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(150)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Texto de respuesta corta',
                      labeltext: '¿Cuáles medicamentos toma?',
                      prefixicon: const Icon(Icons.wrap_text_outlined),
                      borderRadius: const BorderRadius.only()),
                  onChanged: (value) {
                    _pharmacovigilance.seccion2Medicamentos = value;
                  },
                  maxLines: 2,
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 5, right: 5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    border: Border.all(
                        color: Colors.grey, style: BorderStyle.solid)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 0, left: 20, right: 20),
                      child: Text(
                          '¿Ha presentado antes algún efecto secundario a otro medicamento?',
                          style: TextStyle(
                              fontSize: currentSize.width * 0.045,
                              color: CustomColors.lightGray,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal)),
                    ),
                    ListTile(
                      title: Text('Sí',
                          style: TextStyle(
                              fontSize: currentSize.width * 0.040,
                              color: CustomColors.lightGray,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal)),
                      leading: Radio<EfectoSecundario>(
                        value: EfectoSecundario.si,
                        groupValue: _pharmacovigilance.seccion2EfectoSecundario,
                        onChanged: (EfectoSecundario? value) {
                          setState(() {
                            _pharmacovigilance.seccion2EfectoSecundario = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('No',
                          style: TextStyle(
                              fontSize: currentSize.width * 0.040,
                              color: CustomColors.lightGray,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal)),
                      leading: Radio<EfectoSecundario>(
                        value: EfectoSecundario.no,
                        groupValue: _pharmacovigilance.seccion2EfectoSecundario,
                        onChanged: (EfectoSecundario? value) {
                          setState(() {
                            _pharmacovigilance.seccion2EfectoSecundario = value;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text(
          "Sección 3",
          style: TextStyle(color: CustomColors.black),
        ),
        content: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.multiline,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(500)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Descripción (opcional)',
                      labeltext: 'Producto',
                      prefixicon: const Icon(Icons.description),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  onChanged: (value) {
                    _pharmacovigilance.seccion3Producto = value;
                  },
                  maxLines: 5,
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(150)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Texto de respuesta corta',
                      labeltext: 'Producto a reportar',
                      prefixicon: const Icon(Icons.wrap_text_outlined),
                      borderRadius: const BorderRadius.only()),
                  onChanged: (value) {
                    _pharmacovigilance.seccion3ProductoReportar = value;
                  },
                  maxLines: 2,
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(150)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Texto de respuesta corta',
                      labeltext: 'Lote',
                      prefixicon: const Icon(Icons.wrap_text_outlined),
                      borderRadius: const BorderRadius.only()),
                  onChanged: (value) {
                    _pharmacovigilance.seccion3Lote = value;
                  },
                  maxLines: 2,
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(150)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Texto de respuesta corta',
                      labeltext: 'Indicación',
                      prefixicon: const Icon(Icons.wrap_text_outlined),
                      borderRadius: const BorderRadius.only()),
                  onChanged: (value) {
                    _pharmacovigilance.seccion3Indicacion = value;
                  },
                  maxLines: 2,
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(150)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Texto de respuesta corta',
                      labeltext: 'Vía de administración',
                      prefixicon: const Icon(Icons.wrap_text_outlined),
                      borderRadius: const BorderRadius.only()),
                  onChanged: (value) {
                    _pharmacovigilance.seccion3ViaAdministracion = value;
                  },
                  maxLines: 2,
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(150)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'Texto de respuesta corta',
                      labeltext: 'Dosis (cantidad y cuántas veces al día)',
                      prefixicon: const Icon(Icons.wrap_text_outlined),
                      borderRadius: const BorderRadius.only()),
                  onChanged: (value) {
                    _pharmacovigilance.seccion3Dosis = value;
                  },
                  maxLines: 2,
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  controller: _dateTratamientoController,
                  onTap: () => _selectDateInicioTratamiento(context),
                  keyboardType: TextInputType.none,
                  readOnly: false,
                  autofocus: false,
                  inputFormatters: <TextInputFormatter>[
                    RegularExpressions.formatterDateTime,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'año-mes-día',
                      labeltext: 'Inicio del tratamiento',
                      prefixicon: const Icon(Icons.calendar_month_outlined),
                      borderRadius: const BorderRadius.only()),
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: TextFormField(
                  autocorrect: false,
                  controller: _dateConclusionController,
                  onTap: () => _selectDateConclusionTratamiento(context),
                  keyboardType: TextInputType.none,
                  readOnly: false,
                  autofocus: false,
                  inputFormatters: <TextInputFormatter>[
                    RegularExpressions.formatterDateTime,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  style: Fonts.robotoRegularBlack,
                  decoration: InputDecorationCustom.getInputDecorationPharmaco(
                      context: context,
                      hintext: 'año-mes-día',
                      labeltext: 'Conclusión del tratamiento',
                      prefixicon: const Icon(Icons.calendar_month_outlined),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, left: 0, right: 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async =>
                            {await actionsPDF(PDFAction.SEND)},
                        style: ElevatedButton.styleFrom(
                            elevation: 15,
                            backgroundColor: CustomColors.white,
                            fixedSize: Size(currentSize.width * 0.20,
                                currentSize.height * 0.05),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Icon(
                          Icons.send,
                          color: CustomColors.ButtonEnabledAction,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async =>
                            {await actionsPDF(PDFAction.SAVE)},
                        style: ElevatedButton.styleFrom(
                            elevation: 15,
                            backgroundColor: CustomColors.white,
                            fixedSize: Size(currentSize.width * 0.20,
                                currentSize.height * 0.05),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Icon(
                          Icons.save,
                          color: CustomColors.ButtonEnabledAction,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async =>
                            {await actionsPDF(PDFAction.SHARE)},
                        style: ElevatedButton.styleFrom(
                            elevation: 15,
                            backgroundColor: CustomColors.white,
                            fixedSize: Size(currentSize.width * 0.20,
                                currentSize.height * 0.05),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Icon(
                          Icons.share,
                          color: CustomColors.ButtonEnabledAction,
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    ];
  }

  ///funciones
  Future<void> _selectDateInicioTratamiento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      _pharmacovigilance.seccion3InicioTratamiento =
          CustomFuntions.formatDate(_selectedDate);
      _dateTratamientoController.text =
          _pharmacovigilance.seccion3InicioTratamiento;
      setState(() {
        _selectedDate = picked;
        _pharmacovigilance.seccion3InicioTratamiento =
            CustomFuntions.formatDate(_selectedDate);
        _dateTratamientoController.text =
            _pharmacovigilance.seccion3InicioTratamiento;
      });
    }
  }

  Future<void> _selectDateConclusionTratamiento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      _pharmacovigilance.seccion3ConclusionTratamiento =
          CustomFuntions.formatDate(_selectedDate);
      _dateConclusionController.text =
          _pharmacovigilance.seccion3ConclusionTratamiento;
      setState(() {
        _selectedDate = picked;
        _pharmacovigilance.seccion3ConclusionTratamiento =
            CustomFuntions.formatDate(_selectedDate);
        _dateConclusionController.text =
            _pharmacovigilance.seccion3ConclusionTratamiento;
      });
    }
  }
}
