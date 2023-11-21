import 'package:app_study_violin/config/theme/app_fonts.dart';
import 'package:flutter/material.dart';
class CardComponent extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double width;

  const CardComponent({
    Key? key,
    required this.data,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double iconSize = 20.0; // Tamaño del ícono (puedes ajustarlo según tus necesidades)
    const double spacing = 4.0; // Espaciado entre el ícono y el valor

    // Calcula el ancho de cada sección

    return SizedBox(
      width: width,
      child: Card(
        elevation: 4.0, // Elevación de la tarjeta (ajústalo según tus necesidades)
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Espaciado interno de la tarjeta
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              data.length,
              (index) {
                return Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        data[index]['icon'],
                        size: iconSize,
                      ),
                      const SizedBox(height: spacing),
                      Text(
                        data[index]['valor'],
                        textAlign: TextAlign.center,
                        style: AppFonts.smallsmallTextStyle,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}