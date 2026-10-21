# B04 - Retrouver le même favori d’un écran à l’autre

## Objectif

Le catalogue et la fiche d’un artisan doivent présenter le même choix de favori pendant une session d’utilisation.

## Avant de commencer

- B02 et B03 validés : la bonne fiche s’ouvre et les favoris réagissent dans le catalogue.
- Choisir Gérard pour le premier essai. Son cœur doit être vide au début.
- Rester dans la même session ; ne pas arrêter l’application entre les étapes.

## Processus pour reproduire le problème

1. Dans le catalogue, ajouter Gérard aux favoris.
2. Vérifier que son cœur est plein, puis ouvrir sa fiche.
3. Comparer le cœur visible sur la fiche avec celui observé dans le catalogue.
4. Sur la fiche, modifier ce choix puis revenir au catalogue.
5. Observer le cœur, le compteur et, si nécessaire, les résultats de « Favoris uniquement ».

## Ce que l’on observe dans la version de départ

Un écran peut montrer un cœur plein et l’autre un cœur vide pour la même personne. Une modification sur la fiche peut ne pas être retrouvée au retour au catalogue.

## Résultat attendu

- Un favori ajouté dans le catalogue est déjà sélectionné sur la fiche.
- Un favori retiré sur la fiche est retiré dans le catalogue dès le retour.
- Un favori ajouté sur la fiche apparaît également dans le catalogue.
- Ouvrir et fermer une fiche ne modifie pas, à lui seul, les favoris.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| J’ajoute Gérard au catalogue puis j’ouvre sa fiche. | Son cœur est plein sur les deux écrans. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je retire Gérard sur sa fiche puis je reviens. | Son cœur est vide au catalogue et le compteur a diminué d’une unité. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’ouvre la fiche d’un artisan non favori et je l’y ajoute. | Au retour, sa carte est sélectionnée et le compteur a augmenté d’une unité. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’ouvre puis ferme plusieurs fois la même fiche sans toucher le cœur. | Le choix reste identique et le compteur ne change pas. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’active « Favoris uniquement » après avoir ajouté un favori sur sa fiche. | Cet artisan est bien présent dans les résultats. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je consulte une autre personne. | Le choix de la première personne ne change pas. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] La circulation catalogue → fiche → catalogue est vérifiée dans les deux sens.
- [ ] Le filtre et le compteur suivent les modifications effectuées sur la fiche.
- [ ] Aucune relance n’est nécessaire pour voir le même choix sur les deux écrans.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](03_B03_reaction_des_favoris.md) · [Fiche suivante](05_B06_erreur_et_nouvelle_tentative.md)
