import 'package:flutter/material.dart';
import 'package:pedi_agua/app_widget.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void> main() async {
  runApp(const AppWidget());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}