import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

enum WidgetState { NONE, LOADING, LOADED, ERROR }

class _CameraScreenState extends State<CameraScreen> {
  WidgetState _widgetState = WidgetState.NONE;
  List<CameraDescription> _cameras = [];
  late CameraController _cameraController;
  late int _timerSeconds;
  bool _timerActive = false;
  XFile? _capturedImage; // Almacenar la imagen capturada

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _timerSeconds = 5; // Tiempo en segundos (por ejemplo, 3 segundos)
      _timerActive = true;
    });

    _countdownTimer();
  }

  void _countdownTimer() async {
    while (_timerSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _timerSeconds--;
      });
    }
    _takePicture();
  }

  void _takePicture() async {
    try {
      final XFile capturedImage = await _cameraController.takePicture();
      setState(() {
        _capturedImage = capturedImage; // Mostrar la imagen capturada
      });
    } catch (e) {
      print('Error al capturar la imagen: $e');
    }
  }

  void _initializeCamera() async {
    setState(() {
      _widgetState = WidgetState.LOADING;
    });

    _cameras = await availableCameras();

    CameraDescription? selectedCamera;

    for (final camera in _cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        selectedCamera = camera;
        break;
      }
    }

    if (selectedCamera == null) {
      // No se encontró una cámara frontal, selecciona la primera cámara disponible.
      if (_cameras.isNotEmpty) {
        selectedCamera = _cameras[0];
      }
    }

    if (selectedCamera != null) {
      _cameraController = CameraController(
        selectedCamera, // Utiliza la cámara seleccionada
        ResolutionPreset.high,
      );
      await _cameraController.initialize();

      if (_cameraController.value.hasError) {
        setState(() {
          _widgetState = WidgetState.ERROR;
        });
        // Handle the error here.
        print('Camera error: ${_cameraController.value.errorDescription}');
      } else {
        setState(() {
          _widgetState = WidgetState.LOADED;
        });
      }
    } else {
      setState(() {
        _widgetState = WidgetState.ERROR;
      });
      // Handle the case when no cameras are available.
      print('No cameras available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Espejo')),
      body: Stack(
        children: [
          if (_widgetState == WidgetState.LOADED)
            Transform(
              alignment: Alignment.center,
              transform: _cameraController.description.lensDirection ==
                      CameraLensDirection.front
                  ? Matrix4.rotationY(3.141592)
                  : Matrix4.rotationY(0),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context)
                    .size
                    .height, // Ocupa toda la altura de la pantalla
                child: CameraPreview(_cameraController),
              ),
            ),
          if (_capturedImage != null)
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width /
                  16 *
                  9, // Ajusta la altura según la relación de aspecto
              child: Image.file(File(_capturedImage!.path)),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _timerActive
                ? Text(
                    '$_timerSeconds',
                    style: const TextStyle(fontSize: 48, color: Colors.red),
                  )
                : ElevatedButton(
                    onPressed: _startTimer,
                    child: Text('Realizar Ejercicio'),
                  ),
          ),
        ],
      ),
    );
  }
}
