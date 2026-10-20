import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/artisan.dart';
import 'local_store.dart';

class CatalogueResultat {
  CatalogueResultat(this.artisans, this.source);
  final List<Artisan> artisans;
  final String source;
}

class CatalogueRepository {
  CatalogueRepository({required this.store, this.url = '', http.Client? client})
    : client = client ?? http.Client();
  final LocalStore store;
  final String url;
  final http.Client client;
  List<Artisan> decoder(String texte) {
    final json = jsonDecode(texte);
    if (json is! List) throw const FormatException('Liste JSON attendue');
    return json
        .map((j) => Artisan.fromJson(Map<String, dynamic>.from(j as Map)))
        .toList();
  }

  Future<CatalogueResultat> charger() async {
    if (url.isEmpty) {
      return CatalogueResultat(
        decoder(await rootBundle.loadString('assets/catalogue.json')),
        'assets',
      );
    }
    try {
      final response = await client
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) {
        throw StateError('HTTP ${response.statusCode}');
      }
      final artisans = decoder(
        utf8.decode(response.bodyBytes).replaceAll('"tarif"', '"prix"'),
      );
      await store.sauverCatalogue(artisans.map((a) => a.toJson()).toList());
      return CatalogueResultat(artisans, 'http');
    } catch (_) {
      final cache = await store.lireCatalogue();
      if (cache == null) rethrow;
      return CatalogueResultat(decoder(jsonEncode(cache)), 'cache');
    }
  }
}
