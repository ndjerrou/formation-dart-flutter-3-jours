// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'HelpMe';

  @override
  String get catalogue => 'Artisans';

  @override
  String get requests => 'Mes demandes';

  @override
  String get settings => 'Réglages';

  @override
  String get login => 'Connexion';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get email => 'Adresse email';

  @override
  String get password => 'Mot de passe';

  @override
  String get signIn => 'Se connecter';

  @override
  String get register => 'Créer un compte client';

  @override
  String get localMode =>
      'Démonstration locale — aucune demande envoyée à un artisan réel.';

  @override
  String get cloudMode => 'Connecté à Firebase';

  @override
  String get heroTitle => 'Un savoir-faire, près de chez vous.';

  @override
  String get heroSubtitle =>
      'Trouvez un professionnel et suivez votre demande.';

  @override
  String get search => 'Nom ou métier';

  @override
  String get favoritesOnly => 'Favoris uniquement';

  @override
  String get empty => 'Aucun résultat.';

  @override
  String get retry => 'Réessayer';

  @override
  String get loading => 'Chargement…';

  @override
  String get open => 'Voir la fiche';

  @override
  String get favorite => 'Favori';

  @override
  String get send => 'Envoyer la demande';

  @override
  String get sending => 'Envoi…';

  @override
  String get motif => 'Décrivez votre besoin';

  @override
  String get motifError => 'Indiquez au moins 5 caractères.';

  @override
  String get requestSent => 'Demande enregistrée';

  @override
  String get pending => 'En attente';

  @override
  String get accepted => 'Acceptée';

  @override
  String get refused => 'Refusée';

  @override
  String get accept => 'Accepter';

  @override
  String get refuse => 'Refuser';

  @override
  String get noRequests => 'Aucune demande pour le moment.';

  @override
  String get requestDetail => 'Détail de la demande';

  @override
  String get notFound => 'Cette page est introuvable.';

  @override
  String get backCatalogue => 'Retour aux artisans';

  @override
  String get language => 'Langue';

  @override
  String get clientDemo => 'Entrer comme client';

  @override
  String get providerDemo => 'Entrer comme prestataire';

  @override
  String get localAccounts => 'Comptes de démonstration locale';

  @override
  String get providerInbox => 'Demandes reçues';

  @override
  String get permissions => 'Activer les notifications';

  @override
  String get notificationUnavailable =>
      'Les push réels sont disponibles sur l’iPhone configuré avec Firebase.';

  @override
  String get copied => 'Copié';

  @override
  String get sourceAssets => 'Catalogue embarqué';

  @override
  String get sourceHttp => 'Catalogue HTTP';

  @override
  String get sourceCache => 'Catalogue local en cache — réseau indisponible';

  @override
  String get errorGeneric => 'Une erreur est survenue. Réessayez.';

  @override
  String get syncPending => 'Synchronisation en attente';

  @override
  String get connectedAs => 'Compte connecté';

  @override
  String get hour => '/ heure';

  @override
  String get notAvailable => 'Artisan introuvable';

  @override
  String get refresh => 'Actualiser';

  @override
  String get signInNeeded => 'Connectez-vous pour continuer.';

  @override
  String get notificationsDenied =>
      'Notifications non autorisées. Vérifiez les réglages de l’iPhone.';

  @override
  String get notificationsReady => 'Notifications activées.';

  @override
  String get passwordError =>
      'Email valide et mot de passe de 6 caractères minimum requis.';

  @override
  String get roleClient => 'Client';

  @override
  String get roleProvider => 'Prestataire';

  @override
  String get loadFailed => 'Impossible de charger le catalogue.';

  @override
  String get requestFailed => 'Impossible de traiter la demande.';

  @override
  String get accessDenied => 'Cette demande ne vous est pas accessible.';

  @override
  String get about =>
      'Catalogue et tarifs fictifs. Les demandes Firebase sont des données de formation.';

  @override
  String get choose => 'Choisir cet artisan';

  @override
  String get chosen => 'Artisan sélectionné';

  @override
  String get favoriteCount => 'favori(s)';

  @override
  String get resultCount => 'artisan(s)';
}
