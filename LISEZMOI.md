# Module « À propos » — Ysdad 💙

Fenêtre « À propos » prête à l'emploi : nom de l'appli, version (lue toute seule), votre logo, « Conçu avec 💙 par Ysdad » et 3 boutons courriel vers 4ysdad@gmail.com (Suggestion, Idée d'appli, Demande de devis).
Couleurs graphite → bleu acier. Elle passe en clair ou en sombre toute seule, selon le thème de l'appli.

## 1. Copier 2 fichiers dans votre projet
- `lib/ysdad_about.dart` → dans le dossier `lib/` du projet
- `assets/ysdad-logo.png` → dans le dossier `assets/` du projet (créez-le s'il n'existe pas)

## 2. Modifier `pubspec.yaml`
Ajoutez sous `dependencies:`
```yaml
  package_info_plus: ^10.0.0
  url_launcher: ^6.3.0
```
et sous `flutter:`
```yaml
  assets:
    - assets/ysdad-logo.png
```
Puis lancez : `flutter pub get`
(Plus simple encore : `flutter pub add package_info_plus url_launcher`)

## 3. Android seulement : permettre d'ouvrir le courriel
Dans `android/app/src/main/AndroidManifest.xml`, juste avant `<application`, ajoutez :
```xml
<queries>
  <intent>
    <action android:name="android.intent.action.SENDTO" />
    <data android:scheme="mailto" />
  </intent>
</queries>
```
(S'il y a déjà un bloc `<queries>`, ajoutez seulement le `<intent>…</intent>` dedans.)

## 4. Ajouter 1 ligne au menu burger
En haut du fichier qui contient votre `Drawer` :
```dart
import 'ysdad_about.dart';
```
Puis, comme **dernier** élément de la liste du Drawer :
```dart
YsdadAboutTile(appName: 'Trouve-tout'),
```
C'est tout ! Voir `exemple_integration.dart` pour un exemple complet.

## Options (facultatif)
- Ouvrir le popup depuis n'importe quel bouton : `showYsdadAbout(context, appName: 'Jeu du 12');`
- Forcer une version : `version: '1.2.0'` (sinon, c'est celle du `pubspec.yaml`)
- Autres couleurs : `accentColor: …, accentColor2: …`
- Autre logo : `logoAsset: 'assets/autre.png'`
