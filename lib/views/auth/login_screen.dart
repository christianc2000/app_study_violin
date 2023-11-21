import 'package:app_study_violin/models/user.dart';
import 'package:app_study_violin/views/screens/estudio_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_study_violin/config/theme/app_colors.dart';
import 'package:app_study_violin/views/widgets/custom_button.dart';
import 'package:app_study_violin/models/api_response.dart';
import 'package:app_study_violin/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController txtEmailController = TextEditingController();

  TextEditingController txtPasswordController = TextEditingController();

  bool loading = false;

  bool passwordVisibility = false;

  void _loginUser() async {
    ApiResponse response =
        await login(txtEmailController.text, txtPasswordController.text);
        print("response error: ${response.error}");
    if (response.error == null) {
      
      _saveAndRedirectToHome(response.data as User);
    } else {
      print("algo salió mal");
      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const EstudioScreen(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: ListView(padding: const EdgeInsets.all(16.0), children: [
          Center(
              child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Text(
                    'Iniciar Sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: AppColors.textColor2,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Porfavor ingresa tus datos para iniciar sesión',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textColor2,
                    fontFamily: 'Inter',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 100.0, right: 20, left: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmailController,
                    obscureText: false,
                    autofocus: false,
                    validator: (val) =>
                        val!.isEmpty ? 'El campo no puede estar vacío' : null,
                    style: const TextStyle(
                        fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Correo Electronico',
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: TextFormField(
                    obscureText: !passwordVisibility,
                    controller: txtPasswordController,
                    validator: (val) => val!.length < 6
                        ? 'Se requieren al menos 6 caracteres'
                        : null,
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => passwordVisibility = !passwordVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF95A1AC),
                          size: 22,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Contraseña',
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, right: 50, left: 50),
                        child: CustomButton(
                          alignment: MainAxisAlignment.center,
                          icon: null,
                          text: 'CONTINUAR',
                          color: AppColors.bgPrimaryColor,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              _loginUser();
                            }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           const EstudioScreen()),
                            // );
                          },
                        ),
                      )
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
