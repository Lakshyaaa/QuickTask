// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthSession extends AuthState {
  final String email;
  const AuthSession({required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory AuthSession.fromMap(Map<String, dynamic> map) {
    return AuthSession(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthSession.fromJson(String source) =>
      AuthSession.fromMap(json.decode(source) as Map<String, dynamic>);
}
