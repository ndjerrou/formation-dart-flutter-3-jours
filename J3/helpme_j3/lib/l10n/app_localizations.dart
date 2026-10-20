import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'HelpMe'**
  String get appTitle;

  /// No description provided for @catalogue.
  ///
  /// In fr, this message translates to:
  /// **'Artisans'**
  String get catalogue;

  /// No description provided for @requests.
  ///
  /// In fr, this message translates to:
  /// **'Mes demandes'**
  String get requests;

  /// No description provided for @settings.
  ///
  /// In fr, this message translates to:
  /// **'Réglages'**
  String get settings;

  /// No description provided for @login.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get logout;

  /// No description provided for @email.
  ///
  /// In fr, this message translates to:
  /// **'Adresse email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In fr, this message translates to:
  /// **'Se connecter'**
  String get signIn;

  /// No description provided for @register.
  ///
  /// In fr, this message translates to:
  /// **'Créer un compte client'**
  String get register;

  /// No description provided for @localMode.
  ///
  /// In fr, this message translates to:
  /// **'Démonstration locale — aucune demande envoyée à un artisan réel.'**
  String get localMode;

  /// No description provided for @cloudMode.
  ///
  /// In fr, this message translates to:
  /// **'Connecté à Firebase'**
  String get cloudMode;

  /// No description provided for @heroTitle.
  ///
  /// In fr, this message translates to:
  /// **'Un savoir-faire, près de chez vous.'**
  String get heroTitle;

  /// No description provided for @heroSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Trouvez un professionnel et suivez votre demande.'**
  String get heroSubtitle;

  /// No description provided for @search.
  ///
  /// In fr, this message translates to:
  /// **'Nom ou métier'**
  String get search;

  /// No description provided for @favoritesOnly.
  ///
  /// In fr, this message translates to:
  /// **'Favoris uniquement'**
  String get favoritesOnly;

  /// No description provided for @empty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun résultat.'**
  String get empty;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement…'**
  String get loading;

  /// No description provided for @open.
  ///
  /// In fr, this message translates to:
  /// **'Voir la fiche'**
  String get open;

  /// No description provided for @favorite.
  ///
  /// In fr, this message translates to:
  /// **'Favori'**
  String get favorite;

  /// No description provided for @send.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer la demande'**
  String get send;

  /// No description provided for @sending.
  ///
  /// In fr, this message translates to:
  /// **'Envoi…'**
  String get sending;

  /// No description provided for @motif.
  ///
  /// In fr, this message translates to:
  /// **'Décrivez votre besoin'**
  String get motif;

  /// No description provided for @motifError.
  ///
  /// In fr, this message translates to:
  /// **'Indiquez au moins 5 caractères.'**
  String get motifError;

  /// No description provided for @requestSent.
  ///
  /// In fr, this message translates to:
  /// **'Demande enregistrée'**
  String get requestSent;

  /// No description provided for @pending.
  ///
  /// In fr, this message translates to:
  /// **'En attente'**
  String get pending;

  /// No description provided for @accepted.
  ///
  /// In fr, this message translates to:
  /// **'Acceptée'**
  String get accepted;

  /// No description provided for @refused.
  ///
  /// In fr, this message translates to:
  /// **'Refusée'**
  String get refused;

  /// No description provided for @accept.
  ///
  /// In fr, this message translates to:
  /// **'Accepter'**
  String get accept;

  /// No description provided for @refuse.
  ///
  /// In fr, this message translates to:
  /// **'Refuser'**
  String get refuse;

  /// No description provided for @noRequests.
  ///
  /// In fr, this message translates to:
  /// **'Aucune demande pour le moment.'**
  String get noRequests;

  /// No description provided for @requestDetail.
  ///
  /// In fr, this message translates to:
  /// **'Détail de la demande'**
  String get requestDetail;

  /// No description provided for @notFound.
  ///
  /// In fr, this message translates to:
  /// **'Cette page est introuvable.'**
  String get notFound;

  /// No description provided for @backCatalogue.
  ///
  /// In fr, this message translates to:
  /// **'Retour aux artisans'**
  String get backCatalogue;

  /// No description provided for @language.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get language;

  /// No description provided for @clientDemo.
  ///
  /// In fr, this message translates to:
  /// **'Entrer comme client'**
  String get clientDemo;

  /// No description provided for @providerDemo.
  ///
  /// In fr, this message translates to:
  /// **'Entrer comme prestataire'**
  String get providerDemo;

  /// No description provided for @localAccounts.
  ///
  /// In fr, this message translates to:
  /// **'Comptes de démonstration locale'**
  String get localAccounts;

  /// No description provided for @providerInbox.
  ///
  /// In fr, this message translates to:
  /// **'Demandes reçues'**
  String get providerInbox;

  /// No description provided for @permissions.
  ///
  /// In fr, this message translates to:
  /// **'Activer les notifications'**
  String get permissions;

  /// No description provided for @notificationUnavailable.
  ///
  /// In fr, this message translates to:
  /// **'Les push réels sont disponibles sur l’iPhone configuré avec Firebase.'**
  String get notificationUnavailable;

  /// No description provided for @copied.
  ///
  /// In fr, this message translates to:
  /// **'Copié'**
  String get copied;

  /// No description provided for @sourceAssets.
  ///
  /// In fr, this message translates to:
  /// **'Catalogue embarqué'**
  String get sourceAssets;

  /// No description provided for @sourceHttp.
  ///
  /// In fr, this message translates to:
  /// **'Catalogue HTTP'**
  String get sourceHttp;

  /// No description provided for @sourceCache.
  ///
  /// In fr, this message translates to:
  /// **'Catalogue local en cache — réseau indisponible'**
  String get sourceCache;

  /// No description provided for @errorGeneric.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue. Réessayez.'**
  String get errorGeneric;

  /// No description provided for @syncPending.
  ///
  /// In fr, this message translates to:
  /// **'Synchronisation en attente'**
  String get syncPending;

  /// No description provided for @connectedAs.
  ///
  /// In fr, this message translates to:
  /// **'Compte connecté'**
  String get connectedAs;

  /// No description provided for @hour.
  ///
  /// In fr, this message translates to:
  /// **'/ heure'**
  String get hour;

  /// No description provided for @notAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Artisan introuvable'**
  String get notAvailable;

  /// No description provided for @refresh.
  ///
  /// In fr, this message translates to:
  /// **'Actualiser'**
  String get refresh;

  /// No description provided for @signInNeeded.
  ///
  /// In fr, this message translates to:
  /// **'Connectez-vous pour continuer.'**
  String get signInNeeded;

  /// No description provided for @notificationsDenied.
  ///
  /// In fr, this message translates to:
  /// **'Notifications non autorisées. Vérifiez les réglages de l’iPhone.'**
  String get notificationsDenied;

  /// No description provided for @notificationsReady.
  ///
  /// In fr, this message translates to:
  /// **'Notifications activées.'**
  String get notificationsReady;

  /// No description provided for @passwordError.
  ///
  /// In fr, this message translates to:
  /// **'Email valide et mot de passe de 6 caractères minimum requis.'**
  String get passwordError;

  /// No description provided for @roleClient.
  ///
  /// In fr, this message translates to:
  /// **'Client'**
  String get roleClient;

  /// No description provided for @roleProvider.
  ///
  /// In fr, this message translates to:
  /// **'Prestataire'**
  String get roleProvider;

  /// No description provided for @loadFailed.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de charger le catalogue.'**
  String get loadFailed;

  /// No description provided for @requestFailed.
  ///
  /// In fr, this message translates to:
  /// **'Impossible de traiter la demande.'**
  String get requestFailed;

  /// No description provided for @accessDenied.
  ///
  /// In fr, this message translates to:
  /// **'Cette demande ne vous est pas accessible.'**
  String get accessDenied;

  /// No description provided for @about.
  ///
  /// In fr, this message translates to:
  /// **'Catalogue et tarifs fictifs. Les demandes Firebase sont des données de formation.'**
  String get about;

  /// No description provided for @choose.
  ///
  /// In fr, this message translates to:
  /// **'Choisir cet artisan'**
  String get choose;

  /// No description provided for @chosen.
  ///
  /// In fr, this message translates to:
  /// **'Artisan sélectionné'**
  String get chosen;

  /// No description provided for @favoriteCount.
  ///
  /// In fr, this message translates to:
  /// **'favori(s)'**
  String get favoriteCount;

  /// No description provided for @resultCount.
  ///
  /// In fr, this message translates to:
  /// **'artisan(s)'**
  String get resultCount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
