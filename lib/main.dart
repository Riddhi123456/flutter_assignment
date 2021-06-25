import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/src/api/BaseApis.dart';
import 'package:flutter_task/src/providers/PhotoProvider.dart';
import 'package:flutter_task/src/ui/HomeScreen.dart';
import 'package:flutter_task/src/ui/LoginScreen.dart';
import 'package:flutter_task/src/ui/SecondScreen.dart';
import 'package:flutter_task/src/ui/SignUpScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    BaseApis.setEnvironment(Environment.STAGING);
  } else {
    BaseApis.setEnvironment(Environment.PROD);
  }
  runApp(ChangeNotifierProvider<PhotoProvider>(
    create: (context) => PhotoProvider(),
    child: MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home':(context) => HomeScreen(),
        '/second':(context) => SecondScreen(),
      },
    );
  }
}