import 'package:app_study_violin/views/screens/practica_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_study_violin/config/theme/app_colors.dart';
import 'package:app_study_violin/config/theme/app_fonts.dart';
import 'package:app_study_violin/services/estudio_service.dart';
import 'package:app_study_violin/models/api_response.dart';
import 'package:app_study_violin/models/estudio.dart';

class EstudioScreen extends StatelessWidget {
  const EstudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              AppColors.bgPrimaryColor, // Cambiar el color de la AppBar

          title: const Text(
            'Estudy Violin',
            style: TextStyle(
              color: Colors.white, // Cambiar el color del texto del título
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Práctica'),
              Tab(text: 'Evaluación'),
              Tab(text: 'Afinador'),
            ],
            labelColor: Colors
                .white, // Cambiar el color del texto de las pestañas activas a blanco
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: const Color.fromARGB(255, 255, 255, 255), // Color de fondo para TabBarView
          // color: AppColors.bgSecondaryColor, // Establecer el color de fondo aquí
          child: const TabBarView(
            children: [
              PracticeTab(), // Mostrar contenido de Práctica
              Center(
                child: Text('Contenido de Evaluación'),
              ),
              Center(
                child: Text('Contenido de Afinador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PracticeTab extends StatelessWidget {
  const PracticeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<ApiResponse>(
        future: getEstudios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final apiResponse = snapshot.data;

            if (apiResponse != null && apiResponse.data is List<Estudio>) {
              final estudiosList = apiResponse.data as List<Estudio>;

              return Center(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: estudiosList.map((estudio) {
                    return PracticeButton(
                      title: estudio.nombre ?? '',
                      contenido: estudio.puntosrequeridos ?? '',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => const PracticaScreen(),
                            builder: (context) => PracticaScreen(
                                nombreEstudio: estudio.nombre ?? '',
                                idEstudio: estudio.id ?? 1),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            } else {
              return const Text('Los datos no tienen el formato esperado');
            }
          } else {
            return const Text('No se encontraron datos');
          }
        },
      ),
    );
  }
}

class PracticeButton extends StatelessWidget {
  final String title;
  final String contenido;
  final Color backgroundColor;
  final VoidCallback? onTap; // Cambiado de Function() a VoidCallback?

  const PracticeButton({
    Key? key,
    required this.title,
    required this.contenido,
    this.backgroundColor = AppColors.colorWhite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: backgroundColor,
      
      child: InkWell(
      
        onTap: onTap,
        child: SizedBox(
          width: 280,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppFonts.heading2Style,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(
                        8.0), // Ajusta el valor según sea necesario
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('lib/images/tecnicalogo.jpg'),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Puntos Requeridos:', // Ajusta según sea necesario
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          contenido,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4), // Ajusta según sea necesario
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
