



import 'package:flutter/cupertino.dart';

class TrazaState {

  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isOnLocal;

  TrazaState ({@required this.isSubmitting,@required this.isFailure,@required this.isSuccess,@required this.isOnLocal});

  factory TrazaState.initial(){
    return TrazaState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isOnLocal: false
    );
  }
  factory TrazaState.loading(){
    return TrazaState(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isOnLocal: false
    );
  }
  factory TrazaState.success(){
    return TrazaState(
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        isOnLocal: false
    );
  }
  factory TrazaState.failure(){
    return TrazaState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        isOnLocal: false
    );
  }
  factory TrazaState.onLocal(){
    return TrazaState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isOnLocal: true
    );
  }
  factory TrazaState.unverified(){
    return TrazaState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isOnLocal: false
    );
  }




}
