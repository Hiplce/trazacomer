

import 'package:flutter/cupertino.dart';

class DataRegisterState{
  final bool isNameValid;
  final bool isLastNameValid;
  final bool isDNIValid;
  final bool isDirectionValid;
  final bool isPhoneValid;
  final bool isLocationValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid && isLastNameValid && isDNIValid && isDirectionValid && isPhoneValid && isLocationValid;

  DataRegisterState({@required this.isNameValid, @required this.isLastNameValid,@required this.isDNIValid,@required this.isDirectionValid,@required this.isLocationValid,@required this.isPhoneValid,@required this.isFailure, @required this.isSubmitting, @required this.isSuccess});


  factory DataRegisterState.empty(){
    return DataRegisterState(
        isNameValid: true,
        isLastNameValid: true,
        isDNIValid: true,
        isDirectionValid :true,
        isPhoneValid: true,
        isLocationValid: true,
        isSubmitting: false,
        isFailure: false,
        isSuccess: false
    );
  }
  factory DataRegisterState.loading(){
    return DataRegisterState(
        isNameValid: true,
        isLastNameValid: true,
        isDNIValid: true,
        isDirectionValid :true,
        isPhoneValid: true,
        isLocationValid: true,
        isSubmitting: true,
        isFailure: false,
        isSuccess: false
    );
  }
  factory DataRegisterState.failure(){
    return DataRegisterState(
        isNameValid: true,
        isLastNameValid: true,
        isDNIValid: true,
        isDirectionValid :true,
        isPhoneValid: true,
        isLocationValid: true,
        isSubmitting: false,
        isFailure: true,
        isSuccess: false
    );
  }
  factory DataRegisterState.success(){
    return DataRegisterState(
        isNameValid: true,
        isLastNameValid: true,
        isDNIValid: true,
        isDirectionValid :true,
        isPhoneValid: true,
        isLocationValid: true,
        isSubmitting: false,
        isFailure: false,
        isSuccess: true
    );
  }

  DataRegisterState copyWith({
    bool isNameValid,
    bool isLastNameValid,
    bool isDNIValid,
    bool isDirectionValid,
    bool isPhoneValid,
    bool isLocationValid,
    bool isSubmitting,
    bool isFailure,
    bool isSuccess
  }){
    return DataRegisterState(
        isNameValid: isNameValid ?? this.isNameValid,
        isLastNameValid: isLastNameValid ?? this.isLastNameValid,
        isDNIValid: isDNIValid ?? this.isDNIValid,
        isLocationValid: isLocationValid ?? this.isLocationValid,
        isDirectionValid: isDirectionValid ?? this.isDirectionValid,
        isPhoneValid: isPhoneValid ?? this.isPhoneValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }

  DataRegisterState update({bool isNameValid, bool isLastNameValid,
    bool isDNIValid,
    bool isDirectionValid,
    bool isPhoneValid,
    bool isLocationValid,}){
    return copyWith(
        isNameValid: isNameValid,
        isLastNameValid : isLastNameValid,
        isDNIValid: isDNIValid,
        isDirectionValid: isDirectionValid,
        isLocationValid: isLocationValid,
        isPhoneValid: isPhoneValid,
        isSuccess: false,
        isSubmitting: false,
        isFailure: false
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return ''' LoginState
    isName: $isNameValid
    isLastName: $isLastNameValid
    isSubmitting: $isSubmitting
    isSuccess: $isSuccess
    isFailure: $isFailure
    
    ''';
  }
}