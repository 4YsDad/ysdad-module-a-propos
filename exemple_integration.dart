// Exemple : menu burger (Drawer) avec « À propos » en DERNIÈRE ligne.
import 'package:flutter/material.dart';
import 'ysdad_about.dart';

void main() => runApp(const MonAppli());

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Mon appli',
        theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
        darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        themeMode: ThemeMode.system, // le popup suit le thème automatiquement
        home: const Accueil(),
      );
}

class Accueil extends StatelessWidget {
  const Accueil({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Mon appli')),
        drawer: Drawer(
          child: ListView(children: const [
            DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
            ListTile(leading: Icon(Icons.home), title: Text('Accueil')),
            ListTile(leading: Icon(Icons.settings), title: Text('Réglages')),
            Divider(),
            // 👇 LA SEULE LIGNE À AJOUTER, toujours en dernier :
            YsdadAboutTile(appName: 'Mon appli'),
          ]),
        ),
        body: const Center(child: Text('Ouvrez le menu ☰')),
      );
}
