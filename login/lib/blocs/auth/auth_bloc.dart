import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../utils/validators.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthEmailChanged>((e, emit) {
      emit(state.copyWith(email: e.email, isEmailValid: Validators.isValidEmail(e.email)));
    });

    on<AuthPasswordChanged>((e, emit) {
      emit(state.copyWith(password: e.password, isPasswordValid: Validators.isValidPassword(e.password)));
    });

    on<AuthSubmitted>((e, emit) async {
      final emailValid = Validators.isValidEmail(e.email);
      final passValid = Validators.isValidPassword(e.password);
      if (!emailValid || !passValid) {
        emit(state.copyWith(
          isEmailValid: emailValid,
          isPasswordValid: passValid,
          status: AuthStatus.failure,
          message: 'Validation failed',
        ));
        return;
      }
      emit(state.copyWith(status: AuthStatus.submitting));
      // Simulate API call: replace with real auth if available
      await Future.delayed(const Duration(seconds: 1));
      // For now we accept any valid credentials
      emit(state.copyWith(status: AuthStatus.success));
    });
  }
}
