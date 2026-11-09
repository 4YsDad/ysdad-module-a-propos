# Module « À propos » — Ysdad 💙 — v1.1.0

Fenêtre « À propos » prête à l'emploi : nom de l'appli, version (lue toute seule), votre logo, « Conçu avec 💙 par Ysdad », 3 boutons courriel vers 4ysdad@gmail.com (Suggestion, Idée d'appli, Demande de devis), et un bouton **OK** pour fermer. Plus de X en haut.
Couleurs graphite → bleu acier. Elle passe en clair ou en sombre toute seule, selon le thème de l'appli.

## Deux façons de l'ajouter

### A. Dépendance Git (recommandé)

Dans `pubspec.yaml` :
```yaml
dependencies:
  ysdad_about:
    git:
      url: https://github.com/4YsDad/ysdad-module-a-propos.git
      ref: v1.1.0
  # ou sans ref pour suivre main :
  #   ref: main
```
Puis `flutter pub get`. Logo inclus dans le paquet : utilisez
`logoAsset: 'packages/ysdad_about/assets/ysdad-logo.png'`
ou laissez la valeur par défaut si vous avez aussi copié le logo dans `assets/` de l'appli.

### B. Copier 2 fichiers (comme avant)
- `lib/ysdad_about.dart` → dans le dossier `lib/` du projet
- `assets/ysdad-logo.png` → dans le dossier `assets/` du projet

Ajoutez sous `dependencies:` :
```yaml
  package_info_plus: ^10.0.0
  url_launcher: ^6.3.0
  shared_preferences: ^2.5.0
```
et sous `flutter:` / `assets:` : `- assets/ysdad-logo.png`

## Menu burger (toujours en dernier)
```dart
import 'package:ysdad_about/ysdad_about.dart'; // ou import 'ysdad_about.dart';
// …
YsdadAboutTile(appName: 'Trouve-tout'),
```

## Au démarrage (avec case « Ne plus afficher »)
```dart
YsdadAboutOnLaunch(
  appName: 'Feuille de pointage',
  child: Accueil(),
)
```
La case est **dans** le popup, juste au-dessus du bouton OK. Cocher puis OK (ou fermer en tapant dehors) mémorise le choix.

## Options
- Ouvrir manuellement : `showYsdadAbout(context, appName: 'Jeu du 12');`
- Avec case : `showDontShowAgain: true`
- Forcer une version : `version: '1.2.0'`
- Autres couleurs : `accentColor: …, accentColor2: …`
- Autre logo : `logoAsset: 'assets/autre.png'` (ou `null` pour le monogramme Y.)

## Android : courriel
Dans `android/app/src/main/AndroidManifest.xml`, juste avant `<application`, ajoutez :
```xml
<queries>
  <intent>
    <action android:name="android.intent.action.SENDTO" />
    <data android:scheme="mailto" />
  </intent>
</queries>
```
