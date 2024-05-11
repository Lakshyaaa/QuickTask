//Lakshya Chandrakar
import 'package:flutter/material.dart';
import 'package:quick_task/routes/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: DynamicRoutes.router,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return widget!;
      },
    );
  }
}
