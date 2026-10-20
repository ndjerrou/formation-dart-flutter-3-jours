# J3 - HelpMe : version de départ

Cette branche contient la version à réparer pendant la journée.
Ouvrir [le projet Flutter](helpme_j3/README.md).

```bash
cd J3/helpme_j3
flutter pub get
flutter run -d chrome --web-port 8310
```

Le catalogue démarre sans cloud. Dix défauts de comportement sont présents pour
le travail en cours. Les tests de `test/` vérifient leur reproduction ; ils ne
constituent pas une recette de livraison. `recette_finale/` décrit le résultat attendu.
