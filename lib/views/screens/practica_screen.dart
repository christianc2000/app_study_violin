import 'package:app_study_violin/services/estudio_service.dart';
import 'package:app_study_violin/views/screens/ejercicio_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_study_violin/config/theme/app_colors.dart';
import 'package:app_study_violin/config/theme/app_fonts.dart';
import 'package:app_study_violin/models/api_response.dart';
import 'package:app_study_violin/models/practica.dart';
import 'package:app_study_violin/views/widgets/card_head.dart';

class PracticaScreen extends StatefulWidget {
  final String nombreEstudio;
  final int idEstudio;
  const PracticaScreen(
      {super.key, required this.nombreEstudio, required this.idEstudio});
  @override
  State<PracticaScreen> createState() => _PracticaScreenState();
}

class _PracticaScreenState extends State<PracticaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nombreEstudio,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.bgPrimaryColor,
      ),
      body: Stack(
        children: [
          Container(
            color:
                AppColors.colorWhite, // Puedes cambiar esto al color que desees
          ),
          ContentPractice(idEstudio: widget.idEstudio)
        ],
      ),
    );
  }
}

class ContentPractice extends StatelessWidget {
  final int idEstudio;

  const ContentPractice({super.key, required this.idEstudio});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
      future: getPracticas(idEstudio),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final apiResponse = snapshot.data;
          if (apiResponse != null && apiResponse.data is List<Practica>) {
            final practicaList = apiResponse.data as List<Practica>;

            return Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(
                      children: practicaList.map((practica) {
                        final index = practicaList.indexOf(practica);
                        return Padding(
                          padding:
                              EdgeInsets.only(top: index == 0 ? 100.0 : 10.0),
                          child: TarjetaButton(
                            nombre: practica.nombre ?? "",
                            url: practica.url ?? "",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EjercicioScreen(
                                    nombrePractica: practica.nombre ?? "",
                                    idPractica: practica.id ?? 1,
                                    urlPractica: practica.url ?? "",
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
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
                        {'icon': Icons.event, 'valor': '21/11/2023'},
                        {'icon': Icons.star, 'valor': '3000'},
                      ],
                      width: 200.0,
                    ),
                  ),
                ),
              ],
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

class TarjetaButton extends StatelessWidget {
  final String nombre;
  final String url;
  final VoidCallback? onTap;

  const TarjetaButton({
    Key? key,
    required this.nombre,
    required this.url,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(url),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32.0),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nombre, style: AppFonts.heading3Style),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
