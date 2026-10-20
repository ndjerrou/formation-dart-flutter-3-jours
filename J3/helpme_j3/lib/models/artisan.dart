import 'package:json_annotation/json_annotation.dart';
part 'artisan.g.dart';

@JsonSerializable()
class Artisan {
  const Artisan({
    required this.id,
    required this.nom,
    required this.metier,
    required this.tarif,
    required this.icone,
    required this.description,
  });
  final int id;
  final String nom;
  final String metier;
  final int tarif;
  // Une clé sérialisable ; le widget la traduit en IconData.
  final String icone;
  final String description;
  factory Artisan.fromJson(Map<String, dynamic> json) =>
      _$ArtisanFromJson(json);
  Map<String, dynamic> toJson() => _$ArtisanToJson(this);
}
