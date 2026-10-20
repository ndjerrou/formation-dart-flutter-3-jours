// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HelpMe';

  @override
  String get catalogue => 'Artisans';

  @override
  String get requests => 'My requests';

  @override
  String get settings => 'Settings';

  @override
  String get login => 'Sign in';

  @override
  String get logout => 'Sign out';

  @override
  String get email => 'Email address';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign in';

  @override
  String get register => 'Create a client account';

  @override
  String get localMode => 'Local demo — no request is sent to a real artisan.';

  @override
  String get cloudMode => 'Connected to Firebase';

  @override
  String get heroTitle => 'Local skills, close to home.';

  @override
  String get heroSubtitle => 'Find a professional and follow your request.';

  @override
  String get search => 'Name or trade';

  @override
  String get favoritesOnly => 'Favorites only';

  @override
  String get empty => 'No results.';

  @override
  String get retry => 'Try again';

  @override
  String get loading => 'Loading…';

  @override
  String get open => 'View details';

  @override
  String get favorite => 'Favorite';

  @override
  String get send => 'Send request';

  @override
  String get sending => 'Sending…';

  @override
  String get motif => 'Describe your request';

  @override
  String get motifError => 'Enter at least 5 characters.';

  @override
  String get requestSent => 'Request saved';

  @override
  String get pending => 'Pending';

  @override
  String get accepted => 'Accepted';

  @override
  String get refused => 'Refused';

  @override
  String get accept => 'Accept';

  @override
  String get refuse => 'Refuse';

  @override
  String get noRequests => 'No requests yet.';

  @override
  String get requestDetail => 'Request details';

  @override
  String get notFound => 'This page was not found.';

  @override
  String get backCatalogue => 'Back to artisans';

  @override
  String get language => 'Language';

  @override
  String get clientDemo => 'Enter as client';

  @override
  String get providerDemo => 'Enter as provider';

  @override
  String get localAccounts => 'Local demo accounts';

  @override
  String get providerInbox => 'Incoming requests';

  @override
  String get permissions => 'Enable notifications';

  @override
  String get notificationUnavailable =>
      'Real push notifications are available on the iPhone configured with Firebase.';

  @override
  String get copied => 'Copied';

  @override
  String get sourceAssets => 'Bundled catalogue';

  @override
  String get sourceHttp => 'HTTP catalogue';

  @override
  String get sourceCache => 'Cached catalogue — network unavailable';

  @override
  String get errorGeneric => 'Something went wrong. Try again.';

  @override
  String get syncPending => 'Waiting to sync';

  @override
  String get connectedAs => 'Signed-in account';

  @override
  String get hour => '/ hour';

  @override
  String get notAvailable => 'Artisan not found';

  @override
  String get refresh => 'Refresh';

  @override
  String get signInNeeded => 'Sign in to continue.';

  @override
  String get notificationsDenied =>
      'Notifications are not allowed. Check the iPhone settings.';

  @override
  String get notificationsReady => 'Notifications enabled.';

  @override
  String get passwordError =>
      'Enter a valid email and a password of at least 6 characters.';

  @override
  String get roleClient => 'Client';

  @override
  String get roleProvider => 'Provider';

  @override
  String get loadFailed => 'Cannot load catalogue.';

  @override
  String get requestFailed => 'Cannot process request.';

  @override
  String get accessDenied => 'You cannot access this request.';

  @override
  String get about =>
      'Fictional catalogue and prices. Firebase requests are training data.';

  @override
  String get choose => 'Choose this artisan';

  @override
  String get chosen => 'Artisan selected';

  @override
  String get favoriteCount => 'favorite(s)';

  @override
  String get resultCount => 'artisan(s)';
}
