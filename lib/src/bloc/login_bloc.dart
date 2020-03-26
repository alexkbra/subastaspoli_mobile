

import 'dart:async';
import 'package:subastaspoli_mobile/src/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:subastaspoli_mobile/src/bloc/validators.dart';

class LoginBloc with Validators{

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _userController =  BehaviorSubject<UserModel>();

  //Recuperar los datos del Stream

  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<UserModel> get userStream => _userController.stream;

  //
  Stream<bool> get formValidStream => 
    Observable.combineLatest2(emailStream, passwordStream, (e, p)=>true);

  // Insertar valores al Stream

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(UserModel) get changeUser => _userController.sink.add;

  //Obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  UserModel get user => _userController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
    _userController?.close();
  }




}