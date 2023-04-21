import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:interviewapp/first_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/common.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final logindata =await SharedPreferences.getInstance();
  var so=  logindata.getString(userid);
  runApp( MyApp(user: so,));
}

class MyApp extends StatelessWidget {
  var user;

  MyApp({required this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:user==null? first_page():home(),
    );
  }
}
