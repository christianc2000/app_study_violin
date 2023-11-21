import 'package:app_study_violin/config/constants/api_routes.dart';
import 'package:app_study_violin/models/api_response.dart';
import 'package:app_study_violin/models/ejercicio.dart';
import 'package:app_study_violin/views/screens/contenido_ejercicio_screen.dart';
import 'package:app_study_violin/views/screens/contenido_evaluacion_screen.dart';
import 'package:app_study_violin/views/widgets/card_button.dart';
import 'package:app_study_violin/views/widgets/card_head.dart';
import 'package:flutter/material.dart';
import 'package:app_study_violin/config/theme/app_colors.dart';
import 'package:app_study_violin/config/theme/app_fonts.dart';
import 'package:app_study_violin/services/estudio_service.dart';

class EjercicioScreen extends StatefulWidget {
  final String nombrePractica;
  final int idPractica;
  final String urlPractica;

  const EjercicioScreen(
      {Key? key,
      required this.nombrePractica,
      required this.idPractica,
      required this.urlPractica})
      : super(key: key);

  @override
  State<EjercicioScreen> createState() => _EjercicioScreenState();
}

class _EjercicioScreenState extends State<EjercicioScreen> {
  @override
  void initState() {
    super.initState();
    print('EjercicioScreen iniciado para ${widget.nombrePractica}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimaryColor,
      ),
      body: Container(
        color: AppColors.bgSecondaryColor, // Color de fondo del ListView
        child: ListView(
          children: [
            HeadContent(
              nombrePractica: widget.nombrePractica,
              idPractica: widget.idPractica,
              urlEjercicio: widget.urlPractica,
            ),
            ContentEjercicio(idPractica: widget.idPractica),
            ContentEvaluacion(idPractica: widget.idPractica),
          ],
        ),
      ),
    );
  }
}

class HeadContent extends StatelessWidget {
  final String nombrePractica;
  final int idPractica;
  final String urlEjercicio;

  const HeadContent(
      {Key? key,
      required this.nombrePractica,
      required this.idPractica,
      required this.urlEjercicio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: AppColors.bgPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 12),
                    child: Text(
                      nombrePractica,
                      style: AppFonts.heading2BoldStyle,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 0),
                    child: Text(
                      "study violín",
                      style: AppFonts.smallWhiteTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 40,
              color: AppColors.bgSecondaryColor,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      urlEjercicio,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentEjercicio extends StatelessWidget {
  final int idPractica;

  const ContentEjercicio({Key? key, required this.idPractica})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
      future: getEjercicio(idPractica),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final apiResponse = snapshot.data;
          if (apiResponse != null && apiResponse.data is List<Ejercicio>) {
            final ejercicioList = apiResponse.data as List<Ejercicio>;

            return Container(
              color: AppColors
                  .bgSecondaryColor, // Cambia al color de fondo que desees
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 80),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.textColor2,
                                    shape: BoxShape.rectangle,
                                  ),
                                ),
                                const Text(
                                  ' Ejercicio ',
                                  style: AppFonts.smallTextBoldStyle,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColors.textColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 140, // Altura fija para la lista horizontal
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: ejercicioList.map((ejercicio) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, right: 10.0),
                                  child: CardButton(
                                    buttonText: ejercicio.nombre ?? "",
                                    iconData: Icons.check,
                                    isActive: true,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ContenidoEjercicioScreen(
                                                  nombreEjercicio:
                                                      ejercicio.nombre ?? "",
                                                  descripcionEjercicio:
                                                      ejercicio.descripcion ??
                                                          "",
                                                  idEjercicio:
                                                      ejercicio.id ?? 1),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: const CardComponent(
                        data: [
                          {'icon': Icons.book, 'valor': '2/20'},
                          {'icon': Icons.star, 'valor': '3000/1500'},
                          {'icon': Icons.content_copy, 'valor': '0/18'},
                        ],
                        width: 250.0,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Los datos no tienen el formato esperado');
          }
        } else {
          return const Text('No se encontraron datos');
        }
      },
    );
  }
}

class ContentEvaluacion extends StatelessWidget {
  final int idPractica;

  const ContentEvaluacion({super.key, required this.idPractica});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
      future: getEvaluacion(idPractica),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final apiResponse = snapshot.data;
          if (apiResponse != null && apiResponse.data is List<Ejercicio>) {
            final evaluacionList = apiResponse.data as List<Ejercicio>;

            return Container(
              color: AppColors
                  .bgSecondaryColor, // Color de fondo del container principal
              child: Container(
                color: AppColors.bgSecondaryColor, // Color de fondo del padding
                padding: const EdgeInsets.only(
                    bottom:
                        16.0), // Ajusta el espacio inferior según sea necesario
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: AppColors.textColor2,
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  const Text(
                                    ' Evaluación',
                                    style: AppFonts.smallTextBoldStyle,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: AppColors.textColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  140, // Altura fija para la lista horizontal
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: evaluacionList.map((evaluacion) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, right: 10.0),
                                    child: CardButton(
                                      buttonText: evaluacion.nombre ?? "",
                                      iconData: Icons.check,
                                      isActive: true,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ContenidoEvaluacionScreen(
                                                    nombreEjercicio:
                                                        evaluacion.nombre ?? "",
                                                    descripcionEjercicio:
                                                        evaluacion
                                                                .descripcion ??
                                                            "",
                                                    idEjercicio:
                                                        evaluacion.id ?? 1),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('Los datos no tienen el formato esperado');
          }
        } else {
          return const Text('No se encontraron datos');
        }
      },
    );
  }
}





// class MainContent extends StatelessWidget {
//   final int idPractica;
//   const MainContent({super.key, required this.idPractica});

//   @override
//   Widget build(BuildContext context) {
//   }
// }
