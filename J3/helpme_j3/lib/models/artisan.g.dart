// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artisan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artisan _$ArtisanFromJson(Map<String, dynamic> json) => Artisan(
  id: (json['id'] as num).toInt(),
  nom: json['nom'] as String,
  metier: json['metier'] as String,
  tarif: (json['tarif'] as num).toInt(),
  icone: json['icone'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$ArtisanToJson(Artisan instance) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'metier': instance.metier,
  'tarif': instance.tarif,
  'icone': instance.icone,
  'description': instance.description,
};
