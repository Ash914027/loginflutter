import 'package:equatable/equatable.dart';

enum AuthStatus { initial, submitting, success, failure }

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final AuthStatus status;
  final String? message;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.status = AuthStatus.initial,
    this.message,
  });

  AuthState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    AuthStatus? status,
    String? message,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      status: status ?? this.status,
      message: message,
    );
  }

  @override List<Object?> get props =>
      [email, password, isEmailValid, isPasswordValid, status, message];
}
