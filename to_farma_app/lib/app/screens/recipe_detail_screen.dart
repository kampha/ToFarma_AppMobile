import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/services/services.dart';
import 'package:to_farma_app/core/utlis/utlis.dart';

class BodyRecipeDetail extends StatefulWidget {
  final int rmid;
  final String numeroreceta;
  final String hospital;

  const BodyRecipeDetail(
      {Key? key,
      required this.rmid,
      required this.numeroreceta,
      required this.hospital})
      : super(key: key);

  @override
  State<BodyRecipeDetail> createState() => _CardRecipeDetail();
}

class _CardRecipeDetail extends State<BodyRecipeDetail> {
  late RecetaMedicaDetalleService _services;
  late FutureResponse _futureResponse = FutureResponse(respuesta: false);

  @override
  initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _services = RecetaMedicaDetalleService();
    _futureResponse = await _services.getRecetaMedicaDetalle(
        widget.numeroreceta, widget.rmid);

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (_services.isLoading) {
      return LoadingProgress();
    } else {
      if (_futureResponse.respuesta) {
        List<DatumRMD> data = _futureResponse.model.data;

        return Container(
            margin:
                const EdgeInsets.only(top: 15, bottom: 5, left: 5, right: 5),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 0, left: 10, right: 10),
                          child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(195, 230, 229, 229),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      topRight: Radius.circular(30))),
                              child: _ImagenMedicineDetail(
                                  data[index].medicina.imagen ?? '')),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 10, left: 10, right: 10),
                            child: Container(
                              width: double.infinity,
                              decoration: _cardBorders(),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 10, right: 10),
                                  child: _InfoMedicineDetail(
                                      data[index].medicina.descripcion,
                                      data[index].dosis.toString(),
                                      data[index].unidadDosis,
                                      data[index].frecuencia.toString(),
                                      data[index].unidadFrecuencia,
                                      data[index].duracion.toString(),
                                      data[index].unidadDuracion),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        bottom: 20,
                                        left: 10,
                                        right: 10),
                                    child: ButtonActionWidget(
                                      function: () async {
                                        FocusScope.of(context).unfocus();

                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.confirm,
                                          title: 'Notificar',
                                          text:
                                              '¿Está seguro de configurar ${data[index].medicina.descripcion}?',
                                          confirmBtnText: 'Si, Notificar',
                                          cancelBtnText: 'No',
                                          confirmBtnColor: Colors.green,
                                          confirmBtnTextStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          customAsset: Assets.logoTofarma,
                                          onConfirmBtnTap: () async {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop(false);

                                            LoadingProgress();

                                            MedicacionService
                                                medicationsService =
                                                MedicacionService();

                                            final futureResponse =
                                                await medicationsService
                                                    .postMedicacion(widget.rmid,
                                                        data[index].id);

                                            if (futureResponse.respuesta) {
                                              Medicacion medicacion =
                                                  futureResponse.model;

                                              await QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.success,
                                                title: 'Configuración',
                                                text: medicacion.message,
                                                autoCloseDuration:
                                                    const Duration(seconds: 10),
                                              );
                                            } else {
                                              await QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.info,
                                                title: 'Configuración',
                                                text: futureResponse.mensaje,
                                                backgroundColor: Colors.black,
                                                titleColor: Colors.white,
                                                textColor: Colors.white,
                                              );
                                            }
                                          },
                                        );
                                      },
                                      titleButton: 'Iniciar medicación',
                                    )),
                              ]),
                            )),
                      ]),
                    )));
      } else {
        return SizedBox(child: TextError(error: _futureResponse.mensaje));
      }
    }
  }

  BoxDecoration _cardBorders() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _ImagenMedicineDetail extends StatelessWidget {
  final String url;

  const _ImagenMedicineDetail(this.url);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      height: 175,
      width: 175,
    );
  }
}

class _InfoMedicineDetail extends StatelessWidget {
  final String title;
  final String dosis;
  final String unidadDosis;
  final String frecuencia;
  final String unidadFrecuencia;
  final String duracion;
  final String unidadDuracion;

  const _InfoMedicineDetail(
      this.title,
      this.dosis,
      this.unidadDosis,
      this.frecuencia,
      this.unidadFrecuencia,
      this.duracion,
      this.unidadDuracion);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          maxLines: 50,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "$dosis $unidadDosis (CADA $frecuencia $unidadFrecuencia) DURANTE $duracion $unidadDuracion",
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 50, 50, 50)),
          maxLines: 50,
        ),
      ]),
    );
  }
}
