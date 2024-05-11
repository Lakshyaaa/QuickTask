part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;

  const LoginEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class LogoutEvent extends AuthEvent {}
