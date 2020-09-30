

import 'package:flutter/cupertino.dart';

class LoginState{
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({@required this.isEmailValid, @required this.isPasswordValid,@required this.isFailure, @required this.isSubmitting, @required this.isSuccess});


  factory LoginState.empty(){
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false
    );
  }
  factory LoginState.loading(){
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isFailure: false,
        isSuccess: false
    );
  }
  factory LoginState.failure(){
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isFailure: true,
        isSuccess: false
    );
  }
  factory LoginState.success(){
    return LoginState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isFailure: false,
        isSuccess: true
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }){
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure
    );
  }

  LoginState update({bool isEmailValid, bool isPasswordValid}){
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid : isPasswordValid,
      isSuccess: false,
      isSubmitting: false,
      isFailure: false
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return ''' LoginState
    isEmailValid: $isEmailValid
    isEmailValid: $isPasswordValid
    isSubmitting: $isSubmitting
    isSuccess: $isSuccess
    isFailure: $isFailure
    
    ''';
  }
}