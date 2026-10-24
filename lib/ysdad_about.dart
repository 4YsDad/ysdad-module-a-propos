// ysdad_about.dart — popup « À propos » réutilisable (Ysdad)
// Couleurs Ysdad : graphite #374151 → bleu acier #4682B4 · thème clair/sombre automatique
// pubspec : package_info_plus, url_launcher, asset assets/ysdad-logo.png
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

const _email = '4ysdad@gmail.com';

/// Entrée de menu à placer en DERNIER dans le Drawer.
class YsdadAboutTile extends StatelessWidget {
  final String appName; final Color accentColor; final Color accentColor2;
  const YsdadAboutTile({super.key, required this.appName, this.accentColor = const Color(0xFF374151), this.accentColor2 = const Color(0xFF4682B4)});
  @override
  Widget build(BuildContext context) => ListTile(
        leading: const Icon(Icons.info_outline), title: const Text('À propos'),
        onTap: () {
          final nav = Navigator.of(context);
          Scaffold.maybeOf(context)?.closeDrawer();
          showYsdadAbout(nav.context, appName: appName, accentColor: accentColor, accentColor2: accentColor2); });
}

/// [version] facultatif : sinon lu via package_info_plus.
Future<void> showYsdadAbout(BuildContext context,
    {required String appName, String? version, Color accentColor = const Color(0xFF374151), Color accentColor2 = const Color(0xFF4682B4), String? logoAsset = 'assets/ysdad-logo.png'}) async {
  version ??= await PackageInfo.fromPlatform().then((p) => p.version).catchError((_) => '');
  if (!context.mounted) return;
  return showGeneralDialog<void>(
    context: context, barrierDismissible: true, barrierLabel: 'Fermer',
    barrierColor: Colors.black54, transitionDuration: const Duration(milliseconds: 260),
    transitionBuilder: (_, a, _, child) => FadeTransition(opacity: a,
        child: ScaleTransition(scale: Tween(begin: .94, end: 1.0).animate(CurvedAnimation(parent: a, curve: Curves.easeOutBack)), child: child)),
    pageBuilder: (ctx, _, _) => _AboutCard(appName: appName, version: version!, accent: accentColor, accent2: accentColor2, logoAsset: logoAsset),
  );
}

class _AboutCard extends StatelessWidget {
  final String appName, version; final Color accent; final Color? accent2; final String? logoAsset;
  const _AboutCard({required this.appName, required this.version, required this.accent, this.accent2, this.logoAsset});

  Color get _acc2 => accent2 ?? Color.lerp(accent, const Color(0xFF7FE3FF), .4)!;
  Future<void> _mail(String subject, [String body = 'Bonjour Ysdad,\n\n']) => launchUrl(Uri(
      scheme: 'mailto', path: _email,
      query: 'subject=${Uri.encodeComponent('$subject — $appName v$version')}&body=${Uri.encodeComponent(body)}'));

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg = dark ? const Color(0xFF1A1D27) : Colors.white;
    final fg = dark ? const Color(0xFFF2F3F7) : const Color(0xFF1D2230);
    final mu = dark ? const Color(0xFF9AA1B2) : const Color(0xFF667085);
    final chip = dark ? const Color(0xFF262A37) : const Color(0xFFF3F4F7);
    final grad = LinearGradient(colors: [accent, _acc2], begin: Alignment.topLeft, end: Alignment.bottomRight);

    Widget btn(String emoji, String label, VoidCallback onTap, {bool main = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Material(color: Colors.transparent, child: InkWell(borderRadius: BorderRadius.circular(14), onTap: onTap,
            child: Ink(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: main ? null : chip, gradient: main ? grad : null),
                child: Row(children: [Text(emoji, style: const TextStyle(fontSize: 18)), const SizedBox(width: 10),
                  Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: main ? Colors.white : fg))])))));

    final logo = logoAsset != null
        ? Container(decoration: BoxDecoration(color: const Color(0xFF111111), borderRadius: BorderRadius.circular(22), border: Border.all(color: accent.withValues(alpha: .6), width: 2), boxShadow: [BoxShadow(color: dark ? accent.withValues(alpha: .35) : Colors.black38, blurRadius: 14)]), child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(logoAsset!, width: 92, height: 92, fit: BoxFit.cover, errorBuilder: (_, _, _) => const SizedBox(width: 92, height: 92))))
        : Container(width: 56, height: 56, decoration: BoxDecoration(gradient: grad, borderRadius: BorderRadius.circular(16)),
            alignment: Alignment.center, child: const Text('Y.', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800)));

    return Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 360), child: Padding(
      padding: const EdgeInsets.all(20),
      child: Material(color: bg, borderRadius: BorderRadius.circular(24), clipBehavior: Clip.antiAlias, elevation: 24,
        child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Stack(clipBehavior: Clip.none, children: [
            Container(width: double.infinity, padding: const EdgeInsets.fromLTRB(20, 26, 20, 40), decoration: BoxDecoration(gradient: grad),
              child: Column(children: [
                Text(appName, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(99)),
                  child: Text('Version $version', style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600))),
              ])),
            Positioned(top: 6, right: 6, child: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context))),
          ]),
          Transform.translate(offset: const Offset(0, -22), child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18), padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(18), boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 6))]),
            child: Row(children: [logo, const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Conçu avec 💙 par', style: TextStyle(color: mu, fontSize: 12)),
              Text('Ysdad', style: TextStyle(color: fg, fontSize: 18, fontWeight: FontWeight.w700)),
              Text('Applis sur mesure, faites au Québec', style: TextStyle(color: mu, fontSize: 12))]))]))),
          Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 18), child: Column(children: [
            Text.rich(TextSpan(style: TextStyle(color: mu, fontSize: 14.5, height: 1.45), children: [
              TextSpan(text: 'Une idée? Un besoin? ', style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
              const TextSpan(text: 'Je lis tous vos messages. Proposez une amélioration, un ajout sur mesure, ou même une toute nouvelle appli, perso ou pour votre entreprise.')])),
            const SizedBox(height: 14),
            btn('💡', 'Suggérer une amélioration', () => _mail('Suggestion'), main: true),
            btn('🚀', "J'ai une idée d'appli", () => _mail("Idée d'appli", "Bonjour Ysdad,\n\nVoici mon idée : ")),
            btn('📋', 'Demander un devis', () => _mail('Demande de devis', 'Bonjour Ysdad,\n\nUsage (perso / commercial) :\nBesoin :\n')),
            const SizedBox(height: 6),
            Text('✉️ $_email · © ${DateTime.now().year} Ysdad', style: TextStyle(color: mu, fontSize: 11.5)),
          ])),
        ]))))));
  }
}
