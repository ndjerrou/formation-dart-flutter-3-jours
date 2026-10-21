# B07 - Conserver les favoris après fermeture

## Objectif

Une sélection de favoris doit être retrouvée lorsque l’utilisateur relance l’application sur le même appareil et dans le même environnement.

## Avant de commencer

- B03 et B04 validés : les choix sont déjà cohérents pendant une session.
- Utiliser une session normale de navigateur et conserver exactement la même adresse et le même port.
- Sur simulateur, réutiliser la même application installée, sans la désinstaller.
- Garder l’interface en français et désactiver « Favoris uniquement » pour choisir les personnes de l’essai.

## Processus pour reproduire le problème

1. Noter les favoris déjà présents.
2. Ajouter Gérard et Sophie si nécessaire, puis vérifier leurs cœurs et le compteur.
3. Arrêter réellement l’application ou fermer sa page. Un simple rechargement de code conservant la session en mémoire ne suffit pas.
4. Relancer dans les mêmes conditions et examiner le catalogue.
5. Retirer Gérard, fermer à nouveau, puis relancer une seconde fois.
6. Comparer la sélection retrouvée avec le dernier choix effectué avant la fermeture.

## Ce que l’on observe dans la version de départ

Les favoris peuvent fonctionner pendant l’utilisation puis être perdus à la relance. Un favori retiré peut également réapparaître si le dernier choix n’est pas conservé.

## Résultat attendu

- L’ajout et le retrait sont tous les deux conservés après relance.
- Le compteur et les résultats de « Favoris uniquement » correspondent à la sélection retrouvée.
- Les favoris restent cohérents entre le catalogue et les fiches après redémarrage.
- La conservation attendue concerne le même navigateur et la même origine, ou la même application native ; elle ne promet pas un partage des favoris entre appareils.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| J’ajoute Gérard et Sophie, puis je ferme et relance. | Leurs deux cœurs sont encore pleins. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je retire Gérard puis je ferme et relance. | Gérard reste retiré et Sophie reste sélectionnée. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’active « Favoris uniquement » après cette relance. | Les résultats correspondent exactement aux favoris conservés. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je compare le compteur avec les cartes sélectionnées. | Le nombre est correct. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’ouvre une fiche après la relance. | Son cœur correspond au choix du catalogue. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je retire tous les favoris puis je ferme et relance. | Le compteur reste à zéro ; le filtre des favoris présente un état vide compréhensible. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] Deux fermetures/relances réelles ont été réalisées.
- [ ] Un ajout et un retrait ont tous deux été conservés.
- [ ] L’adresse, le port ou l’installation native sont restés identiques.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](06_B05_catalogue_depuis_le_service.md) · [Fiche suivante](08_B08_plusieurs_demandes.md)
