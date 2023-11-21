import 'package:app_study_violin/config/theme/app_colors.dart';
import 'package:app_study_violin/config/theme/app_fonts.dart';
import 'package:app_study_violin/models/contenido.dart';
import 'package:flutter/material.dart';

class CardMove extends StatelessWidget {
  final List<Contenido> listaContenidos;

  const CardMove({Key? key, required this.listaContenidos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310.0, // Ajusta la altura según tus necesidades
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listaContenidos.length,
        itemBuilder: (context, index) {
          Contenido contenido = listaContenidos[index];
          return SizedBox(
            width: 200.0, // Ajusta el ancho según tus necesidades
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        contenido.url ?? "",
                        fit: BoxFit.cover,
                        height: 310.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    right: 22.0,
                    child: Container(
                      width: 16.0,
                      height: 16.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // Puedes cambiar el color según sea necesario
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          contenido.posicion ?? "1",
                          style: const TextStyle( fontSize: 14,fontWeight: FontWeight.bold, color: AppColors.colorWhite),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
