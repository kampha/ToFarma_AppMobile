import 'package:flutter/material.dart';
import 'package:to_farma_app/core/models/medication.dart';
import 'package:to_farma_app/core/server/laravel_config.dart';
import 'package:to_farma_app/core/utlis/custom_colors.dart';

class MedicamentCard extends StatelessWidget {
  final Medication medication;

  const MedicamentCard({Key? key, required this.medication}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        width: double.infinity,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Row(
              children: [
                _ImagenMedicine(medication.medicine.logo),
                _InfoMedicine(medication.medicine.name, medication.dose)
              ],
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _ImagenMedicine extends StatelessWidget {
  final String url;
  const _ImagenMedicine(this.url);
  @override
  Widget build(BuildContext context) {
    const String urlBackend = LaravelConfig.baseUrl;

    return Container(
      width: 125,
      height: 125,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 5),
          child: Image.network('https://$urlBackend/storage/$url'),
        ),
      ),
    );
  }
}

class _InfoMedicine extends StatelessWidget {
  final String title;
  final String subTitle;

  const _InfoMedicine(this.title, this.subTitle);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    maxLines: 50),
                Text(
                  subTitle,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 50, 50, 50)),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MedicamentBlog extends StatelessWidget {
  final Medication post;

  const MedicamentBlog({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    const String urlBackend = LaravelConfig.baseUrl;
    final urlImg = post.medicine.logo;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          shape: BoxShape.rectangle,
        ),
        width: currentSize.width * 0.70,
        child: Column(
          children: [
            Image.network('https://$urlBackend/storage/$urlImg'),
            Container(
              //color: Colors.amber,
              height: currentSize.height * 0.18,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Text(
                    post.medicine.name,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                      fontFamily: 'Montserrat,SemiBold',
                      color: CustomColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      // Aquí puedes ajustar el tamaño del texto en función del ancho de la pantalla.
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
