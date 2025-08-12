import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override List<Object?> get props => [];
}

class AuthEmailChanged extends AuthEvent {
  final String email;
  const AuthEmailChanged(this.email);
  @override List<Object?> get props => [email];
}
class AuthPasswordChanged extends AuthEvent {
  final String password;
  const AuthPasswordChanged(this.password);
  @override List<Object?> get props => [password];
}
class AuthSubmitted extends AuthEvent {
  final String email;
  final String password;
  const AuthSubmitted(this.email, this.password);
  @override List<Object?> get props => [email, password];
}
