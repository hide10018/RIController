import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//riverpod
final localeProvider = StateProvider<String>((ref) => 'ja');
final darkmodeProvider = StateProvider((ref) => ThemeData.light()
    .copyWith(primaryColor: Colors.black87, disabledColor: Colors.white));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: MyApp()));
}