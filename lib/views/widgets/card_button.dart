import 'package:app_study_violin/config/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String buttonText;
  final IconData iconData;
  final bool isActive;
  final VoidCallback onPressed;

  const CardButton({
    Key? key,
    required this.buttonText,
    required this.iconData,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Card(
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(16.0), // Esquina superior izquierda redondeada
            topRight: Radius.zero, // Esquina superior derecha recta
            bottomLeft: Radius.zero, // Esquina inferior izquierda recta
            bottomRight:
                Radius.circular(16.0), // Esquina inferior derecha redondeada
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    10.0), // Ajusta el padding según sea necesario
                child: Text(
                  buttonText,
                  style: AppFonts.smallsmallTextStyle,
                ),
              ),
              const SizedBox(height: 8),
              Visibility(
                visible: isActive,
                child: Icon(
                  iconData,
                  size: 24,
                  color: Colors
                      .green, // Puedes ajustar el color según tus necesidades
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
