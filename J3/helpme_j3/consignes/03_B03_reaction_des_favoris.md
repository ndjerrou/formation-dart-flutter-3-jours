# B03 - Le favori réagit à chaque clic

## Objectif

Un clic sur le cœur doit produire une réaction visible et cohérente dans le catalogue, sans demander une autre manipulation pour actualiser l’écran.

## Avant de commencer

- B01 et B02 validés.
- Rester sur le catalogue pendant cette fiche. La cohérence avec la fiche artisan sera testée dans B04.
- Choisir un artisan qui n’est pas encore favori et noter le nombre de favoris affiché avant l’essai : ce nombre sera appelé N.
- Si les essais précédents rendent la situation ambiguë, utiliser une nouvelle session privée de navigateur sur l’application de formation.

## Processus pour reproduire le problème

1. Vérifier que le cœur de l’artisan choisi apparaît vide.
2. Cliquer une fois sur ce cœur.
3. Observer immédiatement le cœur et le compteur, sans modifier la recherche.
4. Saisir ensuite le nom de cette personne dans la recherche et observer de nouveau.
5. Effacer la recherche, puis essayer d’enlever ce favori par un second clic.
6. Noter la différence entre la réaction au clic et la réaction après une autre manipulation.

## Ce que l’on observe dans la version de départ

Le cœur et le compteur peuvent rester inchangés après le clic. Une manipulation ultérieure, comme une recherche, peut faire apparaître une modification qui semblait ne pas avoir été prise en compte.

## Résultat attendu

- L’ajout au favori remplit le cœur et augmente le compteur d’une unité.
- Le retrait vide le cœur et ramène le compteur à sa valeur précédente.
- Le résultat apparaît au clic, sans devoir rechercher, changer d’écran ou actualiser le navigateur.
- Les autres artisans conservent leur propre sélection.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| Je pars d’un cœur vide et je clique une fois. | Le cœur devient plein et le compteur passe de N à N + 1. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je clique une seconde fois sur ce même cœur. | Le cœur redevient vide et le compteur revient à N. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je mets deux artisans différents en favoris. | Les deux cœurs sont pleins et le compteur augmente de deux. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je retire un seul de ces deux favoris. | Seul le cœur choisi se vide ; l’autre reste plein. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je fais une recherche après avoir ajouté un favori. | La recherche ne change pas le choix déjà affiché et ne révèle pas un clic jusque-là invisible. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’active « Favoris uniquement » après avoir ajouté un artisan. | Cet artisan figure dans les résultats. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je retire un artisan alors que « Favoris uniquement » est actif. | Sa carte disparaît de cette sélection ; le compteur est cohérent. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] Le cycle ajout → retrait fonctionne plusieurs fois dans le catalogue.
- [ ] Le cœur, le compteur et le filtre racontent la même chose.
- [ ] La conservation après fermeture sera vérifiée dans B07, pas dans cette fiche.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](02_B02_ouvrir_la_bonne_fiche.md) · [Fiche suivante](04_B04_coherence_des_favoris.md)
