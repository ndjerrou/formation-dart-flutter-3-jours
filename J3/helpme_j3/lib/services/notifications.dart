import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

String? cheminNotification(Map<String, dynamic> data) {
  final id = data['demandeId'];
  if (id is! String || !RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(id)) return null;
  return '/demandes/$id';
}

class Notifications {
  final _ouvertures = StreamController<String>.broadcast();
  Stream<String> get ouvertures => _ouvertures.stream;
  StreamSubscription<RemoteMessage>? _clics;
  Future<String?> activer() async {
    final p = await FirebaseMessaging.instance.requestPermission();
    if (p.authorizationStatus != AuthorizationStatus.authorized &&
        p.authorizationStatus != AuthorizationStatus.provisional) {
      return null;
    }
    if (await FirebaseMessaging.instance.getAPNSToken() == null) {
      throw StateError('Jeton APNs indisponible. Vérifier la préparation iOS.');
    }
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
    return FirebaseMessaging.instance.getToken();
  }

  Future<String?> ecouter() async {
    _clics = FirebaseMessaging.onMessageOpenedApp.listen((m) {
      final c = cheminNotification(m.data);
      if (c != null) _ouvertures.add(c);
    });
    final m = await FirebaseMessaging.instance.getInitialMessage();
    return m == null ? null : cheminNotification(m.data);
  }

  Future<void> fermer() async {
    await _clics?.cancel();
    await _ouvertures.close();
  }
}
