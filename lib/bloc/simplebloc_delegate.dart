import 'package:bloc/bloc.dart';

class AuthenticationBlocDelegate extends BlocObserver{
  @override
  void onChange(Cubit cubit, Change change) {
    // TODO: implement onChange
    super.onChange(cubit, change);
  }
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    print(error);
    super.onError(cubit, error, stackTrace);
  }
  @override
  void onEvent(Bloc bloc, Object event) {
    // TODO: implement onEvent
    print(event);
    super.onEvent(bloc, event);
  }
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    print(transition);
    super.onTransition(bloc, transition);
  }
}