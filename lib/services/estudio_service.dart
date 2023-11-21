import 'dart:convert';

import 'package:app_study_violin/models/contenido.dart';
import 'package:app_study_violin/models/ejercicio.dart';
import 'package:app_study_violin/models/practica.dart';
import 'package:http/http.dart' as http;
import 'package:app_study_violin/config/constants/api_routes.dart';
import 'package:app_study_violin/models/api_response.dart';
import 'package:app_study_violin/models/estudio.dart';

Future<ApiResponse> getEstudios() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final Uri uri = Uri.parse("$estudioUrl/enabled");
    final response = await http.get(uri);

    switch (response.statusCode) {
      case 200:
        print("entra al 200: ${jsonDecode(response.body)['data']['estudio']}");
        apiResponse.data =
            (jsonDecode(response.body)['data']['estudio'] as List)
                .map((estudioData) => Estudio.fromJson(estudioData))
                .toList();
        print("pasa correctamente");

        // Imprime los datos para verificar
        print("Datos guardados en apiResponse.data: ${apiResponse.data}");

        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getPracticas(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    print("id estudio: ${id}");
    final Uri uri = Uri.parse("$estudioUrl/$id/practicas");
    final response = await http.get(uri);

    switch (response.statusCode) {
      case 200:
        
        print("entra al 200: ${jsonDecode(response.body)['data']['practica`']}");
        apiResponse.data =
            (jsonDecode(response.body)['data']['practica'] as List)
                .map((practicaData) => Practica.fromJson(practicaData))
                .toList();
        print("pasa correctamente");

        // Imprime los datos para verificar
        print("Datos guardados en apiResponse.data: ${apiResponse.data}");

        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getEjercicio(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    print("id practica: ${id}");
    final Uri uri = Uri.parse("$practicaUrl/$id/ejercicios");
    final response = await http.get(uri);

    switch (response.statusCode) {
      case 200:
        
        print("entra al 200: ${jsonDecode(response.body)['data']['ejercicio`']}");
        apiResponse.data =
            (jsonDecode(response.body)['data']['ejercicio'] as List)
                .map((ejercicioData) => Ejercicio.fromJson(ejercicioData))
                .toList();
        print("pasa correctamente");

        // Imprime los datos para verificar
        print("Datos guardados en apiResponse.data: ${apiResponse.data}");

        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
Future<ApiResponse> getEvaluacion(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    print("id practica: ${id}");
    final Uri uri = Uri.parse("$practicaUrl/$id/evaluaciones");
    final response = await http.get(uri);

    switch (response.statusCode) {
      case 200:
        
        print("entra al 200: ${jsonDecode(response.body)['data']['evaluacion']}");
        apiResponse.data =
            (jsonDecode(response.body)['data']['evaluacion'] as List)
                .map((ejercicioData) => Ejercicio.fromJson(ejercicioData))
                .toList();
        print("pasa correctamente");

        // Imprime los datos para verificar
        print("Datos guardados en apiResponse.data: ${apiResponse.data}");

        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
Future<ApiResponse> getContenido(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    print("id ejercicio: ${id}");
    final Uri uri = Uri.parse("$ejercicioUrl/$id/contenido");
    final response = await http.get(uri);

    switch (response.statusCode) {
      case 200:
        
        print("entra al 200: ${jsonDecode(response.body)['data']['contenido']}");
        apiResponse.data =
            (jsonDecode(response.body)['data']['contenido'] as List)
                .map((contenidoData) => Contenido.fromJson(contenidoData))
                .toList();
        print("pasa correctamente");

        // Imprime los datos para verificar
        print("Datos guardados en apiResponse.data: ${apiResponse.data}");

        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
