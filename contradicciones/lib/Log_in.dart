import 'dart:convert';

import 'package:contradicciones/Menu_principal.dart';
import 'package:contradicciones/main.dart' as main;
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:contradicciones/models/API.dart';
import 'package:http/http.dart' as http;

//USERS AND PASSWORDS TO USE
const users = const {
  'Ruben@gmail.com':'contra132',
};

class login extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.white,
        cursorColor: Colors.red,
        textTheme: TextTheme(
          display2: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            color: Colors.white,
          ),
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
          subhead: TextStyle(fontFamily: 'NotoSans'),
          body1: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: LoginScreen(),
    );
  }

}

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Usuario: ${data.name}, Contraseña: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'El usuario no existe';
      }
      if (users[data.name] != data.password) {
        return 'La contraseña no coincide';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Usuario: $name');
    return Future.delayed(loginTime).then((_) {

      if (!users.containsKey(name)) {
        return 'El usuario no existe.';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(

      title: '¡Bienvenido!',
      logo: 'assets/Contradicc.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Menu(),
        ));
      },
      onRecoverPassword:_recoverPassword,
      messages: LoginMessages(
        usernameHint: 'Usuario',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar',
        loginButton: 'ENTRAR',
        signupButton: 'REGISTRAR',
        forgotPasswordButton: '¿Has olvidado la contraseña?',
        recoverPasswordButton: 'AYUDA',
        goBackButton: 'ATRAS',
        confirmPasswordError: 'No coincide',
        recoverPasswordDescription:
        'Tranquilo, podemos ayudarte, rellena los campos y actualizaremos tu contraseña.',
        recoverPasswordSuccess: '¡Contraseña recuperada!',
      ),
    );
  }
}
