import 'package:app_study_violin/models/api_response.dart';
import 'package:app_study_violin/models/ejercicio.dart';
import 'package:app_study_violin/views/widgets/card_button.dart';
import 'package:app_study_violin/views/widgets/card_head.dart';
import 'package:flutter/material.dart';
import 'package:app_study_violin/config/theme/app_colors.dart';
import 'package:app_study_violin/config/theme/app_fonts.dart';
import 'package:app_study_violin/services/estudio_service.dart';

class ContenidoEvaluacionScreen extends StatefulWidget {
  final String nombreEjercicio;
  final String descripcionEjercicio;
  final int idEjercicio;

  const ContenidoEvaluacionScreen(
      {Key? key,
      required this.nombreEjercicio,
      required this.idEjercicio,
      required this.descripcionEjercicio})
      : super(key: key);

  @override
  State<ContenidoEvaluacionScreen> createState() => _ContenidoScreenState();
}

class _ContenidoScreenState extends State<ContenidoEvaluacionScreen> {
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
          'Evaluación',
          style: TextStyle(
            color: Colors.white, // Cambiar el color del texto del título
          ),
        ),
      ),
      body: Container(
        color: AppColors.bgSecondaryColor, // Color de fondo del ListView
      ),
    );
  }
}
