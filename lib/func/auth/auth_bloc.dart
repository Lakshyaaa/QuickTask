import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<LoginEvent>(login);

    on<LogoutEvent>(logout);
  }

  logout(event, emit) {
    emit(AuthInitial());
  }

  login(LoginEvent event, emit) {
    emit(AuthSession(email: event.email));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthSession.fromMap(json);
    } catch (e) {
      return AuthInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthSession) {
      return state.toMap();
    } else {
      return {};
    }
  }
}
