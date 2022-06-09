import 'package:gestao_scrum_gft/pages/daily_inserir_page.dart';
import 'package:gestao_scrum_gft/pages/menu_page.dart';
import 'package:gestao_scrum_gft/pages/projeto_inserir_page.dart';
import 'package:gestao_scrum_gft/pages/sobre_page.dart';
import 'package:gestao_scrum_gft/pages/starter_inserir_page.dart';
import 'package:gestao_scrum_gft/pages/starter_list_page.dart';
import 'package:gestao_scrum_gft/pages/criar_conta_page.dart';
import 'package:gestao_scrum_gft/pages/daily_list_page.dart';
import 'package:gestao_scrum_gft/pages/daily_starter_page.dart';
import 'package:gestao_scrum_gft/pages/login_page.dart';
import 'package:gestao_scrum_gft/pages/projeto_list_page.dart';
import 'package:gestao_scrum_gft/pages/projeto_starter_page.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Café Store',
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginPage(),
        'criar_conta': (context) => const CriarContaPage(),
        'menu': (context) => const MenuPage(),
        'sobre': (context) => const SobrePage(),
        'daily_starter': (context) => const DailyStarterPage(),
        'daily_list': (context) => const DailyListPage(),
        'daily_inserir': (context) => const DailyInserirPage(),
        'projeto_starter': (context) => const ProjetoStarterPage(),
        'projeto_list': (context) => const ProjetoListPage(),
        'projeto_inserir': (context) => const ProjetoInserirPage(),
        'starter_list': (context) => const StarterListPage(),
        'starter_inserir': (context) => const StarterInserirPage(),
      },
    ),
  );
}
