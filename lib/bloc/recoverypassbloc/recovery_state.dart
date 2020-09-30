

import 'package:flutter/cupertino.dart';

class RecoveryState{
  final bool isEmailValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid;

  RecoveryState({@required this.isEmailValid,@required this.isFailure, @required this.isSubmitting, @required this.isSuccess});


  factory RecoveryState.empty(){
    return RecoveryState(
      isEmailValid: true,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false
    );
  }
  factory RecoveryState.loading(){
    return RecoveryState(
        isEmailValid: true,
        isSubmitting: true,
        isFailure: false,
        isSuccess: false
    );
  }
  factory RecoveryState.failure(){
    return RecoveryState(
        isEmailValid: true,
        isSubmitting: false,
        isFailure: true,
        isSuccess: false
    );
  }
  factory RecoveryState.success(){
    return RecoveryState(
        isEmailValid: true,

        isSubmitting: false,
        isFailure: false,
        isSuccess: true
    );
  }

  RecoveryState copyWith({
    bool isEmailValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }){
    return RecoveryState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure
    );
  }

  RecoveryState update({bool isEmailValid, bool isPasswordValid}){
    return copyWith(
      isEmailValid: isEmailValid,
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
    isSubmitting: $isSubmitting
    isSuccess: $isSuccess
    isFailure: $isFailure
    
    ''';
  }
}