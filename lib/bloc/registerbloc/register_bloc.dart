import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trazacomer/bloc/registerbloc/bloc.dart';
import 'package:trazacomer/respositories/user_repository.dart';
import 'package:trazacomer/util/validator.dart';
class RegisterBloc extends Bloc<RegisterEvent,RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
  :assert (userRepository != null),
  _userRepository = userRepository,
        super(RegisterState.empty());

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(Stream<RegisterEvent> events, transitionFn) {

    final nonDebounceStream = events.where((event) {
      return(event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return(event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if(event is EmailChanged){
      yield*  _mapEmailChangedToState(event.email);
    }
    if(event is PasswordChanged){
      yield* _mapPasswordChangedToState(event.password);
    }
    if(event is Submitted){
      yield* _mapSubmittedToState(event.email,event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async*{
    yield state.update( isEmailValid: Validator.isValidEmail(email));
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async*{
    yield state.update( isPasswordValid: Validator.isValidPassword(password));
  }

  Stream<RegisterState> _mapSubmittedToState(String email, String password)  async*{
    yield RegisterState.loading();
    try{
      //await _userRepository.singUp(email, password);
      yield RegisterState.success();
    }
    catch(_){
      yield RegisterState.failure();
    }
  }
}