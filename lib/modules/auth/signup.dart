import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quick_task/func/auth/auth_bloc.dart';
import 'package:quick_task/routes/router.dart';
import 'package:quick_task/util/custom_snackbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController email;
  late final TextEditingController name;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    name.dispose();
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
              controller: name,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter Name",
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
            onPressed: () async {
              ParseObject firstObject = ParseObject('USERS');
              // check if user is already there?
              final alreadyReg = await checkIfAvailale(firstObject);
              if (!alreadyReg) {
                // if not then create new user
                firstObject
                  ..set('email', email.text.toLowerCase())
                  ..set('name', name.text)
                  ..set('password', password.text);
                final resp = await firstObject.save();
                if (resp.success) {
                  showMessage('Registered Successfull', 2);
                } else {
                  showMessage(resp.error?.message ?? "", 1);
                }
              } else {
                showMessage('Already Registered', 1);
              }
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  checkIfAvailale(ParseObject firstObject) async {
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(firstObject);
    parseQuery.whereContains('email', email.text.toLowerCase());
    final ParseResponse apiResponse = await parseQuery.query();
    if (apiResponse.success && apiResponse.results != null) {
      print(apiResponse.results.toString());
      return apiResponse.count > 0;
    }
    return false;
  }

  void showMessage(String message, [int success = 0]) {
    CustomSnackbar.pushSnackbar(context, message);
    switch (success) {
      case 1:
        context.goNamed(Routes.authLogin.name);
        break;
      case 2:
        BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email.text));
        context.goNamed(Routes.homePage.name);
        // go to taskbar page
        break;
      default:
    }
  }
}
