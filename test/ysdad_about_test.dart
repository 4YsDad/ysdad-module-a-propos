import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ysdad_about/ysdad_about.dart';

void main() {
  testWidgets('OK ferme le dialogue et il n’y a pas de bouton X', (tester) async {
    final view = tester.view;
    view.physicalSize = const Size(800, 1400);
    view.devicePixelRatio = 1.0;
    addTearDown(view.resetPhysicalSize);
    addTearDown(view.resetDevicePixelRatio);

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => showYsdadAbout(
              context,
              appName: 'Test',
              version: '1.0.0',
              logoAsset: null,
            ),
            child: const Text('ouvrir'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('ouvrir'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.close), findsNothing);
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Conçu avec 💙 par'), findsOneWidget);
    expect(find.text('Ne plus afficher au démarrage'), findsNothing);

    await tester.ensureVisible(find.byKey(const Key('ysdad_about_ok')));
    await tester.tap(find.byKey(const Key('ysdad_about_ok')));
    await tester.pumpAndSettle();

    expect(find.text('OK'), findsNothing);
    expect(find.text('ouvrir'), findsOneWidget);
  });

  testWidgets('case « Ne plus afficher » puis OK renvoie true', (tester) async {
    final view = tester.view;
    view.physicalSize = const Size(800, 1400);
    view.devicePixelRatio = 1.0;
    addTearDown(view.resetPhysicalSize);
    addTearDown(view.resetDevicePixelRatio);

    bool? resultat;

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () async {
              resultat = await showYsdadAbout(
                context,
                appName: 'Test',
                version: '1.0.0',
                logoAsset: null,
                showDontShowAgain: true,
              );
            },
            child: const Text('ouvrir'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('ouvrir'));
    await tester.pumpAndSettle();

    expect(find.text('Ne plus afficher au démarrage'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);

    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('ysdad_about_ok')));
    await tester.tap(find.byKey(const Key('ysdad_about_ok')));
    await tester.pumpAndSettle();

    expect(resultat, isTrue);
  });
}
