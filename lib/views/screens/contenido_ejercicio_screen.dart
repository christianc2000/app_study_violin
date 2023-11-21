import 'package:app_study_violin/models/api_response.dart';
import 'package:app_study_violin/models/contenido.dart';
import 'package:app_study_violin/models/ejercicio.dart';
import 'package:app_study_violin/views/widgets/card_button.dart';
import 'package:app_study_violin/views/widgets/card_head.dart';
import 'package:app_study_violin/views/widgets/card_move.dart';
import 'package:flutter/material.dart';
import 'package:app_study_violin/config/theme/app_colors.dart';
import 'package:app_study_violin/config/theme/app_fonts.dart';
import 'package:app_study_violin/services/estudio_service.dart';
import 'package:app_study_violin/views/screens/camera_screen.dart';

class ContenidoEjercicioScreen extends StatefulWidget {
  final String nombreEjercicio;
  final String descripcionEjercicio;
  final int idEjercicio;

  const ContenidoEjercicioScreen(
      {Key? key,
      required this.nombreEjercicio,
      required this.idEjercicio,
      required this.descripcionEjercicio})
      : super(key: key);

  @override
  State<ContenidoEjercicioScreen> createState() => _ContenidoScreenState();
}

class _ContenidoScreenState extends State<ContenidoEjercicioScreen> {
  @override
  void initState() {
    super.initState();
    print('ContenidoScreen iniciado para ${widget.nombreEjercicio}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimaryColor,
        title: const Text(
          'Ejercicio',
          style: TextStyle(
            color: Colors.white, // Cambiar el color del texto del título
          ),
        ),
      ),
      body: Container(
          color: AppColors.bgSecondaryColor, // Color de fondo del ListView
          child: ContentEjercicio(
              descripcionEjercicio: widget.descripcionEjercicio,
              nombreEjercicio: widget.nombreEjercicio,
              idEjercicio: widget.idEjercicio)),
    );
  }
}

class ContentEjercicio extends StatelessWidget {
  final String nombreEjercicio;
  final String descripcionEjercicio;
  final int idEjercicio;

  const ContentEjercicio(
      {super.key,
      required this.idEjercicio,
      required this.descripcionEjercicio,
      required this.nombreEjercicio});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
      future: getContenido(idEjercicio),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final apiResponse = snapshot.data;
          if (apiResponse != null && apiResponse.data is List<Contenido>) {
            final contenidoList = apiResponse.data as List<Contenido>;

            return SingleChildScrollView(
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: SizedBox(
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
                                  Text(
                                    " $nombreEjercicio ",
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
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Descripcion",
                              style: AppFonts.smallsmallTextStyle,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, bottom: 2.0),
                            child: Text(
                              descripcionEjercicio,
                              style: AppFonts.parrafoTextStyle,
                            ),
                          ),
                          CardMove(listaContenidos: contenidoList),
                          const SizedBox(
                              height:
                                  16.0), // Agrega un espacio entre CardMove y los botones
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CameraScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4.0), // Ajusta según sea necesario
                                  ),
                                ),
                                child: const Text('Espejo'),
                              ),
                              const SizedBox(
                                  width:
                                      8.0), // Ajusta el espacio entre los botones
                              ElevatedButton(
                                onPressed: () {
                                  // Acciones cuando se presiona el segundo botón
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4.0), // Ajusta según sea necesario
                                  ),
                                ),
                                child: const Text('Siguiente'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: const CardComponent(
                        data: [
                          {'icon': Icons.book, 'valor': '1'},
                          {'icon': Icons.star, 'valor': '3000'},
                        ],
                        width: 200.0,
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
