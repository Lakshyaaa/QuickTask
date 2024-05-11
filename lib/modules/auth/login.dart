import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quick_task/func/auth/auth_bloc.dart';
import 'package:quick_task/routes/router.dart';
import 'package:quick_task/util/custom_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "Username",
                hintText: "Enter Username/Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: password,
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "Enter password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              obscureText: true,
            ),
          ),
          // spacing
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _login,
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  void _login() async {
    ParseObject firstObject = ParseObject('USERS');
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(firstObject);
    parseQuery.whereContains('email', email.text.toLowerCase());
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
      for (var result in apiResponse.results!) {
        if (result['password'] == password.text) {
          goHome();
        }
      }
    } else {
      goSignUp();
    }
  }

  void goHome() {
    BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email.text));
    context.goNamed(Routes.homePage.name);
  }

  void goSignUp() {
    CustomSnackbar.pushSnackbar(context, 'User not found', error: true);
    context.goNamed(Routes.authSignUp.name);
  }
}
