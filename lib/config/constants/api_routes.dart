const baseUrl="http://192.168.10.110:8000/api";
const loginUrl = '$baseUrl/auth/login';
const registerUrl = '$baseUrl/auth/register';
const estudioUrl = '$baseUrl/estudio';
const practicaUrl = '$baseUrl/practica';
const ejercicioUrl = '$baseUrl/ejercicio';
const Map<String, String> headers = {"Accept": "application/json"};

// ------ Errors -----------------
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again';