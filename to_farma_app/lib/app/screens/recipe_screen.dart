import 'package:flutter/material.dart';
import 'package:to_farma_app/app/pages/pages.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/services/services.dart';

class BodyRecipe extends StatefulWidget {
  const BodyRecipe({Key? key}) : super(key: key);

  @override
  State<BodyRecipe> createState() => _CardRecipe();
}

class _CardRecipe extends State<BodyRecipe> {
  late RecetaMedicaService _services;
  late FutureResponse _futureResponse = FutureResponse(respuesta: false);

  @override
  initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    _services = RecetaMedicaService();
    _futureResponse = await _services.getRecetaMedica();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (_services.isLoading) {
      return LoadingProgress();
    } else {
      if (_futureResponse.respuesta) {
        final List<DatumRM> data = _futureResponse.model.data;

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
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: Container(
                              width: double.infinity,
                              decoration: _cardBorders(),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 10, right: 10),
                                  child: _InfoRecetaMedica(
                                      //usar una clase para este mapeo
                                      data[index].numero,
                                      data[index].medico.nombreCompleto,
                                      data[index].fechaHora,
                                      data[index].hospital.nombre,
                                      data[index].id),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        bottom: 20,
                                        left: 10,
                                        right: 10),
                                    child: ButtonActionWidget(
                                      function: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RecipeDetailPage(),
                                              settings:
                                                  RouteSettings(arguments: {
                                                'rmid': data[index].id,
                                                'numeroreceta':
                                                    data[index].numero,
                                                'hospital':
                                                    data[index].hospital.nombre,
                                              })),
                                        );
                                      },
                                      titleButton: 'ver medicamentos',
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

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _InfoRecetaMedica extends StatelessWidget {
  final String numeroreceta;
  final String fechahora;
  final String medico;
  final String hospital;
  final int rmid;

  const _InfoRecetaMedica(
      this.numeroreceta, this.medico, this.fechahora, this.hospital, this.rmid);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                const WidgetSpan(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                    child: Icon(
                      Icons.receipt,
                      size: 35,
                    ),
                  ),
                ),
                TextSpan(text: numeroreceta),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 25, color: Colors.black),
              children: [
                const WidgetSpan(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                    child: Icon(
                      Icons.local_hospital_sharp,
                      size: 35,
                    ),
                  ),
                ),
                TextSpan(text: hospital),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 25, color: Colors.black),
              children: [
                const WidgetSpan(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                    child: Icon(
                      Icons.date_range_rounded,
                      size: 35,
                    ),
                  ),
                ),
                TextSpan(text: fechahora),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 25, color: Colors.black),
              children: [
                const WidgetSpan(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                ),
                TextSpan(text: medico),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
