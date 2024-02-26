import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_farma_app/app/screens/screen.dart';
import 'package:to_farma_app/app/widgets/widgets.dart';
import 'package:to_farma_app/core/models/models.dart';
import 'package:to_farma_app/core/services/services.dart';

class MedicamentsScreen extends StatefulWidget {
  const MedicamentsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BodyMedicament();
}

class _BodyMedicament extends State<MedicamentsScreen> {
  late List<MedicationInformationGroup> _medicamentos =
      <MedicationInformationGroup>[];
  bool sinMedicamentos = false;
  @override
  initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _medicamentos = (await medicationsServices.getMedicationsGroup());
    sinMedicamentos = _medicamentos.isEmpty;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBarMenu(
          height: currentSize.height * 0.14,
          title: 'Medicamentos',
          menudisplay: false),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: _medicamentos.isEmpty && !sinMedicamentos
              ? Center(child: LoadingProgress())
              : Column(children: [
                  if (sinMedicamentos)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: const Text(
                          'Sin Medicamentos',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  CarrouselMedicament(
                    medicamentos: _medicamentos,
                  )
                ])),
    );
  }
}

class CarrouselMedicament extends StatelessWidget {
  final List<MedicationInformationGroup> medicamentos;
  const CarrouselMedicament({super.key, required this.medicamentos});

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    final medicationServices =
        Provider.of<MedicationsServices>(context).getTodayMedication();

    return Container(
      width: double.infinity,
      height: currentSize.height * 0.80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: medicamentos.length,
        itemBuilder: (context, int index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (medicamentos[index].items.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: medicamentos[index].group),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 25),
                              child: IndicatorIcon(
                                  indicator: medicamentos[index].group),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: medicamentos[index].items.length,
                  itemBuilder: (context, int index2) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 5, left: 10, right: 10),
                            child: Text(
                              medicamentos[index].items[index2].horario,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: medicamentos[index]
                                .items[index2]
                                .medicamentos
                                .length,
                            itemBuilder: (context, int index3) {
                              return MedicamentCard(
                                  medication: medicamentos[index]
                                          .items[index2]
                                          .medicamentos[
                                      index3]); // crea un CardBlog para cada objeto Post
                            },
                          )
                        ]); // crea un CardBlog para cada objeto Post
                  },
                )
              ]); // crea un CardBlog para cada objeto Post
        },
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  final String title;
  const TextTitle({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
