# J3 - Parcours de résolution des bugs

Ce parcours décrit ce que l’application doit faire et comment le vérifier. Il ne
fournit ni correction, ni emplacement de code, ni choix de technique. À vous de mener
l’investigation à partir des comportements observés.

## Commencer

Ouvrir le projet à réparer, puis lancer depuis son dossier :

```bash
flutter pub get
flutter run -d chrome --web-port 8330
```

Conserver la même adresse et le même port pendant les essais de conservation.
Sur iPhone simulateur déjà ouvert, utiliser `flutter devices`, puis
`flutter run -d IDENTIFIANT_SIMULATEUR`.

Garder l’application en mode debug et commencer avec l’interface en français.
La première fiche précise comment obtenir une vue étroite reproductible.
Les noms, métiers et tarifs de la formation sont fictifs.

## La méthode, pour chaque fiche

1. **Lire le contrat** : objectif, prérequis et résultat attendu, avant de modifier quoi que ce soit.
2. **Reproduire exactement** : suivre les actions dans l’ordre et décrire ce que vous voyez réellement.
3. **Conserver une preuve** : capture avant correction, support utilisé et conditions de l’essai.
4. **Formuler une hypothèse** : expliquer ce qui pourrait produire ce comportement. Explorer librement le projet et utiliser le débogueur si utile.
5. **Faire une modification ciblée**, puis relancer le scénario identique. Après un changement au démarrage, un redémarrage complet peut être nécessaire.
6. **Jouer toutes les vérifications** : cocher OK, KO ou Bloqué. Une capture isolée ne remplace pas le scénario complet.
7. **Vérifier les acquis précédents** avant de passer à la fiche suivante.

**OK** : le résultat observé correspond au contrat. **KO** : le scénario est réalisable
mais le résultat ne correspond pas. **Bloqué** : un prérequis manque ; le noter précisément.
Un service non préparé n’est pas une preuve d’un défaut dans votre correction.

Les contrôles automatiques du projet de départ peuvent confirmer la présence des
défauts initiaux. Après réparation, un contrôle qui attend encore un défaut peut
donc échouer : demander au professeur la recette automatique adaptée à l’étape.
Le tableau fonctionnel de chaque fiche reste votre contrat de vérification.

## Ordre des fiches

Suivre le numéro au début du nom. La référence Bxx permet d’identifier le sujet.
B06 précède B05 : on commence par vérifier un échec de chargement compréhensible,
puis la réception correcte du catalogue. Quelques contrôles croisés sont explicitement
reportés jusqu’à ce que les deux fiches soient traitées.

| Ordre | Fiche | Prérequis principaux |
| --- | --- | --- |
| 1 | [B01 - Les cartes restent lisibles sur un petit écran](01_B01_affichage_des_cartes.md) | Application lancée, vue étroite de test |
| 2 | [B02 - Ouvrir la fiche correspondant au résultat choisi](02_B02_ouvrir_la_bonne_fiche.md) | B01 ou vue large |
| 3 | [B03 - Le favori réagit à chaque clic](03_B03_reaction_des_favoris.md) | B01 et B02 |
| 4 | [B04 - Retrouver le même favori d’un écran à l’autre](04_B04_coherence_des_favoris.md) | B02 et B03 |
| 5 | [B06 - Sortir proprement d’un échec de chargement](05_B06_erreur_et_nouvelle_tentative.md) | B01 à B04, service de test indisponible préparé |
| 6 | [B05 - Afficher les informations fournies par le service](06_B05_catalogue_depuis_le_service.md) | B06, service de test disponible préparé |
| 7 | [B07 - Conserver les favoris après fermeture](07_B07_favoris_apres_relance.md) | B03 et B04, même environnement après relance |
| 8 | [B08 - Conserver plusieurs demandes distinctes](08_B08_plusieurs_demandes.md) | Fiches précédentes, compte client de démonstration |
| 9 | [B09 - Voir les demandes et leurs statuts s’actualiser](09_B09_statuts_actualises.md) | B08, comptes client/prestataire |
| 10 | [B10 - Ouvrir la demande liée à une notification](10_B10_notification_et_bonne_demande.md) | B08 et B09, Firebase et iPhone physique préparés |

## Préparer les essais de catalogue réseau

Les fiches réseau demandent un service de test fourni et démarré par le professeur,
avec deux états contrôlés : **disponible** et **indisponible**. Elles ne se reproduisent
pas avec le catalogue embarqué du lancement habituel.

Quand ce service est prêt sur votre poste, utiliser une autre origine de test,
par exemple le port 8340, sans ancien catalogue conservé :

```bash
flutter run -d chrome --web-port 8340 --dart-define=CATALOGUE_URL=http://127.0.0.1:8787/artisans
```

Conserver ensuite cette origine pour comparer les essais réseau. Si l’environnement
est partagé différemment, le professeur fournit l’adresse exacte à utiliser.
La préparation du service n’est pas une recherche de correction dans l’application.

Une erreur après un ancien chargement peut afficher un catalogue local conservé.
C’est un cas différent d’un échec sans aucune donnée disponible : tester les deux
et noter ce qui est affiché. Pour repartir sans ancien catalogue, utiliser une
nouvelle session privée de navigateur sur ce site de formation.

## Préparer les essais de demandes et de notifications

Pour B08 et le premier scénario B09, une seule application locale suffit. Les choix
« Entrer comme client » et « Entrer comme prestataire » se font dans Connexion.
Le prestataire de démonstration correspond à Gérard. Pour changer de compte, ouvrir
Réglages, se déconnecter, puis revenir à Connexion.

L’actualisation entre deux appareils et les vraies notifications exigent l’environnement
Firebase préparé par le professeur. Les notifications ne se vérifient pas en mode local
ni par une simple ouverture de l’application dans le simulateur.

## Journal de validation

Copier ce tableau dans vos notes. Décrire les scénarios, pas seulement « ça marche ».

| Fiche | Symptôme reproduit | Vérifications OK / KO / Bloqué | Preuve conservée | Vérifications précédentes rejouées |
| --- | --- | --- | --- | --- |
| B01 | À renseigner | À renseigner | À renseigner | À renseigner |
| B02 | À renseigner | À renseigner | À renseigner | À renseigner |
| B03 | À renseigner | À renseigner | À renseigner | À renseigner |
| B04 | À renseigner | À renseigner | À renseigner | À renseigner |
| B06 | À renseigner | À renseigner | À renseigner | À renseigner |
| B05 | À renseigner | À renseigner | À renseigner | À renseigner |
| B07 | À renseigner | À renseigner | À renseigner | À renseigner |
| B08 | À renseigner | À renseigner | À renseigner | À renseigner |
| B09 | À renseigner | À renseigner | À renseigner | À renseigner |
| B10 | À renseigner | À renseigner | À renseigner | À renseigner |

Si un essai reste bloqué, noter le prérequis manquant et demander sa préparation.
Si une nouvelle modification fait échouer une ancienne fiche, la résolution n’est
pas encore terminée : reprendre les scénarios concernés avant de continuer.
