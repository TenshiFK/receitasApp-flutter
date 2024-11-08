import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:receitasapp/common/my_colors.dart';
import 'package:receitasapp/screens/autenticacao.dart';
import 'package:receitasapp/screens/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.azulPrincipal),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: MyColors.cinzaPrincipal, size: 26)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            backgroundColor: MyColors.cinzaEscuro,
            iconSize: 40),
      ),
      home: RouterScreens(),
    );
  }
}

class RouterScreens extends StatelessWidget {
  const RouterScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home(
            user: snapshot.data!,
          );
        } else {
          return Autenticacao();
        }
      },
    );
  }
}
